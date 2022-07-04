/*****************************************************************************
 Copyright 2021 Broadcom Limited.  All rights reserved.

 This program is the proprietary software of Broadcom Limited and/or its
 licensors, and may only be used, duplicated, modified or distributed pursuant
 to the terms and conditions of a separate, written license agreement executed
 between you and Broadcom (an "Authorized License").

 Except as set forth in an Authorized License, Broadcom grants no license
 (express or implied), right to use, or waiver of any kind with respect to the
 Software, and Broadcom expressly reserves all rights in and to the Software
 and all intellectual property rights therein.  IF YOU HAVE NO AUTHORIZED
 LICENSE, THEN YOU HAVE NO RIGHT TO USE THIS SOFTWARE IN ANY WAY, AND SHOULD
 IMMEDIATELY NOTIFY BROADCOM AND DISCONTINUE ALL USE OF THE SOFTWARE.

  Except as expressly set forth in the Authorized License,
 1. This program, including its structure, sequence and organization,
    constitutes the valuable trade secrets of Broadcom, and you shall use all
    reasonable efforts to protect the confidentiality thereof, and to use this
    information only in connection with your use of Broadcom integrated
    circuit products.

 2. TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED "AS IS"
    AND WITH ALL FAULTS AND BROADCOM MAKES NO PROMISES, REPRESENTATIONS OR
    WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH RESPECT
    TO THE SOFTWARE.  BROADCOM SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED
    WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A
    PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS,
    QUIET ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION.
    YOU ASSUME THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE
    SOFTWARE.

 3. TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL BROADCOM OR ITS
    LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT,
    OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO
    YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF BROADCOM HAS BEEN
    ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS
    OF THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR U.S. $1, WHICHEVER
    IS GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF
    ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.
 ******************************************************************************/
#define OEM_USE_OF_DEBUGGER_HEADER_FILES 1

#include <dlfcn.h>
#include <stdexcept>
#include <iostream>
#include <pybind11/pybind11.h>
#include <pybind11/numpy.h>
#include <pybind11/stl.h>
namespace py = pybind11;
using arr_t = py::array_t<uint8_t, 0>;

#include <arcint.h>
#define MACHINE "ARC"
#include <scengine.h>
#include <dbgaccess.h>
#include <sysaccess.h>

const char *const debuggerDllName = ARC_DEBUGGER_DLL;
const char *const debuggerDllFullPath = ARC_TOOLCHAIN_PATH "/bin/" ARC_DEBUGGER_DLL;

extern "C" {
Debugger_engine *get_debugger_engine_interface(const char *const aDllName);
};

struct ARCDBG_Callback: Debugger_engine_callback {
    int MS_CDECL version()  override { return 1; }
    const char *MS_CDECL id()  override { return "test EVI callback"; }
    ARCDBG_Callback() { save_text = false; }
    int MS_CDECL printf(const char *format, ...)  override {
    va_list ap; va_start(ap,format);
    if (save_text) return vsprintf(buf,format,ap);
    else return vprintf(format,ap);
        }
    void set_save(bool save) { save_text = save; }
    char *get_text() { return buf; }
    void clear_text() { *buf = 0; }

private:
    bool save_text;
    char buf[1024];
};

class ARCDBG_SessionType {
private:
    ARCDBG_Callback m_callbacks;
    void *m_dllHdl;
    void *(*m_get_debugger_engine_interface_proc)(void*);
    Debugger_engine *m_di;
    ARC *m_diArc;
public:
    ARCDBG_SessionType(const char *const aCfgFilePath, const char *const aElfFilePath);
    ~ARCDBG_SessionType();

    ARCDBG_SessionType(ARCDBG_SessionType&&) = delete;
    ARCDBG_SessionType(const ARCDBG_SessionType&) = delete;
    ARCDBG_SessionType& operator=(ARCDBG_SessionType&&) = delete;
    ARCDBG_SessionType& operator=(const ARCDBG_SessionType&) = delete;

    int32_t  run();
    int32_t  readReg(const uint32_t aRegNo, uint32_t *const aVal);
    int32_t  writeReg(const uint32_t aRegNo, const uint32_t aVal);
    int32_t  readMem(const uint32_t aAddr, arr_t& aBuf);
    int32_t  writeMem(const uint32_t aAddr, const arr_t& aBuf);
    uint32_t readPC(void);
    uint32_t getAdressOf(const char *const aSym, bool aIsFunc);
    uint32_t getInstructionCount(void);
};

ARCDBG_SessionType::ARCDBG_SessionType(const char *const aCfgFilePath, const char *const aElfFilePath)
    : m_callbacks()
{
    std::string errStr;

    m_dllHdl = dlopen(debuggerDllFullPath, RTLD_GLOBAL | RTLD_LAZY);
    if (nullptr == m_dllHdl) {
        errStr = "Failed to open " ARC_DEBUGGER_DLL;
        goto err1;
    }

    m_get_debugger_engine_interface_proc =
        (void *(*)(void *)) dlsym(m_dllHdl, "get_debugger_engine_interface");
    if (nullptr == m_get_debugger_engine_interface_proc) {
        errStr = "Failed to get the address of get_debugger_engine_interface from " ARC_DEBUGGER_DLL;
        goto err2;
    }

    m_di = (Debugger_engine *) m_get_debugger_engine_interface_proc((void*) ARC_DEBUGGER_DLL);
    if (nullptr == m_di) {
        errStr = "Failed to acquire the debugger engine interface";
        goto err2;
    }

    m_di->initialize(&m_callbacks);
    m_di->specify_argument_file(aCfgFilePath);
    m_di->specify_initial_load_module(aElfFilePath);
    m_diArc = (ARC*) m_di->get_evi();
    if (nullptr == m_diArc) {
        errStr = "Failed to get the ARC debugger interface!";
        goto err2;
    }

    m_diArc->process_property("run_cycles","65536");

    return;

err2:
    dlclose(m_dllHdl);
err1:
    throw std::runtime_error(errStr);
}

ARCDBG_SessionType::~ARCDBG_SessionType()
{
    dlclose(m_dllHdl);
    return;
}

uint32_t ARCDBG_SessionType::getInstructionCount(void)
{
    uint32_t ret = 0;
    readReg(reg_ISS_ICNT, &ret);
    return ret;
}

int32_t ARCDBG_SessionType::readReg(const uint32_t aRegNo, uint32_t *const aVal)
{
    return m_diArc->read_reg(aRegNo, aVal);
}

int32_t ARCDBG_SessionType::writeReg(const uint32_t aRegNo, const uint32_t aVal)
{
    return m_diArc->write_reg(aRegNo, aVal);
}

int32_t ARCDBG_SessionType::run()
{
    uint32_t status32 = 0UL;
    readReg(reg_AC_STATUS32, &status32);
    if (status32 & 1UL) {
        /* CPU is halted. Need to unhalt it apparently before calling run */
        writeReg(reg_AC_STATUS32, status32 & (~(1UL)));
    }
    return m_diArc->run();
}

int32_t ARCDBG_SessionType::readMem(const uint32_t aAddr, arr_t& aBuf)
{
    const uint32_t bufLen = aBuf.size();
    void *const bufPtr = aBuf.mutable_data(0UL);

    return m_diArc->read_memory(aAddr, bufPtr, bufLen, 0UL);
}

int32_t ARCDBG_SessionType::writeMem(const uint32_t aAddr, const arr_t& aBuf)
{
    const uint32_t bufLen = aBuf.size();
    void *const bufPtr = (void *) (const_cast<uint8_t *>(aBuf.data(0UL)));

    return m_diArc->write_memory(aAddr, bufPtr, bufLen, 0UL);
}

uint32_t ARCDBG_SessionType::readPC(void)
{
    uint32_t pc = 0UL;
    readReg(reg_AC_PC, &pc);
    return pc;
}

uint32_t ARCDBG_SessionType::getAdressOf(const char *const aSym, bool aIsFunc)
{
    char cmdBuf[128];

    m_callbacks.set_save(true);
    m_callbacks.clear_text();
    sprintf(cmdBuf, "eval %s%s", aIsFunc ? "" : "&", aSym);
    m_di->process_command(cmdBuf);
    m_callbacks.set_save(false);

    // Now look for = and parse the integer following.
    char *p = m_callbacks.get_text();
    char *eq = strchr(p,'=');
    if (!eq) {
        std::string str("Ubable to find address of ");
        str.append(aSym);
        throw std::runtime_error(str);
    }

    return strtoul(eq+1,0,0);
}

PYBIND11_MODULE(arcdbgcore, m) {
    py::class_<ARCDBG_SessionType>(m, "session")
        .def(py::init<const char *const, const char *const>())
        .def("run", &ARCDBG_SessionType::run)
        .def("read_mem", &ARCDBG_SessionType::readMem)
        .def("write_mem", &ARCDBG_SessionType::writeMem)
        .def("get_address_of", &ARCDBG_SessionType::getAdressOf)
        .def("read_pc", &ARCDBG_SessionType::readPC);
}


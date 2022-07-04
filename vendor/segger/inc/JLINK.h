/*********************************************************************
*                SEGGER MICROCONTROLLER SYSTEME GmbH                 *
*        Solutions for real time microcontroller applications        *
**********************************************************************
*                                                                    *
*        (C) 2004 - 2008    SEGGER Microcontroller Systeme GmbH      *
*                                                                    *
*        Internet: www.segger.com    Support:  support@segger.com    *
*                                                                    *
**********************************************************************
----------------------------------------------------------------------
File    : JLINK.h
Purpose : "C"- level interface of <JLinkARM.dll>
---------------------------END-OF-HEADER------------------------------
*/

#ifndef JLINK_H            //  Avoid multiple inclusion
#define JLINK_H

#include "JLINKARM_Const.h"

#if defined(__cplusplus)
  extern "C" {                // Make sure we have C-declarations in C++ programs
#endif
//
// DLL functions are exported through def file, so no __declspec(dllexport) is necessary
// Applications usually link against JLink-lib or JLinkARM.lib which dynamically loads DLL functions via GetProcAddress(), so no need for __declspec(dllimport)
//
#ifndef JLINK_API
  #ifdef WIN32
    #define JLINK_API
  #else
    #define JLINK_API       __attribute__((visibility("default")))       
  #endif
#endif

/*********************************************************************
*
*       API functions
*
**********************************************************************
*/

JLINK_API U8                      STDCALL   JLINK_Clock                       (void);
JLINK_API void                    STDCALL   JLINK_Close                       (void);
JLINK_API void                    STDCALL   JLINK_ClrBP                       (unsigned BPIndex);
JLINK_API int                     STDCALL   JLINK_ClrBPEx                     (int BPHandle);
JLINK_API void                    STDCALL   JLINK_ClrError                    (void);
JLINK_API void                    STDCALL   JLINK_ClrTDI                      (void);
JLINK_API void                    STDCALL   JLINK_ClrTMS                      (void);
JLINK_API void                    STDCALL   JLINK_ConfigJTAG                  (int IRPre, int DRPre);
JLINK_API void                    STDCALL   JLINK_EnableLog                   (JLINK_LOG* pfLog);
JLINK_API void                    STDCALL   JLINK_EnableLogCom                (JLINK_LOG* pfLog);
JLINK_API char                    STDCALL   JLINK_ETM_IsPresent               (void);
JLINK_API U32                     STDCALL   JLINK_ETM_ReadReg                 (U32 Reg);
JLINK_API void                    STDCALL   JLINK_ETM_WriteReg                (U32 Reg, U32 Data, int AllowDelay);
JLINK_API void                    STDCALL   JLINK_GetConfigData               (int* pIRPre, int* pDRPre);
JLINK_API const char*             STDCALL   JLINK_GetCompileDateTime          (void);
JLINK_API U32                     STDCALL   JLINK_GetDLLVersion               (void);
JLINK_API U32                     STDCALL   JLINK_GetEmuCaps                  (void);
JLINK_API void                    STDCALL   JLINK_GetFirmwareString           (char* s, int BufferSize);
JLINK_API int                     STDCALL   JLINK_GetHWStatus                 (JLINKARM_HW_STATUS* pStat);
JLINK_API int                     STDCALL   JLINK_GetHardwareVersion          (void);
JLINK_API U32                     STDCALL   JLINK_GetId                       (void);
JLINK_API void                    STDCALL   JLINK_GetIdData                   (JTAG_ID_DATA* pIdData);
JLINK_API int                     STDCALL   JLINK_GetIRLen                    (void);
JLINK_API int                     STDCALL   JLINK_GetNumBPUnits               (U32 Type);
JLINK_API int                     STDCALL   JLINK_GetRegisterList             (U32* paList, int MaxNumItems);
JLINK_API const char *            STDCALL   JLINK_GetRegisterName             (U32 RegIndex);
JLINK_API int                     STDCALL   JLINK_GetScanLen                  (void);
JLINK_API U16                     STDCALL   JLINK_GetSelDevice                (void);
JLINK_API U16                     STDCALL   JLINK_GetSpeed                    (void);
JLINK_API void                    STDCALL   JLINK_Go                          (void);
JLINK_API void                    STDCALL   JLINK_GoEx                        (U32 MaxEmulInsts, U32 Flags);
JLINK_API void                    STDCALL   JLINK_GoAllowSim                  (U32 NumInsts);
JLINK_API void                    STDCALL   JLINK_GoIntDis                    (void);
JLINK_API char                    STDCALL   JLINK_Halt                        (void);
JLINK_API char                    STDCALL   JLINK_IsConnected                 (void);
JLINK_API char                    STDCALL   JLINK_IsHalted                    (void);
JLINK_API char                    STDCALL   JLINK_IsOpen                      (void);
JLINK_API int                     STDCALL   JLINK_MeasureSCLen                (int ScanChain);
JLINK_API const char*             STDCALL   JLINK_Open                        (void);
JLINK_API const char*             STDCALL   JLINK_OpenEx                      (JLINK_LOG* pfLog, JLINK_LOG* pfErrorOut);
JLINK_API int                     STDCALL   JLINK_ReadDCC                     (U32* pData, U32 NumItems, int TimeOut);
JLINK_API void                    STDCALL   JLINK_ReadDCCFast                 (U32* pData, U32 NumItems);
JLINK_API U32                     STDCALL   JLINK_ReadICEReg                  (int RegIndex);
JLINK_API int                     STDCALL   JLINK_ReadMem                     (U32 Addr, U32 NumBytes, void* pData);
JLINK_API int                     STDCALL   JLINK_ReadMemEx                   (U32 Addr, U32 NumBytes, void* pData, U32 AccessWidth);
JLINK_API int                     STDCALL   JLINK_ReadMemIndirect             (U32 Addr, U32 NumBytes, void* pData);
JLINK_API int                     STDCALL   JLINK_ReadMemU8                   (U32 Addr, U32 NumItems, U8*  pData, U8* pStatus);
JLINK_API int                     STDCALL   JLINK_ReadMemU16                  (U32 Addr, U32 NumItems, U16* pData, U8* pStatus);
JLINK_API int                     STDCALL   JLINK_ReadMemU32                  (U32 Addr, U32 NumItems, U32* pData, U8* pStatus);
JLINK_API U32                     STDCALL   JLINK_ReadReg                     (ARM_REG RegIndex);
JLINK_API int                     STDCALL   JLINK_Reset                       (void);
JLINK_API void                    STDCALL   JLINK_ResetNoHalt                 (void);
JLINK_API void                    STDCALL   JLINK_ResetPullsRESET             (U8 OnOff);
JLINK_API void                    STDCALL   JLINK_ResetPullsTRST              (U8 OnOff);
JLINK_API void                    STDCALL   JLINK_ResetTRST                   (void);
JLINK_API void                    STDCALL   JLINK_SelDevice                   (U16 DeviceIndex);
JLINK_API char                    STDCALL   JLINK_SelectIP                    (const char* sHost, int Port);
JLINK_API char                    STDCALL   JLINK_SelectUSB                   (int Port);
JLINK_API void                    STDCALL   JLINK_SetBP                       (unsigned BPIndex, U32 Addr);
JLINK_API int                     STDCALL   JLINK_SetBPEx                     (U32 Addr, U32 Type);
JLINK_API int                     STDCALL   JLINK_SetEndian                   (int v);
JLINK_API void                    STDCALL   JLINK_SetErrorOutHandler          (JLINK_LOG* pfErrorOut);
JLINK_API int                     STDCALL   JLINK_SetInitRegsOnReset          (int v);
JLINK_API void                    STDCALL   JLINK_SetMaxSpeed                 (void);
JLINK_API void                    STDCALL   JLINK_SetResetDelay               (int ms);
JLINK_API int                     STDCALL   JLINK_SetResetPara                (int Value);
JLINK_API JLINKARM_RESET_TYPE     STDCALL   JLINK_SetResetType                (JLINKARM_RESET_TYPE ResetType);
JLINK_API void                    STDCALL   JLINK_SetSpeed                    (U32 Speed);
JLINK_API void                    STDCALL   JLINK_SetTDI                      (void);
JLINK_API void                    STDCALL   JLINK_SetTMS                      (void);
JLINK_API char                    STDCALL   JLINK_Step                        (void);
JLINK_API char                    STDCALL   JLINK_StepComposite               (void);
JLINK_API void                    STDCALL   JLINK_StoreBits                   (U32 TMS, U32 TDI, int NumBits);
JLINK_API int                     STDCALL   JLINK_Test                        (void);
JLINK_API U16                     STDCALL   JLINK_UpdateFirmware              (void);
JLINK_API U32                     STDCALL   JLINK_UpdateFirmwareIfNewer       (void);
JLINK_API int                     STDCALL   JLINK_WaitDCCRead                 (int TimeOut);
JLINK_API int                     STDCALL   JLINK_WriteDCC                    (const U32* pData, U32 NumItems, int TimeOut);
JLINK_API void                    STDCALL   JLINK_WriteDCCFast                (const U32* pData, U32 NumItems);
JLINK_API void                    STDCALL   JLINK_WriteICEReg                 (U32 RegIndex, U32 Value, int AllowDelay);
JLINK_API int                     STDCALL   JLINK_WriteMem                    (U32 Addr, U32 Count, const void* pData);
JLINK_API int                     STDCALL   JLINK_WriteMemDelayed             (U32 Addr, U32 Count, const void* pData);
JLINK_API char                    STDCALL   JLINK_WriteReg                    (ARM_REG RegIndex, U32 Data);
JLINK_API int                     STDCALL   JLINK_WriteU8                     (U32 Addr, U8  Data);
JLINK_API int                     STDCALL   JLINK_WriteU16                    (U32 Addr, U16 Data);
JLINK_API int                     STDCALL   JLINK_WriteU32                    (U32 Addr, U32 Data);
JLINK_API int                     STDCALL   JLINK_ClrWP                       (int WPHandle);
JLINK_API void                    STDCALL   JLINK_EnableSoftBPs               (char Enable);
JLINK_API int                     STDCALL   JLINK_ExecCommand                 (const char* pIn, char* pOut, int BufferSize);
JLINK_API int                     STDCALL   JLINK_FindBP                      (U32 Addr);
JLINK_API void                    STDCALL   JLINK_GetFeatureString            (char* pOut);
JLINK_API unsigned                STDCALL   JLINK_GetNumBPs                   (void);
JLINK_API unsigned                STDCALL   JLINK_GetNumWPs                   (void);
JLINK_API char                    STDCALL   JLINK_GetOEMString                (char* pOut);
JLINK_API int                     STDCALL   JLINK_GetSN                       (void);
JLINK_API U32                     STDCALL   JLINK_GetU32                      (int BitOff);
JLINK_API int                     STDCALL   JLINK_ReadMemHW                   (U32 Addr, U32 Count, void* pData);
JLINK_API int                     STDCALL   JLINK_SetWP                       (U32 Addr, U32 AddrMask, U32 Data, U32 DataMask, U8 Ctrl, U8 CtrlMask);
JLINK_API char                    STDCALL   JLINK_SimulateInstruction         (U32 Inst);
JLINK_API void                    STDCALL   JLINK_ETM_StartTrace              (void);
JLINK_API int                     STDCALL   JLINK_EnableCheckModeAfterWrite   (int OnOff);
JLINK_API void                    STDCALL   JLINK_EnableFlashCache            (char Enable);
JLINK_API int                     STDCALL   JLINK_HasError                    (void);
JLINK_API void                    STDCALL   JLINK_SetLogFile                  (const char* sFilename);
JLINK_API int                     STDCALL   JLINK_CP15_ReadReg                (unsigned RegIndex, U32 * pData);
JLINK_API int                     STDCALL   JLINK_WriteEmuConfigMem           (const U8 * p, U32 Off, U32 NumBytes);
JLINK_API int                     STDCALL   JLINK_ReadEmuConfigMem            (U8 * p, U32 Off, U32 NumBytes);
JLINK_API int                     STDCALL   JLINK_ReadCodeMem                 (U32 Addr, U32 NumBytes, void* pData);
JLINK_API void                    STDCALL   JLINK_ClrRESET                    (void);
JLINK_API void                    STDCALL   JLINK_SetRESET                    (void);
JLINK_API void                    STDCALL   JLINK_ClrTRST                     (void);
JLINK_API void                    STDCALL   JLINK_SetTRST                     (void);
JLINK_API int                     STDCALL   JLINK_WriteMemEx                  (U32 Addr, U32 NumBytes, const void * p, U32 AccessWidth);
JLINK_API int                     STDCALL   JLINK_WriteVerifyMem              (U32 Addr, U32 NumBytes, const void * p, U32 AccessWidth);
JLINK_API int                     STDCALL   JLINK_GetBPInfoEx                 (int iBP, JLINKARM_BP_INFO* pInfo);
JLINK_API int                     STDCALL   JLINK_MeasureCPUSpeed             (U32 RAMAddr, int PreserveMem);
JLINK_API int                     STDCALL   JLINK_ReadControlReg              (U32 RegIndex, U32* pData);
JLINK_API int                     STDCALL   JLINK_WriteControlReg             (U32 RegIndex, U32   Data);
JLINK_API int                     STDCALL   JLINK_ReadDebugReg                (U32 RegIndex, U32* pData);
JLINK_API int                     STDCALL   JLINK_WriteDebugReg               (U32 RegIndex, U32   Data);
JLINK_API int                     STDCALL   JLINK_ReadConfigReg               (U32 RegIndex, U32* pData);
JLINK_API int                     STDCALL   JLINK_WriteConfigReg              (U32 RegIndex, U32   Data);
JLINK_API void                    STDCALL   JLINK_SetWarnOutHandler           (JLINK_LOG* pfWarnOut);
JLINK_API int                     STDCALL   JLINK_Communicate                 (const void* pWrite, int WrSize, void* pRead, int RdSize);
JLINK_API int                     STDCALL   JLINK_Connect                     (void);
JLINK_API int                     STDCALL   JLINK_EMU_HasCPUCap               (U32 CPUCap);
JLINK_API int                     STDCALL   JLINK_EMU_HasCapEx                (int CapEx);
JLINK_API int                     STDCALL   JLINK_EMU_SelectIP                (char* pIPAddr, int BufferSize, U16* pPort);
JLINK_API int                     STDCALL   JLINK_EMU_GetCounters             (U32 BitMask, U32* pCounters);
JLINK_API void                    STDCALL   JLINK_EMU_GetDeviceInfo           (U32 iEmu, JLINKARM_EMU_INFO* pInfo);
JLINK_API int                     STDCALL   JLINK_EMU_GetNumConnections       (void);
JLINK_API U32                     STDCALL   JLINK_EMU_GetNumDevices           (void);
JLINK_API int                     STDCALL   JLINK_EMU_GetProductId            (void);
JLINK_API void                    STDCALL   JLINK_EMU_GetProductName          (char* pBuffer, U32 BufferSize);
JLINK_API U32                     STDCALL   JLINK_EMU_SelectByIndex           (U32 iEmu);
JLINK_API int                     STDCALL   JLINK_EMU_SelectByUSBSN           (U32 SerialNo);
JLINK_API char                    STDCALL   JLINK_EMU_IsConnected             (void);
JLINK_API U32                     STDCALL   JLINK_EMU_GetMaxMemBlock          (void);
JLINK_API int                     STDCALL   JLINK_EMU_TestNWSpeed             (U32 NumReps, U32 NumBytes);
JLINK_API int                     STDCALL   JLINK_EMU_TestNRSpeed             (U32 NumReps, U32 NumBytes);
JLINK_API int                     STDCALL   JLINK_EMU_COM_Read                (unsigned Channel, unsigned NumBytes,       void* pData);
JLINK_API int                     STDCALL   JLINK_EMU_COM_Write               (unsigned Channel, unsigned NumBytes, const void* pData);
JLINK_API int                     STDCALL   JLINK_EMU_COM_IsSupported         (void);
JLINK_API int                     STDCALL   JLINK_EMU_FILE_Delete             (const char* sFile);
JLINK_API int                     STDCALL   JLINK_EMU_FILE_GetSize            (const char* sFile);
JLINK_API int                     STDCALL   JLINK_EMU_FILE_GetList            (const char* sFile, char* pBuffer, U32 BufferSize);
JLINK_API int                     STDCALL   JLINK_EMU_FILE_Write              (const char* sFile, const U8* pData, U32 Offset, U32 NumBytes);
JLINK_API int                     STDCALL   JLINK_EMU_FILE_Read               (const char* sFile,       U8* pData, U32 Offset, U32 NumBytes);
JLINK_API U32                     STDCALL   JLINK_JTAG_GetDeviceId            (unsigned DeviceIndex);
JLINK_API void                    STDCALL   JLINK_JTAG_GetData                (U8* pTDO, int BitPos, int NumBits);
JLINK_API U32                     STDCALL   JLINK_JTAG_GetU8                  (int BitPos);
JLINK_API U32                     STDCALL   JLINK_JTAG_GetU16                 (int BitPos);
JLINK_API U32                     STDCALL   JLINK_JTAG_GetU32                 (int BitPos);
JLINK_API void                    STDCALL   JLINK_JTAG_StoreGetData           (const U8* pTDI, U8* pTDO, int NumBits);
JLINK_API void                    STDCALL   JLINK_JTAG_StoreGetRaw            (const U8* pTDI, U8* pTDO, const U8* pTMS, U32 NumBits);
JLINK_API int                     STDCALL   JLINK_JTAG_StoreInst              (const U8* pTDI, int NumBits);
JLINK_API int                     STDCALL   JLINK_JTAG_StoreData              (const U8* pTDI, int NumBits);
JLINK_API int                     STDCALL   JLINK_JTAG_StoreRaw               (const U8* pTDI, const U8* pTMS, U32 NumBits);
JLINK_API void                    STDCALL   JLINK_JTAG_SyncBits               (void);
JLINK_API void                    STDCALL   JLINK_JTAG_SyncBytes              (void);
JLINK_API int                     STDCALL   JLINK_JTAG_WriteData              (const U8* pTDI, U8* pTDO, int NumBits);
JLINK_API void                    STDCALL   JLINK_JTAG_ConfigDevices          (U32 NumDevices, const JLINKARM_JTAG_DEVICE_CONF* paConf);
JLINK_API void                    STDCALL   JLINK_SWD_GetData                 (U8* pOut, int BitPos, int NumBits);
JLINK_API U32                     STDCALL   JLINK_SWD_GetU8                   (int BitPos);
JLINK_API U32                     STDCALL   JLINK_SWD_GetU16                  (int BitPos);
JLINK_API U32                     STDCALL   JLINK_SWD_GetU32                  (int BitPos);
JLINK_API void                    STDCALL   JLINK_SWD_StoreGetRaw             (const U8* pDir, const U8* pIn, U8* pOut, U32 NumBits);
JLINK_API int                     STDCALL   JLINK_SWD_StoreRaw                (const U8* pDir, const U8* pIn, U32 NumBits);
JLINK_API void                    STDCALL   JLINK_SWD_SyncBits                (void);
JLINK_API void                    STDCALL   JLINK_SWD_SyncBytes               (void);

/*********************************************************************
*
*       TRACE API functions
*
*  NOTE: Most functions require J-Trace
*
**********************************************************************
*/

JLINK_API U32                     STDCALL   JLINK_TRACE_Control               (U32 Cmd, U32 * p);
JLINK_API U32                     STDCALL   JLINK_TRACE_Read                  (JLINKARM_TRACE_DATA * pData, U32 Off, U32 * pNumItems);
JLINK_API void                    STDCALL   JLINK_TRACE_AddItems              (const JLINKARM_TRACE_DATA * pData, U32 NumItems);
JLINK_API void                    STDCALL   JLINK_TRACE_AddInst               (U32 Inst, U32 BAddr);

JLINK_API void                    STDCALL   JLINK_AddMirrorArea               (U32 Addr);
JLINK_API void                    STDCALL   JLINK_AddMirrorAreaEx             (U32 Addr, U32 Size);
JLINK_API void                    STDCALL   JLINK_BeginDownload               (U32 Flags);
JLINK_API int                     STDCALL   JLINK_ClrDataEvent                (U32 Handle);
JLINK_API int                     STDCALL   JLINK_ClrTCK                      (void);
JLINK_API void                    STDCALL   JLINK_ClrExecTime                 (void);
JLINK_API void                    STDCALL   JLINK_DownloadECode               (const U8 * pECode, U32 NumBytes);
JLINK_API void                    STDCALL   JLINK_EnablePerformanceCnt        (U32 Index, U32 OnOff);
JLINK_API int                     STDCALL   JLINK_EndDownload                 (void);
JLINK_API void                    STDCALL   JLINK_ExecECode                   (void);
JLINK_API int                     STDCALL   JLINK_GetBPInfoEx                 (int iBP, JLINKARM_BP_INFO* pInfo);
JLINK_API int                     STDCALL   JLINK_GetDebugInfo                (U32 Index, U32* pInfo);
JLINK_API int                     STDCALL   JLINK_GetDeviceFamily             (void);
JLINK_API int                     STDCALL   JLINK_GetEmbeddedFWString         (const char* sFWId, char* pBuffer, U32 BufferSize); 
JLINK_API void                    STDCALL   JLINK_GetEmuCapsEx                (U8* pCaps, int BufferSize);
JLINK_API int                     STDCALL   JLINK_GetHWInfo                   (U32 BitMask, U32* pHWInfo);
JLINK_API int                     STDCALL   JLINK_GetMOEs                     (JLINKARM_MOE_INFO* pInfo, int MaxNumMOEs);
JLINK_API int                     STDCALL   JLINK_GetNumWPUnits               (void);
JLINK_API U32                     STDCALL   JLINK_GetPerformanceCnt           (U32 Index);
JLINK_API void*                   STDCALL   JLINK_GetpSharedMem               (void);
JLINK_API int                     STDCALL   JLINK_GetResetTypeDesc            (int ResetType, const char** psResetName, const char** psResetDesc);
JLINK_API void                    STDCALL   JLINK_GetSpeedInfo                (JLINKARM_SPEED_INFO * pSpeedInfo);
JLINK_API void                    STDCALL   JLINK_GetExecTime                 (U32 * pExecTimeLow, U32 * pExecTimeHigh);
JLINK_API int                     STDCALL   JLINK_GetWPInfoEx                 (int iWP, JLINKARM_WP_INFO* pInfo);
JLINK_API int                     STDCALL   JLINK_GoHalt                      (U32 NumClocks);
JLINK_API void                    STDCALL   JLINK_Lock                        (void);
JLINK_API int                     STDCALL   JLINK_MeasureCPUSpeedEx           (U32 RAMAddr, int PreserveMem, int AllowFail);
JLINK_API int                     STDCALL   JLINK_MeasureRTCKReactTime        (JLINKARM_RTCK_REACT_INFO* pReactInfo);
JLINK_API int                     STDCALL   JLINK_ReadTerminal                (U8 * pBuffer, U32 BufferSize);
JLINK_API int                     STDCALL   JLINK_ReadDebugPort               (U32 RegIndex, U32* pData);
JLINK_API int                     STDCALL   JLINK_ReadEmu                     (void * p, U32 NumBytes);
JLINK_API int                     STDCALL   JLINK_ReadMemU64                  (U32 Addr, U32 NumItems, U64* pData, U8* pStatus);
JLINK_API int                     STDCALL   JLINK_ReadRegs                    (const U32* paRegIndex, U32* paData, U8* paStatus, U32 NumRegs);
JLINK_API void                    STDCALL   JLINK_SelectDeviceFamily          (int DeviceFamily);
JLINK_API int                     STDCALL   JLINK_SetDataEvent                (JLINKARM_DATA_EVENT* pEvent, U32* pHandle);
JLINK_API void                    STDCALL   JLINK_SetDebugUnitBlockMask       (int Type, U32 Mask);
JLINK_API int                     STDCALL   JLINK_SetTCK                      (void);
JLINK_API void                    STDCALL   JLINK_SelectTraceSource           (int Source);
JLINK_API void                    STDCALL   JLINK_SetWaitFunction             (JLINKARM_WAIT_FUNC* pfWait, void* pContext);
JLINK_API void                    STDCALL   JLINK_Unlock                      (void);
JLINK_API int                     STDCALL   JLINK_UpdateReplaceFirmware       (int Replace, const char* sInfo);
JLINK_API int                     STDCALL   JLINK_WaitForHalt                 (int Timeout);
JLINK_API int                     STDCALL   JLINK_WriteDebugPort              (U32 RegIndex, U32 Data);
JLINK_API int                     STDCALL   JLINK_WriteEmu                    (const void * p, U32 NumBytes);
JLINK_API int                     STDCALL   JLINK_WriteMemHW                  (U32 Addr, U32 NumBytes, const void * p);
JLINK_API int                     STDCALL   JLINK_WriteRegs                   (const U32* paRegIndex, const U32* paData, U8* paStatus, U32 NumRegs);
JLINK_API int                     STDCALL   JLINK_WriteU64                    (U32 Addr, U64 Data);
JLINK_API int                     STDCALL   JLINK_WriteVectorCatch            (U32 Value);
JLINK_API int                     STDCALL   JLINK_DEVICE_GetInfo              (int DeviceIndex, JLINKARM_DEVICE_INFO* pDeviceInfo);
JLINK_API void                    STDCALL   JLINK_INDICATORS_SetState         (int NumStates, JLINKARM_INDICATOR_CTRL* pState);
JLINK_API void                    STDCALL   JLINK_NET_Close                   (void);
JLINK_API int                     STDCALL   JLINK_NET_Open                    (void);
JLINK_API void                    STDCALL   JLINK_TIF_GetAvailable            (U32* pMask);
JLINK_API int                     STDCALL   JLINK_TIF_Select                  (int Interface);
JLINK_API char                    STDCALL   JLINK_WA_AddRange                 (U32 Addr, U32 NumBytes);
JLINK_API char                    STDCALL   JLINK_WA_Restore                  (void);
JLINK_API U32                     STDCALL   JLINK_CORE_GetFound               (void);
JLINK_API void                    STDCALL   JLINK_CORE_Select                 (U32 Core);
JLINK_API int                     STDCALL   JLINK_CORESIGHT_Configure         (const char* sConfig);
JLINK_API int                     STDCALL   JLINK_CORESIGHT_ReadAPDPReg       (U8 RegIndex, U8 APnDP, U32* pData);
JLINK_API int                     STDCALL   JLINK_CORESIGHT_WriteAPDPReg      (U8 RegIndex, U8 APnDP, U32 Data);
JLINK_API int                     STDCALL   JLINK_CP15_IsPresent              (void);
JLINK_API int                     STDCALL   JLINK_CP15_ReadEx                 (U8 CRn, U8 CRm, U8 op1, U8 op2, U32* pData);
JLINK_API int                     STDCALL   JLINK_CP15_WriteEx                (U8 CRn, U8 CRm, U8 op1, U8 op2, U32 Data);
JLINK_API int                     STDCALL   JLINK_CP15_WriteReg               (U32 RegIndex, U32 Data);
JLINK_API void                    STDCALL   JLINK_EMU_SelectIPBySN            (U32 SerialNo);
JLINK_API int                     STDCALL   JLINK_EMU_GetList                 (int HostIFs, JLINKARM_EMU_CONNECT_INFO * paConnectInfo, int MaxInfos);
JLINK_API int                     STDCALL   JLINK_PCODE_Exec                  (U8 * pPCode, U32 NumBytes, JLINKARM_EMU_PCODE_STATUS_INFO * pPCodeStat);
JLINK_API int                     STDCALL   JLINK_PCODE_GetCaps               (U32 * pCaps);
JLINK_API int                     STDCALL   JLINK_PCODE_GetS32Version         (U32 * pVersion);
JLINK_API char                    STDCALL   JLINK_ETB_IsPresent               (void);
JLINK_API U32                     STDCALL   JLINK_ETB_ReadReg                 (U32 RegIndex);
JLINK_API void                    STDCALL   JLINK_ETB_WriteReg                (U32 RegIndex, U32 Data, int AllowDelay);
JLINK_API int                     STDCALL   JLINK_JTAG_DisableIF              (void);
JLINK_API int                     STDCALL   JLINK_JTAG_EnableIF               (void);
JLINK_API int                     STDCALL   JLINK_JTAG_GetDeviceInfo          (unsigned DeviceIndex, JLINKARM_JTAG_DEVICE_INFO * pDeviceInfo);
JLINK_API int                     STDCALL   JLINK_SWD_SetDirOut               (void);
JLINK_API int                     STDCALL   JLINK_SWD_SetDirIn                (void);
JLINK_API int                     STDCALL   JLINK_SWD_EnableSWCLK             (void);
JLINK_API int                     STDCALL   JLINK_SWD_DisableSWCLK            (void);
JLINK_API int                     STDCALL   JLINK_RAWTRACE_Control            (U32 Cmd, void* pData);
JLINK_API int                     STDCALL   JLINK_RAWTRACE_Read               (U8* pData, U32 NumBytes);
JLINK_API int                     STDCALL   JLINK_SWO_Control                 (U32 Cmd, void* pData);
JLINK_API void                    STDCALL   JLINK_SWO_Read                    (U8* pData, U32 Offset, U32* pNumBytes);
JLINK_API int                     STDCALL   JLINK_FLASH_EraseChip             (void);
JLINK_API void                    STDCALL   JLINK_FLASH_SetNotifyHandler      (JLINKARM_FLASH_NOTIFY_FUNC * pfNotify);
JLINK_API U16                     STDCALL   JLINK_GetEmbeddedFWVersion        (void);                           // Used by IAR V4.31A - Do NOT remove
JLINK_API int                     STDCALL   JLINK_StoreCmd                    (U8 Cmd);                         // Used by IAR V4.31A - Do NOT remove
JLINK_API void                    STDCALL   JLINK_WriteBits                   (void);                           // Used by IAR V4.31A - Do NOT remove

// Not yet implemented
//JLINK_API char                    STDCALL   JLINK_HaltNoSave                  (void);
//JLINK_API void                    STDCALL   JLINK_ReadWriteData               (const U8* pTDI, U8* pTDO, int NumBits);
//JLINK_API int                     STDCALL   JLINK_ReadMemTimed                (U32 Addr, U32 Size, void* pData, int TimeOut);

//
// Backward compatibility, do not use
//
JLINK_API void                    STDCALL   JLINK_SetFlashArea                (U32 Addr, U32 Size, const void* pFlashAPI);

#if defined(__cplusplus)
}     /* Make sure we have C-declarations in C++ programs */
#endif

#endif

/************************** end of file *****************************/

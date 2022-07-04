/*********************************************************************
*                SEGGER MICROCONTROLLER SYSTEME GmbH                 *
*        Solutions for real time microcontroller applications        *
**********************************************************************
*                                                                    *
*        (C) 2004 - 2005    SEGGER Microcontroller Systeme GmbH      *
*                                                                    *
*        Internet: www.segger.com    Support:  support@segger.com    *
*                                                                    *
**********************************************************************
----------------------------------------------------------------------
File    : JLinkARMDLL.h
Purpose : "C"- level interface of <JLinkARM.dll>
---------------------------END-OF-HEADER------------------------------
*/

#ifndef JLINKARM_H            //  Avoid multiple inclusion
#define JLINKARM_H

#include "JLINKARM_Const.h"

#if defined(__cplusplus)
  extern "C" {                // Make sure we have C-declarations in C++ programs
#endif
//
// DLL functions are exported through def file, so no __declspec(dllexport) is necessary
// Applications usually link against JLink-lib or JLinkARM.lib which dynamically loads DLL functions via GetProcAddress(), so no need for __declspec(dllimport)
//
#ifdef _WIN32
  #define JLINK_API
  #define JLINKARMDLL_API
  #define JLINKARMDLL_INIT
#else
  #define JLINK_API         __attribute__((visibility("default")))       
  #define JLINKARMDLL_API   __attribute__((visibility("default")))
  #define JLINKARMDLL_INIT  __attribute__((constructor))    // The Linux way of calling an initialization function when a DLL is loaded into memory
#endif

/*********************************************************************
*
*       API functions
*
**********************************************************************
*/

JLINK_API       int                 STDCALL JLINK_Configure                   (const char* pConfig);
JLINK_API       int                 STDCALL JLINK_DownloadFile                (const char* sFileName, U32 Addr);
JLINK_API       int                 STDCALL JLINK_GetAvailableLicense         (char* pBuffer, U32 BufferSize);
JLINK_API       const U8*           STDCALL JLINK_GetPCode                    (int PCodeIndex, U32* pNumBytes);
JLINK_API       const U8*           STDCALL JLINK_GetPCodeEx                  (int PCodeIndex, U32* pNumBytes, const char* sDeviceName);
JLINK_API       int                 STDCALL JLINK_PrintConfig                 (const char* pConfig, U32 Mask, char* pBuffer, U32 BufferSize);
JLINK_API       int                 STDCALL JLINK_EraseChip                   (void);
JLINK_API       int                 STDCALL JLINK_SPI_Transfer                (const U8* pDataDown, U8* pDataUp, U32 NumBits, U32 Flags);
JLINK_API       void*               STDCALL JLINK_GetpFunc                    (JLINK_FUNC_INDEX FuncIndex);

JLINKARMDLL_API void                        JLINKARM_AddMirrorArea            (U32 Addr);
JLINKARMDLL_API void                        JLINKARM_AddMirrorAreaEx          (U32 Addr, U32 Size);
JLINKARMDLL_API void                        JLINKARM_BeginDownload            (U32 Flags);
JLINKARMDLL_API U8                          JLINKARM_Clock                    (void);
JLINKARMDLL_API void                        JLINKARM_Close                    (void);
JLINKARMDLL_API int                         JLINKARM_ClrBP                    (unsigned BPIndex);
JLINKARMDLL_API int                         JLINKARM_ClrBPEx                  (int BPHandle);
JLINKARMDLL_API int                         JLINKARM_ClrDataEvent             (U32 Handle);
JLINKARMDLL_API void                        JLINKARM_ClrError                 (void);
JLINKARMDLL_API void                        JLINKARM_ClrRESET                 (void);
JLINKARMDLL_API int                         JLINKARM_ClrTCK                   (void);
JLINKARMDLL_API void                        JLINKARM_ClrTDI                   (void);
JLINKARMDLL_API void                        JLINKARM_ClrTMS                   (void);
JLINKARMDLL_API void                        JLINKARM_ClrExecTime              (void);
JLINKARMDLL_API void                        JLINKARM_ClrTRST                  (void);
JLINKARMDLL_API int                         JLINKARM_ClrWP                    (int WPHandle);
JLINKARMDLL_API int                         JLINKARM_Communicate              (const void* pWrite, int WrSize, void* pRead, int RdSize);
JLINKARMDLL_API int                         JLINKARM_CommunicateEx            (const void* pWrite, int WrSize, void* pRead, int RdSize, char IsCommand);
JLINKARMDLL_API void                        JLINKARM_ConfigJTAG               (int IRPre, int DRPre);
JLINKARMDLL_API int                         JLINKARM_Connect                  (void);
JLINKARMDLL_API void                        JLINKARM_Core2CoreName            (U32 Core, char* pBuffer, unsigned BufferSize);
JLINKARMDLL_API int                         JLINKARM_DisassembleInst          (char* pBuffer, U32 BufferSize, U32 Addr);
JLINKARMDLL_API int                         JLINKARM_DisassembleInstEx        (char* pBuffer, U32 BufferSize, U32 Addr, const JLINK_DISASSEMBLY_INFO* pInfo);
JLINKARMDLL_API void                        JLINKARM_DownloadECode            (const U8 * pECode, U32 NumBytes);
JLINKARMDLL_API int                         JLINKARM_EnableCheckModeAfterWrite(int OnOff);
JLINKARMDLL_API void                        JLINKARM_EnableFlashCache         (char Enable);
JLINKARMDLL_API void                        JLINKARM_EnableLog                (JLINKARM_LOG* pfLog);
JLINKARMDLL_API void                        JLINKARM_EnableLogCom             (JLINKARM_LOG* pfLog);
JLINKARMDLL_API void                        JLINKARM_EnablePerformanceCnt     (U32 Index, U32 OnOff);
JLINKARMDLL_API void                        JLINKARM_EnableSoftBPs            (char Enable);
JLINKARMDLL_API int                         JLINKARM_EndDownload              (void);
JLINKARMDLL_API int                         JLINKARM_ExecCommand              (const char* pIn, char* pOut, int BufferSize);
JLINKARMDLL_API void                        JLINKARM_ExecECode                (void);
JLINKARMDLL_API int                         JLINKARM_FindBP                   (U32 Addr);
JLINKARMDLL_API int                         JLINKARM_FreeMem                  (void * pMem);  // Frees memory that has been allocated by the DLL and a pointer to this memory has been returned to the user.
JLINKARMDLL_API U32                         JLINKARM_GetBPInfo                (int BPHandle);
JLINKARMDLL_API int                         JLINKARM_GetBPInfoEx              (int iBP, JLINKARM_BP_INFO* pInfo);
JLINKARMDLL_API const char*                 JLINKARM_GetCompileDateTime       (void);
JLINKARMDLL_API void                        JLINKARM_GetConfigData            (int* pIRPre, int* pDRPre);
JLINKARMDLL_API int                         JLINKARM_GetDebugInfo             (U32 Index, U32* pInfo);
JLINKARMDLL_API int                         JLINKARM_GetDeviceFamily          (void);
JLINKARMDLL_API U32                         JLINKARM_GetDLLVersion            (void);
JLINKARMDLL_API int                         JLINKARM_GetEmbeddedFWString      (const char* sFWId, char* pBuffer, U32 BufferSize);
JLINKARMDLL_API U32                         JLINKARM_GetEmuCaps               (void);
JLINKARMDLL_API void                        JLINKARM_GetEmuCapsEx             (U8* pCaps, int BufferSize);
JLINKARMDLL_API void                        JLINKARM_GetExecTime              (U32 * pExecTimeLow, U32 * pExecTimeHigh);
JLINKARMDLL_API void                        JLINKARM_GetFeatureString         (char* pOut);
JLINKARMDLL_API void                        JLINKARM_GetFirmwareString        (char* s, int BufferSize);
JLINKARMDLL_API int                         JLINKARM_GetHardwareVersion       (void);
JLINKARMDLL_API int                         JLINKARM_GetHWInfo                (U32 BitMask, U32* pHWInfo);
JLINKARMDLL_API int                         JLINKARM_GetHWStatus              (JLINKARM_HW_STATUS* pStat);
JLINKARMDLL_API U32                         JLINKARM_GetId                    (void);
JLINKARMDLL_API void                        JLINKARM_GetIdData                (JTAG_ID_DATA* pIdData);
JLINKARMDLL_API int                         JLINKARM_GetIRLen                 (void);
JLINK_API       int                 STDCALL JLINK_GetMemZones                 (JLINK_MEM_ZONE_INFO* paZoneInfo, int MaxNumZones);
JLINKARMDLL_API int                         JLINKARM_GetMOEs                  (JLINKARM_MOE_INFO* pInfo, int MaxNumMOEs);
JLINKARMDLL_API U32                         JLINKARM_GetNumBPs                (void);
JLINKARMDLL_API int                         JLINKARM_GetNumBPUnits            (U32 Type);
JLINKARMDLL_API unsigned                    JLINKARM_GetNumWPs                (void);
JLINKARMDLL_API int                         JLINKARM_GetNumWPUnits            (void);
JLINKARMDLL_API char                        JLINKARM_GetOEMString             (char* pOut);
JLINKARMDLL_API U32                         JLINKARM_GetPerformanceCnt        (U32 Index);
JLINKARMDLL_API void*                       JLINKARM_GetpSharedMem            (void);
JLINKARMDLL_API int                         JLINKARM_GetRegisterList          (U32* paList, int MaxNumItems);
JLINKARMDLL_API const char *                JLINKARM_GetRegisterName          (U32 RegIndex);
JLINKARMDLL_API int                         JLINKARM_GetResetTypeDesc         (int ResetType, const char** psResetName, const char** psResetDesc);
JLINKARMDLL_API int                         JLINKARM_GetScanLen               (void);
JLINKARMDLL_API U16                         JLINKARM_GetSelDevice             (void);
JLINKARMDLL_API int                         JLINKARM_GetSN                    (void);
JLINKARMDLL_API U16                         JLINKARM_GetSpeed                 (void);
JLINKARMDLL_API void                        JLINKARM_GetSpeedInfo             (JLINKARM_SPEED_INFO * pSpeedInfo);
JLINKARMDLL_API int                         JLINKARM_GetWPInfoEx              (int iWP, JLINKARM_WP_INFO* pInfo);
JLINKARMDLL_API void                        JLINKARM_Go                       (void);
JLINKARMDLL_API void                        JLINKARM_GoAllowSim               (U32 NumInsts);
JLINKARMDLL_API void                        JLINKARM_GoEx                     (U32 MaxEmulInsts, U32 Flags);
JLINKARMDLL_API int                         JLINKARM_GoHalt                   (U32 NumClocks);
JLINKARMDLL_API void                        JLINKARM_GoIntDis                 (void);
JLINKARMDLL_API char                        JLINKARM_Halt                     (void);
JLINKARMDLL_API int                         JLINKARM_HasError                 (void);
JLINKARMDLL_API char                        JLINKARM_IsConnected              (void);
JLINKARMDLL_API char                        JLINKARM_IsHalted                 (void);
JLINKARMDLL_API char                        JLINKARM_IsOpen                   (void);
JLINKARMDLL_API void                        JLINKARM_Lock                     (void);
JLINKARMDLL_API int                         JLINKARM_MeasureCPUSpeed          (U32 RAMAddr, int PreserveMem);
JLINKARMDLL_API int                         JLINKARM_MeasureCPUSpeedEx        (U32 RAMAddr, int PreserveMem, int AllowFail);
JLINKARMDLL_API int                         JLINKARM_MeasureRTCKReactTime     (JLINKARM_RTCK_REACT_INFO* pReactInfo);
JLINKARMDLL_API int                         JLINKARM_MeasureSCLen             (int ScanChain);
JLINKARMDLL_API const char*                 JLINKARM_Open                     (void);
JLINKARMDLL_API const char*                 JLINKARM_OpenEx                   (JLINKARM_LOG* pfLog, JLINKARM_LOG* pfErrorOut);
JLINKARMDLL_API int                         JLINKARM_ReadCodeMem              (U32 Addr, U32 NumBytes, void* pData);
JLINKARMDLL_API int                         JLINKARM_ReadConfigReg            (U32 RegIndex, U32* pData);
JLINKARMDLL_API int                         JLINKARM_ReadControlReg           (U32 RegIndex, U32* pData);   //Reserved for future use. Do not use.
JLINKARMDLL_API int                         JLINKARM_ReadDCC                  (U32* pData, U32 NumItems, int TimeOut);
JLINKARMDLL_API void                        JLINKARM_ReadDCCFast              (U32* pData, U32 NumItems);
JLINKARMDLL_API int                         JLINKARM_ReadTerminal             (U8 * pBuffer, U32 BufferSize);
JLINKARMDLL_API int                         JLINKARM_ReadDebugPort            (U32 RegIndex, U32* pData);
JLINKARMDLL_API int                         JLINKARM_ReadDebugReg             (U32 RegIndex, U32* pData);
JLINKARMDLL_API int                         JLINKARM_ReadEmu                  (      void * p, U32 NumBytes);
JLINKARMDLL_API int                         JLINKARM_ReadEmuConfigMem         (U8 * p, U32 Off, U32 NumBytes);
JLINKARMDLL_API U32                         JLINKARM_ReadICEReg               (int RegIndex);
JLINKARMDLL_API int                         JLINKARM_ReadMem                  (U32 Addr, U32 NumBytes, void* pData);
JLINKARMDLL_API int                         JLINKARM_ReadMemEx                (U32 Addr, U32 NumBytes, void* pData, U32 AccessWidth);
JLINKARMDLL_API int                         JLINKARM_ReadMemHW                (U32 Addr, U32 Count, void* pData);
JLINKARMDLL_API int                         JLINKARM_ReadMemIndirect          (U32 Addr, U32 NumBytes, void* pData);
JLINKARMDLL_API int                         JLINKARM_ReadMemU8                (U32 Addr, U32 NumItems, U8*  pData, U8* pStatus);
JLINKARMDLL_API int                         JLINKARM_ReadMemU16               (U32 Addr, U32 NumItems, U16* pData, U8* pStatus);
JLINKARMDLL_API int                         JLINKARM_ReadMemU32               (U32 Addr, U32 NumItems, U32* pData, U8* pStatus);
JLINKARMDLL_API int                         JLINKARM_ReadMemU64               (U32 Addr, U32 NumItems, U64* pData, U8* pStatus);
JLINK_API       int                 STDCALL JLINK_ReadMemZonedEx              (U32 Addr, U32 NumBytes, void* pData, U32 AccessWidth, const char* sZone);
JLINKARMDLL_API U32                         JLINKARM_ReadReg                  (ARM_REG RegIndex);
JLINKARMDLL_API int                         JLINKARM_ReadRegs                 (const U32* paRegIndex, U32* paData, U8* paStatus, U32 NumRegs);
JLINKARMDLL_API int                         JLINKARM_Reset                    (void);
JLINKARMDLL_API void                        JLINKARM_ResetNoHalt              (void);
JLINKARMDLL_API void                        JLINKARM_ResetPullsRESET          (U8 OnOff);
JLINKARMDLL_API void                        JLINKARM_ResetPullsTRST           (U8 OnOff);
JLINKARMDLL_API void                        JLINKARM_ResetTRST                (void);
JLINKARMDLL_API void                        JLINKARM_SelectDeviceFamily       (int DeviceFamily);
JLINKARMDLL_API char                        JLINKARM_SelectIP                 (const char* sHost, int Port);
JLINKARMDLL_API void                        JLINKARM_SelectTraceSource        (int Source);
JLINKARMDLL_API char                        JLINKARM_SelectUSB                (int Port);
JLINKARMDLL_API int                         JLINKARM_SetBP                    (unsigned BPIndex, U32 Addr);
JLINKARMDLL_API int                         JLINKARM_SetBPEx                  (U32 Addr, U32 TypeFlags);
JLINKARMDLL_API int                         JLINKARM_SetCoreIndex             (unsigned CoreIndex);
JLINKARMDLL_API int                         JLINKARM_SetDataEvent             (JLINKARM_DATA_EVENT* pEvent, U32* pHandle);
JLINKARMDLL_API void                        JLINKARM_SetDebugUnitBlockMask    (int Type, U32 Mask);
JLINKARMDLL_API int                         JLINKARM_SetEndian                (int v);
JLINKARMDLL_API void                        JLINKARM_SetErrorOutHandler       (JLINKARM_LOG* pfErrorOut);
JLINK_API       int                 STDCALL JLINK_SetHookUnsecureDialog       (JLINK_UNSECURE_DIALOG_CB_FUNC* pfHook);
JLINKARMDLL_API int                         JLINKARM_SetInitRegsOnReset       (int v);
JLINKARMDLL_API void                        JLINKARM_SetLogFile               (const char* sFilename);
JLINKARMDLL_API void                        JLINKARM_SetMaxSpeed              (void);
JLINKARMDLL_API void                        JLINKARM_SetRESET                 (void);
JLINKARMDLL_API void                        JLINKARM_SetResetDelay            (int ms);
JLINKARMDLL_API int                         JLINKARM_SetResetPara             (int Value);
JLINKARMDLL_API JLINKARM_RESET_TYPE         JLINKARM_SetResetType             (JLINKARM_RESET_TYPE ResetType);
JLINKARMDLL_API void                        JLINKARM_SetSpeed                 (U32 Speed);
JLINKARMDLL_API int                         JLINKARM_SetTCK                   (void);
JLINKARMDLL_API void                        JLINKARM_SetTDI                   (void);
JLINKARMDLL_API void                        JLINKARM_SetTMS                   (void);
JLINKARMDLL_API void                        JLINKARM_SetTRST                  (void);
JLINKARMDLL_API void                        JLINKARM_SetWaitFunction          (JLINKARM_WAIT_FUNC* pfWait, void* pContext);
JLINKARMDLL_API void                        JLINKARM_SetWarnOutHandler        (JLINKARM_LOG * pfWarnOut);
JLINKARMDLL_API int                         JLINKARM_SetWP                    (U32 Addr, U32 AddrMask, U32 Data, U32 DataMask, U8 Ctrl, U8 CtrlMask);
JLINKARMDLL_API char                        JLINKARM_SimulateInstruction      (U32 Inst);
JLINKARMDLL_API char                        JLINKARM_Step                     (void);
JLINKARMDLL_API void                        JLINKARM_StoreBits                (U32 TMS, U32 TDI, int NumBits);
JLINKARMDLL_API int                         JLINKARM_Test                     (void);
JLINKARMDLL_API void                        JLINKARM_Unlock                   (void);
JLINKARMDLL_API U16                         JLINKARM_UpdateFirmware           (void);
JLINKARMDLL_API U32                         JLINKARM_UpdateFirmwareIfNewer    (void);
JLINKARMDLL_API int                         JLINKARM_UpdateReplaceFirmware    (int Replace, const char* sInfo);
JLINKARMDLL_API int                         JLINKARM_WaitDCCRead              (int TimeOut);
JLINKARMDLL_API int                         JLINKARM_WaitForHalt              (int TimeOut);
JLINKARMDLL_API int                         JLINKARM_WriteConfigReg           (U32 RegIndex, U32   Data);
JLINKARMDLL_API int                         JLINKARM_WriteControlReg          (U32 RegIndex, U32   Data);   //Reserved for future use. Do not use.
JLINKARMDLL_API int                         JLINKARM_WriteDCC                 (const U32* pData, U32 NumItems, int TimeOut);
JLINKARMDLL_API void                        JLINKARM_WriteDCCFast             (const U32* pData, U32 NumItems);
JLINKARMDLL_API int                         JLINKARM_WriteDebugPort           (U32 RegIndex, U32 Data);
JLINKARMDLL_API int                         JLINKARM_WriteDebugReg            (U32 RegIndex, U32 Data);
JLINKARMDLL_API int                         JLINKARM_WriteEmu                 (const void * p, U32 NumBytes);
JLINKARMDLL_API int                         JLINKARM_WriteEmuConfigMem        (const U8 * p, U32 Off, U32 NumBytes);
JLINKARMDLL_API void                        JLINKARM_WriteICEReg              (U32 RegIndex, U32 Value, int AllowDelay);
JLINKARMDLL_API int                         JLINKARM_WriteMem                 (U32 Addr, U32 Count, const void* pData);
JLINKARMDLL_API int                         JLINKARM_WriteMemDelayed          (U32 Addr, U32 Count, const void* pData);
JLINKARMDLL_API int                         JLINKARM_WriteMemEx               (U32 Addr, U32 NumBytes, const void * p, U32 AccessWidth);
JLINKARMDLL_API int                         JLINKARM_WriteMemHW               (U32 Addr, U32 Count, const void * p);
JLINKARMDLL_API int                         JLINKARM_WriteMemMultiple         (JLINK_WRITE_MEM_DESC* paDesc, U32 NumWrites);
JLINKARMDLL_API char                        JLINKARM_WriteReg                 (ARM_REG RegIndex, U32 Data);
JLINKARMDLL_API int                         JLINKARM_WriteRegs                (const U32* paRegIndex, const U32* paData, U8* paStatus, U32 NumRegs);
JLINKARMDLL_API int                         JLINKARM_WriteU8                  (U32 Addr, U8  Data);
JLINKARMDLL_API int                         JLINKARM_WriteU16                 (U32 Addr, U16 Data);
JLINKARMDLL_API int                         JLINKARM_WriteU32                 (U32 Addr, U32 Data);
JLINKARMDLL_API int                         JLINKARM_WriteU64                 (U32 Addr, U64 Data);
JLINK_API       int                 STDCALL JLINK_WriteMemZonedEx             (U32 Addr, U32 NumBytes, const void* p, U32 AccessWidth, const char* sZone);
JLINKARMDLL_API int                         JLINKARM_WriteVectorCatch         (U32 Value);
JLINKARMDLL_API int                         JLINKARM_WriteVerifyMem           (U32 Addr, U32 NumBytes, const void * p, U32 AccessWidth);

/*********************************************************************
*
*       BMI API functions
*/
JLINKARMDLL_API int                         JLINKARM_BMI_Get                  (U32* pBMIMode);
JLINKARMDLL_API int                         JLINKARM_BMI_Set                  (U32 BMIMode);

/*********************************************************************
*
*       CDC API functions
*/
JLINKARMDLL_API int                         JLINKARM_CDC_Read                 (U8 * pData, U32 NumBytes);
JLINKARMDLL_API int                         JLINKARM_CDC_SetBaudrate          (int BaudrateHz);
JLINKARMDLL_API int                         JLINKARM_CDC_SetHookFuncs         (const U8* pData, int NumBytes);
JLINKARMDLL_API int                         JLINKARM_CDC_SetRTSState          (int State);
JLINKARMDLL_API int                         JLINKARM_CDC_SetTimeoutLastCDCRead(int Timeout);
JLINKARMDLL_API int                         JLINKARM_CDC_Write                (const U8 * pData, U32 NumBytes);

/*********************************************************************
*
*       CORE API functions
*/
JLINKARMDLL_API U32                         JLINKARM_CORE_GetFound            (void);
JLINKARMDLL_API void                        JLINKARM_CORE_Select              (U32 Core);

/*********************************************************************
*
*       CORESIGHT API functions
*/

JLINKARMDLL_API int                         JLINKARM_CORESIGHT_Configure      (const char* sConfig);
JLINKARMDLL_API int                         JLINKARM_CORESIGHT_ReadAPDPReg    (U8 RegIndex, U8 APnDP, U32* pData);
JLINKARMDLL_API int                         JLINKARM_CORESIGHT_WriteAPDPReg   (U8 RegIndex, U8 APnDP, U32 Data);

/*********************************************************************
*
*       CP15 API functions
*/
JLINKARMDLL_API int                         JLINKARM_CP15_IsPresent           (void);
JLINKARMDLL_API int                         JLINKARM_CP15_ReadEx              (U8 CRn, U8 CRm, U8 op1, U8 op2, U32* pData);
JLINKARMDLL_API int                         JLINKARM_CP15_ReadReg             (U32 RegIndex, U32 * pData);
JLINKARMDLL_API int                         JLINKARM_CP15_WriteEx             (U8 CRn, U8 CRm, U8 op1, U8 op2, U32 Data);
JLINKARMDLL_API int                         JLINKARM_CP15_WriteReg            (U32 RegIndex, U32 Data);

/*********************************************************************
*
*       DEVICE API functions
*/
JLINKARMDLL_API int                         JLINKARM_DEVICE_GetIndex          (const char* sDeviceName);
JLINKARMDLL_API int                         JLINKARM_DEVICE_GetInfo           (int DeviceIndex, JLINKARM_DEVICE_INFO* pDeviceInfo);
JLINKARMDLL_API int                         JLINKARM_DEVICE_SelectDialog      (void* hParent, U32 Flags, JLINKARM_DEVICE_SELECT_INFO* pInfo);

/*********************************************************************
*
*       DIALOG API functions
*/
JLINK_API       int                 STDCALL JLINK_DIALOG_Configure            (const char* pConfigIn, char* pConfigOut, U32 BufferSize);
JLINK_API       int                 STDCALL JLINK_DIALOG_ConfigureEx          (void* hParent, U32 Mask, const char* pConfigIn, char* pConfigOut, U32 BufferSize);

/*********************************************************************
*
*       EMU API functions
*/
JLINK_API       int                 STDCALL JLINK_EMU_GPIO_GetProps           (JLINK_EMU_GPIO_DESC* paDesc, U32 MaxNumDesc);
JLINK_API       int                 STDCALL JLINK_EMU_GPIO_GetState           (const U8* paIndex, U8* paResult, U32 NumPorts);
JLINK_API       int                 STDCALL JLINK_EMU_GPIO_SetState           (const U8* paIndex, const U8* paState, U8* paResult, U32 NumPorts);
JLINK_API       int                 STDCALL JLINK_EMU_AddLicense              (const char* sLic);
JLINK_API       int                 STDCALL JLINK_EMU_EraseLicenses           (void);
JLINK_API       int                 STDCALL JLINK_EMU_GetLicenses             (char* pBuffer, U32 BufferSize);

JLINKARMDLL_API int                         JLINKARM_EMU_GetCounters          (U32 BitMask, U32* pCounters);
JLINKARMDLL_API void                        JLINKARM_EMU_GetDeviceInfo        (U32 iEmu, JLINKARM_EMU_INFO* pInfo);
JLINKARMDLL_API int                         JLINKARM_EMU_GetList              (int HostIFs, JLINKARM_EMU_CONNECT_INFO * paConnectInfo, int MaxInfos);
JLINKARMDLL_API U32                         JLINKARM_EMU_GetMaxMemBlock       (void);
JLINKARMDLL_API int                         JLINKARM_EMU_GetNumConnections    (void);
JLINKARMDLL_API U32                         JLINKARM_EMU_GetNumDevices        (void);
JLINKARMDLL_API int                         JLINKARM_EMU_GetProductId         (void);
JLINKARMDLL_API void                        JLINKARM_EMU_GetProductName       (char* pBuffer, U32 BufferSize);
JLINKARMDLL_API int                         JLINKARM_EMU_HasCapEx             (int CapEx);
JLINKARMDLL_API int                         JLINKARM_EMU_HasCPUCap            (U32 CPUCap);
JLINKARMDLL_API char                        JLINKARM_EMU_IsConnected          (void);
JLINKARMDLL_API U32                         JLINKARM_EMU_SelectByIndex        (U32 iEmu);
JLINKARMDLL_API int                         JLINKARM_EMU_SelectByUSBSN        (U32 SerialNo);
JLINKARMDLL_API int                         JLINKARM_EMU_SelectIP             (char* pIPAddr, int BufferSize, U16* pPort);
JLINKARMDLL_API void                        JLINKARM_EMU_SelectIPBySN         (U32 SerialNo);
JLINKARMDLL_API int                         JLINKARM_EMU_TestNRSpeed          (U32 NumReps, U32 NumBytes);
JLINKARMDLL_API int                         JLINKARM_EMU_TestNWSpeed          (U32 NumReps, U32 NumBytes);

JLINKARMDLL_API int                         JLINKARM_EMU_COM_IsSupported      (void);
JLINKARMDLL_API int                         JLINKARM_EMU_COM_Read             (unsigned Channel, unsigned NumBytes,       void* pData);
JLINKARMDLL_API int                         JLINKARM_EMU_COM_Write            (unsigned Channel, unsigned NumBytes, const void* pData);

JLINKARMDLL_API int                         JLINKARM_EMU_FILE_Delete          (const char* sFile);
JLINKARMDLL_API int                         JLINKARM_EMU_FILE_GetList         (const char* sFile, char* pBuffer, U32 BufferSize);
JLINKARMDLL_API int                         JLINKARM_EMU_FILE_GetSize         (const char* sFile);
JLINKARMDLL_API int                         JLINKARM_EMU_FILE_Read            (const char* sFile,       U8* pData, U32 Offset, U32 NumBytes);
JLINKARMDLL_API int                         JLINKARM_EMU_FILE_Write           (const char* sFile, const U8* pData, U32 Offset, U32 NumBytes);

/*********************************************************************
*
*       ETB API functions
*/
JLINKARMDLL_API char                        JLINKARM_ETB_IsPresent            (void);
JLINKARMDLL_API U32                         JLINKARM_ETB_ReadReg              (U32 RegIndex);
JLINKARMDLL_API void                        JLINKARM_ETB_WriteReg             (U32 RegIndex, U32 Data, int AllowDelay);

/*********************************************************************
*
*       ETM API functions
*/
JLINKARMDLL_API char                        JLINKARM_ETM_IsPresent            (void);
JLINKARMDLL_API U32                         JLINKARM_ETM_ReadReg              (U32 Reg);
JLINKARMDLL_API void                        JLINKARM_ETM_StartTrace           (void);
JLINKARMDLL_API void                        JLINKARM_ETM_WriteReg             (U32 Reg, U32 Data, int AllowDelay);

/*********************************************************************
*
*       INDICATORS API functions
*/
JLINKARMDLL_API void                        JLINKARM_INDICATORS_SetState      (int NumStates, JLINKARM_INDICATOR_CTRL* pState);

/*********************************************************************
*
*       JTAG API functions
*/
JLINKARMDLL_API void                        JLINKARM_JTAG_ConfigDevices       (U32 NumDevices, const JLINKARM_JTAG_DEVICE_CONF* paConf);
JLINKARMDLL_API int                         JLINKARM_JTAG_DisableIF           (void);
JLINKARMDLL_API int                         JLINKARM_JTAG_EnableIF            (void);
JLINKARMDLL_API void                        JLINKARM_JTAG_GetData             (U8* pTDO, int BitPos, int NumBits);
JLINKARMDLL_API U32                         JLINKARM_JTAG_GetDeviceId         (unsigned DeviceIndex);
JLINKARMDLL_API int                         JLINKARM_JTAG_GetDeviceInfo       (unsigned DeviceIndex, JLINKARM_JTAG_DEVICE_INFO * pDeviceInfo);
JLINKARMDLL_API U32                         JLINKARM_JTAG_GetU8               (int BitPos);
JLINKARMDLL_API U32                         JLINKARM_JTAG_GetU16              (int BitPos);
JLINKARMDLL_API U32                         JLINKARM_JTAG_GetU32              (int BitPos);
JLINKARMDLL_API int                         JLINKARM_JTAG_StoreData           (const U8* pTDI, int NumBits);
JLINKARMDLL_API void                        JLINKARM_JTAG_StoreGetData        (const U8* pTDI, U8* pTDO, U32 NumBits);
JLINKARMDLL_API void                        JLINKARM_JTAG_StoreGetRaw         (const U8* pTDI, U8* pTDO, const U8* pTMS, U32 NumBits);
JLINKARMDLL_API int                         JLINKARM_JTAG_StoreInst           (const U8* pTDI, int NumBits);
JLINKARMDLL_API int                         JLINKARM_JTAG_StoreRaw            (const U8* pTDI, const U8* pTMS, U32 NumBits);
JLINKARMDLL_API void                        JLINKARM_JTAG_SyncBits            (void);
JLINKARMDLL_API void                        JLINKARM_JTAG_SyncBytes           (void);
JLINKARMDLL_API int                         JLINKARM_JTAG_WriteData           (const U8* pTDI, U8* pTDO, int NumBits);

/*********************************************************************
*
*       NET API functions
*/
JLINKARMDLL_API void                        JLINKARM_NET_Close                (void);
JLINKARMDLL_API int                         JLINKARM_NET_Open                 (void);

/*********************************************************************
*
*       PCODE API functions
*/
JLINKARMDLL_API int                         JLINKARM_PCODE_Assemble           (U8** ppDest, U32* pDestSize, const U8* pSrc, JLINKARM_LOG* pfOnError);
JLINKARMDLL_API int                         JLINKARM_PCODE_Exec               (U8 * pPCode, U32 NumBytes, JLINKARM_EMU_PCODE_STATUS_INFO * pPCodeStat);
JLINKARMDLL_API int                         JLINKARM_PCODE_GetCaps            (U32 * pCaps);
JLINKARMDLL_API int                         JLINKARM_PCODE_GetS32Version      (U32 * pVersion);
JLINKARMDLL_API int                         JLINKARM_PCODE_GetDebugAPI        (void* pAPI);

/*********************************************************************
*
*       HSS API functions
*/
JLINK_API       int                 STDCALL JLINK_HSS_GetCaps                 (JLINK_HSS_CAPS* pCaps);
JLINK_API       int                 STDCALL JLINK_HSS_Start                   (JLINK_HSS_MEM_BLOCK_DESC* paDesc, int NumBlocks, int Period_us, int Flags);
JLINK_API       int                 STDCALL JLINK_HSS_Stop                    (void);
JLINK_API       int                 STDCALL JLINK_HSS_Read                    (void* pBuffer, U32 BufferSize);

/*********************************************************************
*
*       POWERTRACE API functions
*/
JLINK_API       int                 STDCALL JLINK_POWERTRACE_Control          (U32 Cmd, void * pIn, void * pOut);
JLINK_API       int                 STDCALL JLINK_POWERTRACE_Read             (JLINK_POWERTRACE_DATA_ITEM * paData, U32 NumItems);

/*********************************************************************
*
*       RAWTRACE API functions
*/
JLINKARMDLL_API int                         JLINKARM_RAWTRACE_Control         (U32 Cmd, void* pData);
JLINKARMDLL_API int                         JLINKARM_RAWTRACE_Read            (U8* pData, U32 NumBytes);

/*********************************************************************
*
*       RTTERMINAL API functions
*/
JLINK_API       int                 STDCALL JLINK_RTTERMINAL_Control          (U32 Cmd, void* p);
JLINK_API       int                 STDCALL JLINK_RTTERMINAL_Read             (U32 BufferIndex,       char* sBuffer, U32 BufferSize);
JLINK_API       int                 STDCALL JLINK_RTTERMINAL_Write            (U32 BufferIndex, const char* sBuffer, U32 BufferSize);

/*********************************************************************
*
*       STRACE API functions
*/
JLINK_API       int                 STDCALL JLINK_STRACE_Config               (const char* sConfig);
JLINK_API       int                 STDCALL JLINK_STRACE_Control              (U32 Cmd, void* pData);
JLINK_API       int                 STDCALL JLINK_STRACE_Read                 (U32* paItem, U32 NumItems);
JLINK_API       int                 STDCALL JLINK_STRACE_Start                (void);
JLINK_API       int                 STDCALL JLINK_STRACE_Stop                 (void);

/*********************************************************************
*
*       SWD API functions
*/
JLINK_API       void                STDCALL JLINK_SWD_GetData                 (U8* pOut, int BitPos, int NumBits);
JLINK_API       U32                 STDCALL JLINK_SWD_GetU8                   (int BitPos);
JLINK_API       U32                 STDCALL JLINK_SWD_GetU16                  (int BitPos);
JLINK_API       U32                 STDCALL JLINK_SWD_GetU32                  (int BitPos);
JLINK_API       void                STDCALL JLINK_SWD_StoreGetRaw             (const U8* pDir, const U8* pIn, U8* pOut, U32 NumBits);
JLINK_API       int                 STDCALL JLINK_SWD_StoreRaw                (const U8* pDir, const U8* pIn, U32 NumBits);
JLINK_API       void                STDCALL JLINK_SWD_SyncBits                (void);
JLINK_API       void                STDCALL JLINK_SWD_SyncBytes               (void);

JLINKARMDLL_API int                         JLINKARM_SWD_DisableSWCLK         (void);
JLINKARMDLL_API int                         JLINKARM_SWD_EnableSWCLK          (void);
JLINKARMDLL_API int                         JLINKARM_SWD_SetDirIn             (void);
JLINKARMDLL_API int                         JLINKARM_SWD_SetDirOut            (void);

#define JLINKARM_SWD_GetData(pOut, BitPos, NumBits)           JLINK_SWD_GetData(pOut, BitPos, NumBits)
#define JLINKARM_SWD_GetU8(BitPos)                            JLINK_SWD_GetU8(BitPos)
#define JLINKARM_SWD_GetU16(BitPos)                           JLINK_SWD_GetU16(BitPos)
#define JLINKARM_SWD_GetU32(BitPos)                           JLINK_SWD_GetU32(BitPos)
#define JLINKARM_SWD_StoreGetRaw(pDir, pIn, pOut, NumBits)    JLINK_SWD_StoreGetRaw(pDir, pIn, pOut, NumBits)
#define JLINKARM_SWD_StoreRaw(pDir, pIn, NumBits)             JLINK_SWD_StoreRaw(pDir, pIn, NumBits)
#define JLINKARM_SWD_SyncBits()                               JLINK_SWD_SyncBits()
#define JLINKARM_SWD_SyncBytes()                              JLINK_SWD_SyncBytes()

/*********************************************************************
*
*       SWO API functions
*/
JLINKARMDLL_API int                         JLINKARM_SWO_Control              (U32 Cmd, void* pData);
JLINKARMDLL_API int                         JLINKARM_SWO_DisableTarget        (U32 PortMask);
JLINKARMDLL_API int                         JLINKARM_SWO_EnableTarget         (U32 CPUSpeed, U32 SWOSpeed, int Mode, U32 PortMask);
JLINKARMDLL_API int                         JLINKARM_SWO_GetCompatibleSpeeds  (U32 CPUSpeed, U32 MaxSWOSpeed, U32* paSWOSpeed, U32 NumEntries);
JLINKARMDLL_API void                        JLINKARM_SWO_Read                 (U8* pData, U32 Offset, U32* pNumBytes);
JLINKARMDLL_API int                         JLINKARM_SWO_ReadStimulus         (int Port, U8* pData, U32 NumBytes);

/*********************************************************************
*
*       TIF API functions
*/
JLINKARMDLL_API void                        JLINKARM_TIF_GetAvailable         (U32* pMask);
JLINKARMDLL_API int                         JLINKARM_TIF_Select               (int Interface);

/*********************************************************************
*
*       TRACE API functions
*/
JLINKARMDLL_API U32                         JLINKARM_TRACE_Control            (U32 Cmd, U32 * p);
JLINKARMDLL_API U32                         JLINKARM_TRACE_Read               (JLINKARM_TRACE_DATA * pData, U32 Off, U32 * pNumItems);

/*********************************************************************
*
*       WA API functions
*/
JLINKARMDLL_API char                        JLINKARM_WA_AddRange              (U32 Addr, U32 NumBytes);
JLINKARMDLL_API char                        JLINKARM_WA_Restore               (void);

JLINK_API       void                STDCALL JLINK_SetFlashProgProgressCallback (JLINK_FLASH_PROGRESS_CB_FUNC* pfOnFlashProgess);

/*********************************************************************
*
*       Obsolete functions, do NOT use anymore
*
**********************************************************************
*/

JLINKARMDLL_API void                        JLINKARM_TRACE_AddInst            (U32 Inst, U32 BAddr);
JLINKARMDLL_API void                        JLINKARM_TRACE_AddItems           (const JLINKARM_TRACE_DATA * pData, U32 NumItems);
JLINKARMDLL_API U32                         JLINKARM_GetDeviceId              (unsigned DeviceIndex);
JLINKARMDLL_API U16                         JLINKARM_GetEmbeddedFWVersion     (void);                           // Used by IAR V4.31A - Do NOT remove
JLINKARMDLL_API U32                         JLINKARM_GetU32                   (int BitOff);                     // Used by IAR V4.31A - Do NOT remove
JLINKARMDLL_API void                        JLINKARM_SelDevice                (U16 DeviceIndex);                // Used by IAR V4.11A - Do NOT remove
JLINKARMDLL_API char                        JLINKARM_StepComposite            (void);
JLINKARMDLL_API int                         JLINKARM_StoreCmd                 (U8 Cmd);                         // Used by IAR V4.31A - Do NOT remove
JLINKARMDLL_API int                         JLINKARM_StoreData                (const U8* pTDI, int NumBits);    // Used by IAR V4.31A - Do NOT remove
JLINKARMDLL_API void                        JLINKARM_WriteBits                (void);                           // Used by IAR V4.31A - Do NOT remove

//
// Backward compatibility, do not use
//
JLINKARMDLL_API void                        JLINKARM_SetFlashArea             (U32 Addr, U32 Size, const void* pFlashAPI);
JLINKARMDLL_API int                         JLINKARM_PERIODIC_ConfReadMem     (U32 Period_us, JLINKARM_READ_DESC* paReadDesc, U32 NumReadDescs);
JLINKARMDLL_API int                         JLINKARM_PERIODIC_Control         (U32 Cmd, void* pData);
JLINKARMDLL_API int                         JLINKARM_PERIODIC_Read            (U8* pData, U32 BufferSize);

#if defined(__cplusplus)
}     /* Make sure we have C-declarations in C++ programs */
#endif

#endif

/************************** end of file *****************************/

/*********************************************************************
*                SEGGER MICROCONTROLLER SYSTEME GmbH                 *
*        Solutions for real time microcontroller applications        *
**********************************************************************
*                                                                    *
*           (C) 2003    SEGGER Microcontroller Systeme GmbH          *
*                                                                    *
*        Internet: www.segger.com    Support:  support@segger.com    *
*                                                                    *
**********************************************************************
----------------------------------------------------------------------
File    : GLOBAL.h
Purpose : Global types etc.
---------------------------END-OF-HEADER------------------------------
*/

#ifndef GLOBAL_H            // Guard against multiple inclusion
#define GLOBAL_H

#include <string.h>         // For memset
#include "TYPES.h"          // Defines standard data types

/*********************************************************************
*
*       Defines, function replacements
*
**********************************************************************
*/

#ifdef WIN32
  #if _MSC_VER > 1300
    #define IS_MSC2010  1
  #else
    #define IS_MSC2010  0
  #endif
#else
  #define IS_MSC2010  0
#endif

#ifndef   COUNTOF
  #define COUNTOF(a)    (sizeof(a)/sizeof(a[0]))
#endif

#ifndef   ZEROFILL
  #define ZEROFILL(Obj) memset(&Obj, 0, sizeof(Obj))
#endif

#ifndef   LIMIT
  #define LIMIT(a,b)    if (a > b) a = b;
#endif

#ifndef   MIN
  #define MIN(a, b)     (((a) < (b)) ? (a) : (b))
#endif

#ifndef   MAX
  #define MAX(a, b)     (((a) > (b)) ? (a) : (b))
#endif

/*********************************************************************
*
*       Types, internal
*
**********************************************************************
*/

typedef enum {IS_NOINIT, IS_RUNNING, IS_EXIT} INIT_STATE;

#endif                      // Avoid multiple inclusion

/*************************** End of file ****************************/

#include "newmacros.h"
#include "runtime.h"

#define CT_v192	((void*)startLabel+36)
#define FN_LAMBDA187	((void*)startLabel+68)
#define CT_v194	((void*)startLabel+116)
#define F0_LAMBDA187	((void*)startLabel+124)
#define CT_v196	((void*)startLabel+168)
#define ST_v190	((void*)startLabel+184)
#define ST_v195	((void*)startLabel+198)
#define ST_v191	((void*)startLabel+216)
#define ST_v193	((void*)startLabel+233)
extern Node TM_Data_46Function[];
extern Node TMSUB_Data_46Function[];
extern Node FN_NHC_46Internal_46_95apply1[];

static Node startLabel[] = {
  bytes2word(0,0,2,0)
, bytes2word(1,1,0,2)
, useLabel(CT_v192)
,};
Node FN_Data_46Function_46on[] = {
  useLabel(TM_Data_46Function)
, bytes2word(NEEDHEAP_I32,PUSH_HEAP,HEAP_CVAL_I3,HEAP_ARG_ARG)
, bytes2word(2,1,RETURN,ENDCODE)
, bytes2word(0,0,0,0)
, 830002
, useLabel(ST_v191)
,	/* CT_v192: (byte 0) */
  HW(1,2)
, 0
,};
Node F0_Data_46Function_46on[] = {
  CAPTAG(useLabel(FN_Data_46Function_46on),2)
, CAPTAG(useLabel(FN_LAMBDA187),2)
, bytes2word(0,0,4,0)
, bytes2word(3,1,2,2)
, bytes2word(1,3,0,4)
, useLabel(CT_v194)
,	/* FN_LAMBDA187: (byte 0) */
  useLabel(TMSUB_Data_46Function)
, bytes2word(NEEDHEAP_I32,PUSH_HEAP,HEAP_CVAL_I3,HEAP_ARG_ARG)
, bytes2word(1,3,PUSH_HEAP,HEAP_CVAL_I3)
, bytes2word(HEAP_ARG_ARG,1,4,PUSH_P1)
, bytes2word(0,PUSH_P1,2,PUSH_ARG_I2)
, bytes2word(ZAP_ARG_I1,ZAP_ARG_I2,ZAP_ARG_I3,ZAP_ARG)
, bytes2word(4,ZAP_STACK_P1,4,ZAP_STACK_P1)
, bytes2word(3,EVAL,NEEDHEAP_I32,APPLY)
, bytes2word(2,RETURN_EVAL,ENDCODE,0)
, bytes2word(0,0,0,0)
, 830016
, useLabel(ST_v193)
,	/* CT_v194: (byte 0) */
  HW(1,4)
, 0
,	/* F0_LAMBDA187: (byte 0) */
  CAPTAG(useLabel(FN_LAMBDA187),4)
, VAPTAG(useLabel(FN_NHC_46Internal_46_95apply1))
, bytes2word(1,0,0,1)
, useLabel(CT_v196)
,};
Node FN_Data_46Function_46fix[] = {
  useLabel(TM_Data_46Function)
, bytes2word(NEEDHEAP_I32,PUSH_HEAP,HEAP_CVAL_I3,HEAP_ARG)
, bytes2word(1,HEAP_OFF_N1,2,PUSH_P1)
, bytes2word(0,RETURN_EVAL,ENDCODE,0)
, bytes2word(0,0,0,0)
, 280001
, useLabel(ST_v195)
,	/* CT_v196: (byte 0) */
  HW(1,1)
, 0
,};
Node F0_Data_46Function_46fix[] = {
  CAPTAG(useLabel(FN_Data_46Function_46fix),1)
, VAPTAG(useLabel(FN_NHC_46Internal_46_95apply1))
,};
Node PM_Data_46Function[] = {
 	/* ST_v190: (byte 0) */
  bytes2word(68,97,116,97)
, bytes2word(46,70,117,110)
, bytes2word(99,116,105,111)
,	/* ST_v195: (byte 2) */
  bytes2word(110,0,68,97)
, bytes2word(116,97,46,70)
, bytes2word(117,110,99,116)
, bytes2word(105,111,110,46)
,	/* ST_v191: (byte 4) */
  bytes2word(102,105,120,0)
, bytes2word(68,97,116,97)
, bytes2word(46,70,117,110)
, bytes2word(99,116,105,111)
, bytes2word(110,46,111,110)
,	/* ST_v193: (byte 1) */
  bytes2word(0,68,97,116)
, bytes2word(97,46,70,117)
, bytes2word(110,99,116,105)
, bytes2word(111,110,46,111)
, bytes2word(110,58,56,51)
, bytes2word(58,49,54,45)
, bytes2word(56,51,58,51)
, bytes2word(52,0,0,0)
,};

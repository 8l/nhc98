#include "newmacros.h"
#include "runtime.h"

#define CT_v178	((void*)startLabel+88)
#define ST_v177	((void*)startLabel+116)
extern Node TM_Char[];
extern Node FN_Prelude_46Ord_46Prelude_46Char_46_62_61[];
extern Node FN_Prelude_46Ord_46Prelude_46Char_46_60_61[];
extern Node FN_Prelude_46_38_38[];
extern Node FN_Prelude_46_124_124[];

static Node startLabel[] = {
  bytes2word(1,0,0,1)
, useLabel(CT_v178)
,};
Node FN_Char_46isUpper[] = {
  useLabel(TM_Char)
, bytes2word(NEEDHEAP_P1,34,HEAP_CVAL_I3,HEAP_ARG)
, bytes2word(1,HEAP_CHAR_P1,65,HEAP_CVAL_I4)
, bytes2word(HEAP_ARG,1,HEAP_CHAR_P1,90)
, bytes2word(HEAP_CVAL_I5,HEAP_OFF_N1,7,HEAP_OFF_N1)
, bytes2word(5,HEAP_CVAL_I3,HEAP_ARG,1)
, bytes2word(HEAP_CHAR_P1,192,HEAP_CVAL_I4,HEAP_ARG)
, bytes2word(1,HEAP_CHAR_P1,214,HEAP_CVAL_I5)
, bytes2word(HEAP_OFF_N1,7,HEAP_OFF_N1,5)
, bytes2word(HEAP_CVAL_I3,HEAP_ARG,1,HEAP_CHAR_P1)
, bytes2word(216,HEAP_CVAL_I4,HEAP_ARG,1)
, bytes2word(HEAP_CHAR_P1,222,HEAP_CVAL_I5,HEAP_OFF_N1)
, bytes2word(7,HEAP_OFF_N1,5,HEAP_CVAL_P1)
, bytes2word(6,HEAP_OFF_N1,13,HEAP_OFF_N1)
, bytes2word(5,PUSH_HEAP,HEAP_CVAL_P1,6)
, bytes2word(HEAP_OFF_N1,25,HEAP_OFF_N1,5)
, bytes2word(RETURN_EVAL,ENDCODE,0,0)
, bytes2word(0,0,0,0)
, 70001
, useLabel(ST_v177)
,	/* CT_v178: (byte 0) */
  HW(4,1)
, 0
,};
Node F0_Char_46isUpper[] = {
  CAPTAG(useLabel(FN_Char_46isUpper),1)
, VAPTAG(useLabel(FN_Prelude_46Ord_46Prelude_46Char_46_62_61))
, VAPTAG(useLabel(FN_Prelude_46Ord_46Prelude_46Char_46_60_61))
, VAPTAG(useLabel(FN_Prelude_46_38_38))
, VAPTAG(useLabel(FN_Prelude_46_124_124))
,	/* ST_v177: (byte 0) */
  bytes2word(67,104,97,114)
, bytes2word(46,105,115,85)
, bytes2word(112,112,101,114)
, bytes2word(0,0,0,0)
,};

#include "newmacros.h"
#include "runtime.h"

#define CT_v298	((void*)startLabel+116)
#define FN_LAMBDA290	((void*)startLabel+176)
#define CT_v301	((void*)startLabel+208)
#define CF_LAMBDA290	((void*)startLabel+216)
#define FN_Text_46Show_46Functions_46Prelude_46165_46getTypes	((void*)startLabel+232)
#define CT_v303	((void*)startLabel+272)
#define F0_Text_46Show_46Functions_46Prelude_46165_46getTypes	((void*)startLabel+280)
#define FN_LAMBDA289	((void*)startLabel+296)
#define CT_v305	((void*)startLabel+320)
#define F0_LAMBDA289	((void*)startLabel+328)
#define FN_LAMBDA288	((void*)startLabel+340)
#define CT_v307	((void*)startLabel+364)
#define F0_LAMBDA288	((void*)startLabel+372)
#define CT_v309	((void*)startLabel+424)
#define FN_LAMBDA291	((void*)startLabel+452)
#define CT_v312	((void*)startLabel+484)
#define CF_LAMBDA291	((void*)startLabel+492)
#define CT_v314	((void*)startLabel+540)
#define CT_v316	((void*)startLabel+604)
#define CT_v318	((void*)startLabel+692)
#define ST_v300	((void*)startLabel+720)
#define ST_v311	((void*)startLabel+725)
#define ST_v317	((void*)startLabel+738)
#define ST_v313	((void*)startLabel+762)
#define ST_v315	((void*)startLabel+791)
#define ST_v308	((void*)startLabel+824)
#define ST_v310	((void*)startLabel+858)
#define ST_v297	((void*)startLabel+904)
#define ST_v299	((void*)startLabel+938)
#define ST_v306	((void*)startLabel+984)
#define ST_v304	((void*)startLabel+1030)
#define ST_v302	((void*)startLabel+1076)
#define ST_v296	((void*)startLabel+1124)
extern Node TM_Text_46Show_46Functions[];
extern Node FN_NHC_46Internal_46_95apply1[];
extern Node CF_Prelude_46undefined[];
extern Node FN_Prelude_46showChar[];
extern Node FN_Prelude_46showsType[];
extern Node FN_Prelude_46showString[];
extern Node FN_Prelude_46_46[];
extern Node TMSUB_Text_46Show_46Functions[];
extern Node FN_Prelude_46Show_46Prelude_46_45_62[];
extern Node FN_Prelude_46_95_46show[];
extern Node FN_Prelude_46_95_46showList[];

static Node startLabel[] = {
  bytes2word(3,0,2,1)
, bytes2word(1,2,0,3)
, useLabel(CT_v298)
,};
Node FN_Prelude_46Show_46Prelude_46_45_62_46showsType[] = {
  useLabel(TM_Text_46Show_46Functions)
, bytes2word(NEEDHEAP_P1,48,HEAP_CVAL_I3,HEAP_ARG)
, bytes2word(3,PUSH_HEAP,HEAP_CVAL_I4,HEAP_OFF_N1)
, bytes2word(3,HEAP_CVAL_I5,PUSH_HEAP,HEAP_CVAL_P1)
, bytes2word(6,HEAP_OFF_N1,4,PUSH_HEAP)
, bytes2word(HEAP_CVAL_P1,7,HEAP_OFF_N1,6)
, bytes2word(HEAP_CVAL_P1,8,HEAP_CVAL_I4,HEAP_OFF_N1)
, bytes2word(2,HEAP_CHAR_P1,40,HEAP_CVAL_P1)
, bytes2word(9,HEAP_ARG,1,HEAP_CVAL_I4)
, bytes2word(HEAP_OFF_N1,3,HEAP_I1,HEAP_CVAL_P1)
, bytes2word(10,HEAP_CVAL_P1,11,HEAP_CVAL_I4)
, bytes2word(HEAP_OFF_N1,3,HEAP_OFF_N1,3)
, bytes2word(HEAP_CVAL_P1,9,HEAP_ARG,2)
, bytes2word(HEAP_CVAL_I4,HEAP_OFF_N1,3,HEAP_P1)
, bytes2word(0,HEAP_CVAL_P1,8,HEAP_CVAL_I4)
, bytes2word(HEAP_OFF_N1,2,HEAP_CHAR_P1,41)
, bytes2word(HEAP_CVAL_P1,12,HEAP_OFF_N1,8)
, bytes2word(HEAP_OFF_N1,5,HEAP_CVAL_P1,12)
, bytes2word(HEAP_OFF_N1,16,HEAP_OFF_N1,5)
, bytes2word(HEAP_CVAL_P1,12,HEAP_OFF_N1,24)
, bytes2word(HEAP_OFF_N1,5,PUSH_HEAP,HEAP_CVAL_P1)
, bytes2word(12,HEAP_OFF_N1,32,HEAP_OFF_N1)
, bytes2word(5,RETURN_EVAL,ENDCODE,0)
, bytes2word(0,0,0,0)
, 310003
, useLabel(ST_v297)
,	/* CT_v298: (byte 0) */
  HW(10,3)
, 0
,};
Node F0_Prelude_46Show_46Prelude_46_45_62_46showsType[] = {
  CAPTAG(useLabel(FN_Prelude_46Show_46Prelude_46_45_62_46showsType),3)
, CAPTAG(useLabel(FN_Text_46Show_46Functions_46Prelude_46165_46getTypes),1)
, VAPTAG(useLabel(FN_NHC_46Internal_46_95apply1))
, useLabel(CF_Prelude_46undefined)
, VAPTAG(useLabel(FN_LAMBDA288))
, VAPTAG(useLabel(FN_LAMBDA289))
, VAPTAG(useLabel(FN_Prelude_46showChar))
, VAPTAG(useLabel(FN_Prelude_46showsType))
, VAPTAG(useLabel(FN_Prelude_46showString))
, VAPTAG(useLabel(FN_LAMBDA290))
, VAPTAG(useLabel(FN_Prelude_46_46))
, bytes2word(0,0,0,0)
, useLabel(CT_v301)
,	/* FN_LAMBDA290: (byte 0) */
  useLabel(TMSUB_Text_46Show_46Functions)
, bytes2word(NEEDHEAP_I32,PUSH_CADR_N1,4,STRING)
, bytes2word(RETURN,ENDCODE,0,0)
, bytes2word(0,0,0,0)
, CONSTRW(1,0)
, useLabel(ST_v300)
, 310062
, useLabel(ST_v299)
,	/* CT_v301: (byte 0) */
  HW(0,0)
, 0
,	/* CF_LAMBDA290: (byte 0) */
  VAPTAG(useLabel(FN_LAMBDA290))
, bytes2word(0,0,2,0)
, bytes2word(1,1,0,2)
, useLabel(CT_v303)
,	/* FN_Text_46Show_46Functions_46Prelude_46165_46getTypes: (byte 0) */
  useLabel(TMSUB_Text_46Show_46Functions)
, bytes2word(NEEDHEAP_I32,HEAP_CVAL_I3,HEAP_ARG_ARG,1)
, bytes2word(2,PUSH_HEAP,HEAP_CVAL_IN3,HEAP_ARG)
, bytes2word(2,HEAP_OFF_N1,5,RETURN)
, bytes2word(ENDCODE,0,0,0)
, bytes2word(0,0,0,0)
, 0
, CONSTR(0,2,0)
, 340023
, useLabel(ST_v302)
,	/* CT_v303: (byte 0) */
  HW(1,2)
, 0
,	/* F0_Text_46Show_46Functions_46Prelude_46165_46getTypes: (byte 0) */
  CAPTAG(useLabel(FN_Text_46Show_46Functions_46Prelude_46165_46getTypes),2)
, VAPTAG(useLabel(FN_NHC_46Internal_46_95apply1))
, bytes2word(1,0,0,1)
, useLabel(CT_v305)
,	/* FN_LAMBDA289: (byte 0) */
  useLabel(TMSUB_Text_46Show_46Functions)
, bytes2word(NEEDSTACK_I16,SELECTOR_EVAL,SELECT,2)
, bytes2word(ENDCODE,0,0,0)
, bytes2word(0,0,0,0)
, 330030
, useLabel(ST_v304)
,	/* CT_v305: (byte 0) */
  HW(0,1)
, 0
,	/* F0_LAMBDA289: (byte 0) */
  CAPTAG(useLabel(FN_LAMBDA289),1)
, bytes2word(1,0,0,1)
, useLabel(CT_v307)
,	/* FN_LAMBDA288: (byte 0) */
  useLabel(TMSUB_Text_46Show_46Functions)
, bytes2word(NEEDSTACK_I16,SELECTOR_EVAL,SELECT,1)
, bytes2word(ENDCODE,0,0,0)
, bytes2word(0,0,0,0)
, 330024
, useLabel(ST_v306)
,	/* CT_v307: (byte 0) */
  HW(0,1)
, 0
,	/* F0_LAMBDA288: (byte 0) */
  CAPTAG(useLabel(FN_LAMBDA288),1)
, bytes2word(0,0,4,0)
, bytes2word(3,1,2,2)
, bytes2word(1,3,0,4)
, useLabel(CT_v309)
,};
Node FN_Prelude_46Show_46Prelude_46_45_62_46showsPrec[] = {
  useLabel(TM_Text_46Show_46Functions)
, bytes2word(ZAP_ARG_I1,ZAP_ARG_I2,ZAP_ARG_I3,ZAP_ARG)
, bytes2word(4,NEEDHEAP_I32,PUSH_CVAL_P1,3)
, bytes2word(PUSH_HEAP,HEAP_CVAL_I4,EVAL,NEEDHEAP_I32)
, bytes2word(APPLY,1,RETURN_EVAL,ENDCODE)
, bytes2word(0,0,0,0)
, 290003
, useLabel(ST_v308)
,	/* CT_v309: (byte 0) */
  HW(2,4)
, 0
,};
Node F0_Prelude_46Show_46Prelude_46_45_62_46showsPrec[] = {
  CAPTAG(useLabel(FN_Prelude_46Show_46Prelude_46_45_62_46showsPrec),4)
, useLabel(CF_LAMBDA291)
, VAPTAG(useLabel(FN_Prelude_46showString))
, bytes2word(0,0,0,0)
, useLabel(CT_v312)
,	/* FN_LAMBDA291: (byte 0) */
  useLabel(TMSUB_Text_46Show_46Functions)
, bytes2word(NEEDHEAP_I32,PUSH_CADR_N1,4,STRING)
, bytes2word(RETURN,ENDCODE,0,0)
, bytes2word(0,0,0,0)
, CONSTRW(1,0)
, useLabel(ST_v311)
, 290030
, useLabel(ST_v310)
,	/* CT_v312: (byte 0) */
  HW(0,0)
, 0
,	/* CF_LAMBDA291: (byte 0) */
  VAPTAG(useLabel(FN_LAMBDA291))
, bytes2word(3,0,2,1)
, bytes2word(1,2,0,3)
, useLabel(CT_v314)
,};
Node FN_Prelude_46Show_46Prelude_46_45_62_46show[] = {
  useLabel(TM_Text_46Show_46Functions)
, bytes2word(NEEDHEAP_I32,HEAP_CVAL_I3,HEAP_ARG_ARG,1)
, bytes2word(2,PUSH_HEAP,HEAP_CVAL_I4,HEAP_OFF_N1)
, bytes2word(4,HEAP_ARG,3,RETURN_EVAL)
, bytes2word(ENDCODE,0,0,0)
, bytes2word(0,0,0,0)
, 280029
, useLabel(ST_v313)
,	/* CT_v314: (byte 0) */
  HW(2,3)
, 0
,};
Node F0_Prelude_46Show_46Prelude_46_45_62_46show[] = {
  CAPTAG(useLabel(FN_Prelude_46Show_46Prelude_46_45_62_46show),3)
, VAPTAG(useLabel(FN_Prelude_46Show_46Prelude_46_45_62))
, VAPTAG(useLabel(FN_Prelude_46_95_46show))
, bytes2word(3,0,2,1)
, bytes2word(1,2,0,3)
, useLabel(CT_v316)
,};
Node FN_Prelude_46Show_46Prelude_46_45_62_46showList[] = {
  useLabel(TM_Text_46Show_46Functions)
, bytes2word(NEEDHEAP_I32,HEAP_CVAL_I3,HEAP_ARG_ARG,1)
, bytes2word(2,PUSH_HEAP,HEAP_CVAL_I4,HEAP_OFF_N1)
, bytes2word(4,HEAP_ARG,3,RETURN_EVAL)
, bytes2word(ENDCODE,0,0,0)
, bytes2word(0,0,0,0)
, 280029
, useLabel(ST_v315)
,	/* CT_v316: (byte 0) */
  HW(2,3)
, 0
,};
Node F0_Prelude_46Show_46Prelude_46_45_62_46showList[] = {
  CAPTAG(useLabel(FN_Prelude_46Show_46Prelude_46_45_62_46showList),3)
, VAPTAG(useLabel(FN_Prelude_46Show_46Prelude_46_45_62))
, VAPTAG(useLabel(FN_Prelude_46_95_46showList))
, bytes2word(0,0,2,0)
, bytes2word(1,1,0,2)
, useLabel(CT_v318)
,};
Node FN_Prelude_46Show_46Prelude_46_45_62[] = {
  useLabel(TM_Text_46Show_46Functions)
, bytes2word(NEEDHEAP_I32,PUSH_HEAP,HEAP_CVAL_I3,HEAP_ARG_ARG)
, bytes2word(1,2,PUSH_HEAP,HEAP_CVAL_I4)
, bytes2word(HEAP_ARG_ARG,1,2,PUSH_HEAP)
, bytes2word(HEAP_CVAL_I5,HEAP_ARG_ARG,1,2)
, bytes2word(PUSH_HEAP,HEAP_CVAL_P1,6,HEAP_ARG_ARG)
, bytes2word(1,2,PUSH_HEAP,HEAP_CVAL_IN3)
, bytes2word(HEAP_P1,4,HEAP_P1,3)
, bytes2word(HEAP_I2,HEAP_I1,RETURN,ENDCODE)
, bytes2word(0,0,0,0)
, 0
, CONSTR(0,4,0)
, 280029
, useLabel(ST_v317)
,	/* CT_v318: (byte 0) */
  HW(4,2)
, 0
,};
Node F0_Prelude_46Show_46Prelude_46_45_62[] = {
  CAPTAG(useLabel(FN_Prelude_46Show_46Prelude_46_45_62),2)
, CAPTAG(useLabel(FN_Prelude_46Show_46Prelude_46_45_62_46showsPrec),2)
, CAPTAG(useLabel(FN_Prelude_46Show_46Prelude_46_45_62_46showsType),1)
, CAPTAG(useLabel(FN_Prelude_46Show_46Prelude_46_45_62_46showList),1)
, CAPTAG(useLabel(FN_Prelude_46Show_46Prelude_46_45_62_46show),1)
,	/* ST_v300: (byte 0) */
  bytes2word(32,45,62,32)
,	/* ST_v311: (byte 1) */
  bytes2word(0,60,60,102)
, bytes2word(117,110,99,116)
, bytes2word(105,111,110,62)
,	/* ST_v317: (byte 2) */
  bytes2word(62,0,80,114)
, bytes2word(101,108,117,100)
, bytes2word(101,46,83,104)
, bytes2word(111,119,46,80)
, bytes2word(114,101,108,117)
, bytes2word(100,101,46,45)
,	/* ST_v313: (byte 2) */
  bytes2word(62,0,80,114)
, bytes2word(101,108,117,100)
, bytes2word(101,46,83,104)
, bytes2word(111,119,46,80)
, bytes2word(114,101,108,117)
, bytes2word(100,101,46,45)
, bytes2word(62,46,115,104)
,	/* ST_v315: (byte 3) */
  bytes2word(111,119,0,80)
, bytes2word(114,101,108,117)
, bytes2word(100,101,46,83)
, bytes2word(104,111,119,46)
, bytes2word(80,114,101,108)
, bytes2word(117,100,101,46)
, bytes2word(45,62,46,115)
, bytes2word(104,111,119,76)
,	/* ST_v308: (byte 4) */
  bytes2word(105,115,116,0)
, bytes2word(80,114,101,108)
, bytes2word(117,100,101,46)
, bytes2word(83,104,111,119)
, bytes2word(46,80,114,101)
, bytes2word(108,117,100,101)
, bytes2word(46,45,62,46)
, bytes2word(115,104,111,119)
, bytes2word(115,80,114,101)
,	/* ST_v310: (byte 2) */
  bytes2word(99,0,80,114)
, bytes2word(101,108,117,100)
, bytes2word(101,46,83,104)
, bytes2word(111,119,46,80)
, bytes2word(114,101,108,117)
, bytes2word(100,101,46,45)
, bytes2word(62,46,115,104)
, bytes2word(111,119,115,80)
, bytes2word(114,101,99,58)
, bytes2word(50,57,58,51)
, bytes2word(48,45,50,57)
,	/* ST_v297: (byte 4) */
  bytes2word(58,52,51,0)
, bytes2word(80,114,101,108)
, bytes2word(117,100,101,46)
, bytes2word(83,104,111,119)
, bytes2word(46,80,114,101)
, bytes2word(108,117,100,101)
, bytes2word(46,45,62,46)
, bytes2word(115,104,111,119)
, bytes2word(115,84,121,112)
,	/* ST_v299: (byte 2) */
  bytes2word(101,0,80,114)
, bytes2word(101,108,117,100)
, bytes2word(101,46,83,104)
, bytes2word(111,119,46,80)
, bytes2word(114,101,108,117)
, bytes2word(100,101,46,45)
, bytes2word(62,46,115,104)
, bytes2word(111,119,115,84)
, bytes2word(121,112,101,58)
, bytes2word(51,49,58,54)
, bytes2word(50,45,51,49)
,	/* ST_v306: (byte 4) */
  bytes2word(58,54,55,0)
, bytes2word(80,114,101,108)
, bytes2word(117,100,101,46)
, bytes2word(83,104,111,119)
, bytes2word(46,80,114,101)
, bytes2word(108,117,100,101)
, bytes2word(46,45,62,46)
, bytes2word(115,104,111,119)
, bytes2word(115,84,121,112)
, bytes2word(101,58,51,51)
, bytes2word(58,50,52,45)
, bytes2word(51,51,58,50)
,	/* ST_v304: (byte 2) */
  bytes2word(56,0,80,114)
, bytes2word(101,108,117,100)
, bytes2word(101,46,83,104)
, bytes2word(111,119,46,80)
, bytes2word(114,101,108,117)
, bytes2word(100,101,46,45)
, bytes2word(62,46,115,104)
, bytes2word(111,119,115,84)
, bytes2word(121,112,101,58)
, bytes2word(51,51,58,51)
, bytes2word(48,45,51,51)
,	/* ST_v302: (byte 4) */
  bytes2word(58,51,53,0)
, bytes2word(80,114,101,108)
, bytes2word(117,100,101,46)
, bytes2word(83,104,111,119)
, bytes2word(46,80,114,101)
, bytes2word(108,117,100,101)
, bytes2word(46,45,62,46)
, bytes2word(115,104,111,119)
, bytes2word(115,84,121,112)
, bytes2word(101,58,51,52)
, bytes2word(58,50,51,45)
, bytes2word(51,52,58,52)
, bytes2word(50,0,0,0)
,};
Node PM_Text_46Show_46Functions[] = {
 	/* ST_v296: (byte 0) */
  bytes2word(84,101,120,116)
, bytes2word(46,83,104,111)
, bytes2word(119,46,70,117)
, bytes2word(110,99,116,105)
, bytes2word(111,110,115,0)
,};

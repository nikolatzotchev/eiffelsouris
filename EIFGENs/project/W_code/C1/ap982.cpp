/*
 * Code for class APPLICATION
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"


#ifdef __cplusplus
extern "C" {
#endif

extern EIF_TYPED_VALUE F982_7387(EIF_REFERENCE);
extern void F982_7383(EIF_REFERENCE);
extern EIF_TYPED_VALUE F982_7394(EIF_REFERENCE);
extern void EIF_Minit982(void);

#ifdef __cplusplus
}
#endif

#include <curses.h>
#include <iostream>
#include <termios.h>
#include <unistd.h>

#ifdef __cplusplus
extern "C" {
#endif

#ifndef INLINE_F982_7394
static EIF_CHARACTER_8 inline_F982_7394 (void)
{
	struct termios oldSettings, newSettings;
    				tcgetattr(STDIN_FILENO, &oldSettings);
    				newSettings = oldSettings;
    				newSettings.c_lflag &= ~(ICANON | ECHO);
    				tcsetattr(STDIN_FILENO, TCSANOW, &newSettings);
    				char ch;
    				read(STDIN_FILENO, &ch, 1);
					tcsetattr(STDIN_FILENO, TCSANOW, &oldSettings);
    				return ch;
	;
}
#define INLINE_F982_7394
#endif

#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {APPLICATION}.board */
EIF_TYPED_VALUE F982_7387 (EIF_REFERENCE Current)
{
	EIF_TYPED_VALUE r;
	r.type = SK_REF;
	r.it_r = *(EIF_REFERENCE *)(Current + RTWA(5173,Dtype(Current)));
	return r;
}


/* {APPLICATION}.make */
void F982_7383 (EIF_REFERENCE Current)
{
	GTCX
	char *l_feature_name = "make";
	RTEX;
	EIF_CHARACTER_8 loc1 = (EIF_CHARACTER_8) 0;
	EIF_TYPED_VALUE up1x = {{0}, SK_POINTER};
#define up1 up1x.it_p
	EIF_TYPED_VALUE ur1x = {{0}, SK_REF};
#define ur1 ur1x.it_r
	EIF_TYPED_VALUE ui4_1x = {{0}, SK_INT32};
#define ui4_1 ui4_1x.it_i4
	EIF_REFERENCE tr1 = NULL;
	EIF_INTEGER_32 ti4_1;
	EIF_CHARACTER_8 tc1;
	RTCDT;
	RTSN;
	RTDA;
	RTLD;
	
	RTLI(3);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,ur1);
	RTLIU(3);
	RTLU (SK_VOID, NULL);
	RTLU (SK_REF, &Current);
	RTLU(SK_CHAR8, &loc1);
	
	RTEAA(l_feature_name, 981, Current, 1, 0, 13456);
	RTSA(dtype);
	RTSC;
	RTME(dtype, 0);
	RTGC;
	RTDBGEAA(981, Current, 13456);
	RTIV(Current, RTAL);
	RTHOOK(1);
	RTDBGAA(Current, dtype, 5173, 0xF80003D6, 0); /* board */
	tr1 = RTLNSMART(RTWCT(5173, dtype, Dftype(Current)).id);
	ui4_1 = ((EIF_INTEGER_32) 20L);
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) RTWC(5170, Dtype(tr1)))(tr1, ui4_1x);
	RTNHOOK(1,1);
	tr1 = RTCCL(tr1);
	RTAR(Current, tr1);
	*(EIF_REFERENCE *)(Current + RTWA(5173, dtype)) = (EIF_REFERENCE) tr1;
	RTHOOK(2);
	tr1 = ((up1x = (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE)) RTWF(5173, dtype))(Current)), (((up1x.type & SK_HEAD) == SK_REF)? (EIF_REFERENCE) 0: (up1x.it_r = RTBU(up1x))), (up1x.type = SK_POINTER), up1x.it_r);
	RTNHOOK(2,1);
	(FUNCTION_CAST(void, (EIF_REFERENCE)) RTVF(5175, "display", tr1))(tr1);
	RTHOOK(3);
	tr1 = RTMS_EX_H("created board with ",19,1501651744);
	ur1 = tr1;
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) RTWF(30, dtype))(Current, ur1x);
	RTHOOK(4);
	tr1 = ((up1x = (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE)) RTWF(5173, dtype))(Current)), (((up1x.type & SK_HEAD) == SK_REF)? (EIF_REFERENCE) 0: (up1x.it_r = RTBU(up1x))), (up1x.type = SK_POINTER), up1x.it_r);
	RTNHOOK(4,1);
	ti4_1 = *(EIF_INTEGER_32 *)(tr1 + RTVA(5171, "cells", tr1));
	ur1 = RTLN(eif_new_type(223, 0x00).id);
	*(EIF_INTEGER_32 *)ur1 = ti4_1;
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) RTWF(30, dtype))(Current, ur1x);
	RTHOOK(5);
	tr1 = RTMS_EX_H("\012",1,10);
	ur1 = tr1;
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) RTWF(30, dtype))(Current, ur1x);
	RTHOOK(6);
	RTDBGAL(1, 0x08000000, 1, 0); /* loc1 */
	tc1 = (((FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE)) RTWF(5180, dtype))(Current)).it_c1);
	loc1 = (EIF_CHARACTER_8) tc1;
	RTHOOK(7);
	ur1 = RTLN(eif_new_type(202, 0x00).id);
	*(EIF_CHARACTER_8 *)ur1 = loc1;
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) RTWF(30, dtype))(Current, ur1x);
	RTHOOK(8);
	tr1 = RTMS_EX_H("!!!!!!!!!!!!!!!!!!!!",20,199502881);
	ur1 = tr1;
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) RTWF(30, dtype))(Current, ur1x);
	RTVI(Current, RTAL);
	RTRS;
	RTHOOK(9);
	RTDBGLE;
	RTMD(0);
	RTLE;
	RTLO(3);
	RTEE;
#undef up1
#undef ur1
#undef ui4_1
}

/* {APPLICATION}.read_char */
EIF_TYPED_VALUE F982_7394 (EIF_REFERENCE Current)
{
	GTCX
	char *l_feature_name = "read_char";
	RTEX;
	EIF_CHARACTER_8 Result = ((EIF_CHARACTER_8) 0);
	
	RTCDT;
	RTSN;
	RTDA;
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	RTLU (SK_CHAR8, &Result);
	RTLU (SK_REF, &Current);
	
	RTEAA(l_feature_name, 981, Current, 0, 0, 13465);
	RTSA(dtype);
	RTSC;
	RTME(dtype, 1);
	RTDBGEAA(981, Current, 13465);
	RTIV(Current, RTAL);
	Result = inline_F982_7394 ();
	RTVI(Current, RTAL);
	RTRS;
	RTHOOK(1);
	RTDBGLE;
	RTMD(1);
	RTLE;
	RTLO(2);
	RTEE;
	{ EIF_TYPED_VALUE r; r.type = SK_CHAR8; r.it_c1 = Result; return r; }
}

void EIF_Minit982 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif

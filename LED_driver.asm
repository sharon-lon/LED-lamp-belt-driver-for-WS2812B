;;时序PIN:PIN_NZR.   需要修改时，PIN_NZR	EQU	P1.0。P1.0改为需要的PIN
;;数据buf定义在C中，大小根据需求。一个led对应3bytes.定义：Uint8 idata Data_Tab[126] _at_ 0x80;
;;定义的数据buf名称需要与代码中相同。代码中两处，其后注释数据buf。
;;数据buf长度修改，代码中需要修改。数值为0x80+现在的数据长度。如15个灯：新数值为80h+22*3=0C2H。只改一处，见注释。
;;
;;调用前，先把数据写入数据buf，然后调用LED_DRIVER();
	PIN_NZR	EQU	P3.1

_5NOPS MACRO 		;	TIME =4*60ns
	NOP				;1NOP
	NOP				;1NOP
	NOP				;1NOP
	NOP				;1NOP
	NOP
ENDM
_DELAY	MACRO
	CLR PIN_NZR
	CLR PIN_NZR
	CLR PIN_NZR
	NOP
ENDM

?PR?LED_DRIVER?LED_driver	SEGMENT CODE

	EXTRN    IDATA(Data_Tab)				;数据buf
	
	PUBLIC LED_DRIVER

	RSEG  ?PR?LED_DRIVER?LED_driver
	
LED_DRIVER:
	MOV R0,#0H
	MOV	R1,#0H
	MOV	R2,#0H
	MOV	R3,#0H
	
	MOV	R0,#LOW (Data_Tab)					;数据buf

	MOV A,@R0	
	
	_5NOPS
	_5NOPS
	_5NOPS
GET_DATA_AGAIN:
	_5NOPS
	_5NOPS
	
	CJNE R0,#0C2H,NZR_BYTE	;2NOP			;数据buf长度。0x80+实际长度
	JMP EXIT				
NZR_BYTE:
	SETB PIN_NZR
	JB	ACC.7,NZR_BIT_HIGH_7	;2NOP	
	CLR PIN_NZR				;2NOP
	_DELAY
JUDGE_BIT6:
	SETB PIN_NZR
	JB	ACC.6,NZR_BIT_HIGH_6	
	CLR PIN_NZR				;2NOP
	_DELAY
JUDGE_BIT5:
	SETB PIN_NZR
	JB	ACC.5,NZR_BIT_HIGH_5	
	CLR PIN_NZR				;2NOP
	_DELAY
JUDGE_BIT4:
	SETB PIN_NZR
	JB	ACC.4,NZR_BIT_HIGH_4	
	CLR PIN_NZR				;2NOP
	_DELAY
JUDGE_BIT3:
	SETB PIN_NZR
	JB	ACC.3,NZR_BIT_HIGH_3	
	CLR PIN_NZR				;2NOP
	_DELAY	
JUDGE_BIT2:
	SETB PIN_NZR
	JB	ACC.2,NZR_BIT_HIGH_2	
	CLR PIN_NZR				;2NOP
	_DELAY
JUDGE_BIT1:
	SETB PIN_NZR
	JB	ACC.1,NZR_BIT_HIGH_1	
	CLR PIN_NZR				;2NOP
	_DELAY
JUDGE_BIT0:
	SETB PIN_NZR
	JB	ACC.0,NZR_BIT_HIGH_0	
	CLR PIN_NZR				;2NOP
	_DELAY	
	INC R0
	MOV	A,@R0
	JMP	GET_DATA_AGAIN

NZR_BIT_HIGH_7:
	_5NOPS
	CLR PIN_NZR				;2NOP
	NOP
	JMP	JUDGE_BIT6
NZR_BIT_HIGH_6:
	_5NOPS
	CLR PIN_NZR				;2NOP
	NOP
	JMP	JUDGE_BIT5
NZR_BIT_HIGH_5:
	_5NOPS
	CLR PIN_NZR				;2NOP
	NOP	
	JMP	JUDGE_BIT4	
NZR_BIT_HIGH_4:
	_5NOPS
	CLR PIN_NZR				;2NOP
	NOP
	JMP	JUDGE_BIT3
NZR_BIT_HIGH_3:
	_5NOPS
	CLR PIN_NZR				;2NOP
	NOP
	JMP	JUDGE_BIT2
NZR_BIT_HIGH_2:
	_5NOPS
	CLR PIN_NZR				;2NOP
	NOP
	JMP	JUDGE_BIT1
NZR_BIT_HIGH_1:
	_5NOPS
	CLR PIN_NZR				;2NOP
	NOP
	JMP	JUDGE_BIT0
NZR_BIT_HIGH_0:
	INC R0
	MOV	A,@R0
	CLR PIN_NZR				;2NOP
	NOP
	JMP	GET_DATA_AGAIN


EXIT:
	RET
END




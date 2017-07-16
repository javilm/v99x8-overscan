; ###################
; ## CONSTANT DATA ##
; ###################

tiles::		defb	038h,06ch,0c6h,0c6h,0c6h,06ch,038h,000h	; 00: 0
		defb	018h,038h,038h,018h,018h,018h,018h,000h	; 01: 1
		defb	07ch,0c6h,006h,03ch,060h,0c0h,0feh,000h	; 02: 2
		defb	07ch,0c6h,006h,03ch,006h,0c6h,07ch,000h	; 03: 3
		defb	01ch,03ch,06ch,0cch,0feh,00ch,00ch,000h	; 04: 4
		defb	0feh,0c0h,0fch,006h,006h,0c6h,07ch,000h	; 05: 5
		defb	03ch,060h,0c0h,0fch,0c6h,0c6h,07ch,000h	; 06: 6
		defb	0feh,086h,08ch,018h,030h,030h,030h,000h	; 07: 7
		defb	078h,0c4h,0e4h,078h,09eh,086h,07ch,000h	; 08: 7
		defb	07ch,0c6h,0c6h,07eh,006h,00ch,078h,000h	; 09: 8
		defb	038h,06ch,0c6h,0c6h,0feh,0c6h,0c6h,000h	; 10: A
		defb	0fch,0c6h,0c6h,0fch,0c6h,0c6h,0fch,000h	; 11: B
		defb	03ch,066h,0c0h,0c0h,0c0h,066h,03ch,000h	; 12: C
		defb	0f8h,0cch,0c6h,0c6h,0c6h,0cch,0f8h,000h	; 13: D
		defb	07eh,060h,060h,07ch,060h,060h,07eh,000h	; 14: E
		defb	07eh,060h,060h,07ch,060h,060h,060h,000h	; 15: F
		defb	03ch,07eh,05dh,009h,062h,018h,07ch,000h ; 16: Rock 1
		defb	002h,098h,03ch,03eh,01eh,05ch,060h,000h ; 17: Rock 2
		defb	018h,03ch,018h,006h,04fh,00fh,026h,020h ; 18: Rock 3
		defb	00ch,06ch,0f0h,0f3h,0f3h,060h,006h,004h ; 19: Rock 4

colors::	defb	0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; 0
		defb	0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; 1
		defb	0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; 2
		defb	0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; 3
		defb	0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; 4
		defb	0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; 5
		defb	0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; 6
		defb	0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; 7
		defb	0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; 8
		defb	0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; 9
		defb	0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; A
		defb	0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; B
		defb	0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; C
		defb	0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; D
		defb	0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; E
		defb	0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; F
		defb	0f1h,0f4h,075h,075h,054h,054h,041h,001h	; Rock 1
		defb	071h,0f1h,071h,051h,051h,041h,041h,001h	; Rock 2
		defb	0f1h,071h,051h,0f1h,071h,051h,041h,051h	; Rock 3
		defb	071h,051h,071h,071h,051h,041h,041h,041h ; Rock 4

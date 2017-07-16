  		include	macros.inc

		; From tiles.as
		extrn	tiles
		extrn	colors

		; From screen.as
		extrn	screen

NUM_TILES	equ	20		; 16 hex digits + 4 graphics

; VRAM tables for the V9938/V9958 GRAPHIC 3 mode

TAB_NAME	equ	01800h		; Pattern name table
TAB_COLOR	equ	02000h		; Color table
TAB_GENERATOR	equ	00000h		; Pattern generator table

; ###################
; ## PROGRAM START ##
; ###################

start:		di

		; Install the new interrupt handler
		ld	hl,hblank200
		ld	(00038h+1),hl

		DISABLEVBLANK
		SET212LINES
		SETHBLANK	200
		ENABLEHBLANK

		; Set the border color to something easy to see
		ld	a,7		; Cyan
		ld	(RG0SAV+7),a
		VDP	7

		; Change to GRAPHIC 3 mode
		call	setgraphic3

		; Disable sprites
		SPRITESOFF

		; Set the start addresses of VRAM tables
		ld	a,000000110b	; Pattern name table in 01800h
		VDP	2
		ld	a,010011111b	; Color table in 02000h
					; 010000000b = Start at 02000h
					; 000011111b = Use one tileset
		VDP	3
		xor	a
		VDP	10
		xor	a		; Pattern generator table in 00000h
		VDP	4

		; Copy the patterns (tiles) to VRAM
		RAM2VRAM8	tiles,TAB_GENERATOR,NUM_TILES*8
		RAM2VRAM8	colors,TAB_COLOR,NUM_TILES*8

		; Copy the screen buffer to VRAM
		RAM2VRAM16	screen,TAB_NAME,1024

		; Clear VDP status registers
		RDVDP	0
		RDVDP	1

		ei

loop:		jr	loop

; ###############
; ## FUNCTIONS ##
; ###############

; Change to GRAPHIC 3 mode (SCREEN 4 in MSX-BASIC) 
; Modifies:	A
; Note:		Interrupts must be disabled

setgraphic3:	ld	a,(RG0SAV+0)
		and	011110001b
		or	000000100b
		ld	(RG0SAV+0),a	; R#0 = ????010?b
		VDP	0

		ld	a,(RG0SAV+1)
		and	011100111b
		ld	(RG0SAV+1),a	; R#1 = ???00???b
		VDP	1

		ret

; Set VRAM address for read/write (only low 64KB)
; Input:	DE = VRAM address (bits A0-A15)
; Modifies:	A
; Note:		Interrupts must be disabled

setvramaddr_w:	ld	a,d
		rlca
		rlca
		and	000000011b
		VDP	14		; Send bits A16-A14 to VDP R#14

		ld	a,e
		out	(vdpport1),a	; Send bits A7-A0 to VDP (low 16KB)

		ld	a,d
		and	000111111b
		or	001000000b
		out	(vdpport1),a	; Send bits A13-A8 to VDP, for writing

		ret

; ##########################
; ## INTERRUPT HANDLER(S) ##
; ##########################

; Interrupt handler for line 200
hblank200:	RDVDP	1

		; Check whether this is a line interrupt
		and	000000001b
		jr	z,hblank200.2

		ld	hl,hblank224
		ld	(00038h+1),hl

		SET192LINES
		SETHBLANK	224

hblank200.2:	ei
		ret

; Interrupt handler for line 224
hblank224:	RDVDP	1

		; Check whether this is a line interrupt
		and	000000001b
		jr	z,hblank224.2

		ld	hl,hblank200
		ld	(00038h+1),hl

		; Increase the VDP's vertical scroll register
		ld	a,(RG8SAV+23)
		inc	a
		ld	(RG8SAV+23),a
		VDP	23

		SET212LINES
		SETHBLANK	200

hblank224.2:	ei
		ret

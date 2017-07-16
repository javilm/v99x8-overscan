; VDP ports

vdpport0	equ	098h		; Read/write VRAM
vdpport1	equ	099h		; Read/write VDP register
vdpport2	equ	09ah		; Write palette registers
vdpport3	equ	09bh		; Write VDP register (indirect)

; RAM copy of the VDP registers in work area

RG0SAV		equ	0f3dfh		; VDP R#0 to R#7
RG8SAV		equ	0ffe7h - 8	; VDP R#8 to R#23

; ############
; ## MACROS ##
; ############

; VDP - Send the value in CPU register A to a VDP register
; Syntax:	VDP	REGISTER
; Note:		Interrupts should be disabled

VDP		macro	REGISTER
		out	(vdpport1),a
		ld	a,REGISTER or 080h
		out	(vdpport1),a
		endm

; RDVDP	- Read VDP status register, leave result in CPU register A
; Syntax:	RDVDP	REG
; Note:		Interrupts should be disabled

RDVDP		macro	REG
		ld	a,REG
		VDP	15		; Set VDP status register to read
		in	a,(vdpport1)
		endm

; RAM2VRAM8 - Copy NUM bytes from RAM address to VRAM address VRAM
; Syntax:	RAM2VRAM2	RAM,VRAM,NUM
; Notes:	a) NUM must be an 8-bit value (0-255)
;		b) Interrupts must be disabled
;		c) Only supports the lower 64KB of VRAM

RAM2VRAM8	macro	ram,vram,num

		; Set VRAM destination address
		ld	de,vram
		call	setvramaddr_w

		; Initialize loop registers HL and B
		ld	hl,ram			; Source RAM address
		ld	bc,num*256 + vdpport0	; B = Number of bytes to copy
						; C = VDP port to write to

		; Tell the CPU to initiate the transfer
		otir

		endm

; RAM2VRAM16 - Copy NUM bytes from RAM address to VRAM address
; Syntax:	RAM2VRAM16	RAM,VRAM,NUM
; Notes:	a) NUM is a 16-bit value (0-65535)
;		b) Interrupts must be disabled
;		c) Only supports the lower 64KB of VRAM

RAM2VRAM16	macro	RAM,VRAM,NUM

		; Set VRAM destination address
		ld	de,VRAM
		call	setvramaddr_w

		; Initialize loop registers HL and DE
		ld	de,NUM		; Number of bytes to copy
		ld	hl,RAM		; Source RAM address

		; Load VDP port number in register C
		ld	c,vdpport0

		; Loop head
		ld	a,(hl)		; Load (HL) in register A...
		out	(c),a		; ...and output it to the VDP

		inc	hl		; Increase source address...
		dec	de		; ...and decrease counter

		ld	a,d		; If (D or E) != 0 then repeat loop
		or	e
		jr	nz,$-7		; Jump to loop head if DE != 0
		endm

; SET192LINES - Set the VDP screen height to 192 lines
; Syntax:	SET192LINES
; Notes:	Interrupts must be disabled

SET192LINES	macro
		ld	a,(RG8SAV+9)
		and	001111111b
		ld	(RG8SAV+9),a
		VDP	9
		endm

; SET212LINES - Set the VDP screen height to 212 lines
; Syntax:	SET212LINES
; Notes:	Interrupts must be disabled

SET212LINES	macro
		ld	a,(RG8SAV+9)
		or	010000000b
		ld	(RG8SAV+9),a
		VDP	9
		endm

; SPRITESOFF - Disable sprites in the VDP
; Syntax:	SPRITESOFF
; Notes:	Interrupts must be disabled

SPRITESOFF	macro
		ld	a,(RG8SAV+8)
		or	000000010b
		ld	(RG8SAV+8),a
		VDP	8
		endm

; SETHBLANK - Tell the VDP to generate an HBlank interrupt when it reaches
;	       line number NUM
; Syntax:	SETHBLANK	NUM
; Note:		Interrupts must be disabled

SETHBLANK	macro	NUM
		ld	hl,RG8SAV+23
		ld	a,NUM
		add	a,(hl)
		ld	(RG8SAV+19),a
		VDP	19
		endm

; DISABLEHBLANK - Disable the VDP's HBlank interrupts
; Syntax:	DISABLEHBLANK
; Note:		Interrupts must be disabled

DISABLEHBLANK	macro
		ld	a,(RG0SAV+0)
		and	011101111b
		ld	(RG0SAV+0),a
		VDP	0
		endm

; ENABLEHBLANK - Enable the VDP's HBlank interrupts
; Syntax:	ENABLEHBLANK
; Note:		Interrupts must be disabled

ENABLEHBLANK	macro
		ld	a,(RG0SAV+0)
		or	000010000b
		ld	(RG0SAV+0),a
		VDP	0
		endm

; DISABLEVBLANK - Disable the VDP's VBlank interrupts
; Syntax:	DISABLEVBLANK
; Note:		Interrupts must be disabled

DISABLEVBLANK	macro
		ld	a,(RG0SAV+1)
		and	011011111b
		ld	(RG0SAV+1),a
		VDP	1
		endm

; ENABLEVBLANK - Enable the VDP's VBlank interrupts
; Syntax:	ENABLEVBLANK
; Note:		Interrupts must be disabled

ENABLEVBLANK	macro
		ld	a,(RG0SAV+1)
		or	000100000b
		ld	(RG0SAV+1),a
		VDP	1
		endm

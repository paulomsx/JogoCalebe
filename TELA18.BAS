'tempo  teste
' T%(0) - QUEDA
' T%(1) - SOB / DESCE ESCADA
' T%(2) - PULO
' T%(3) - LUZ DA TOCHA
' T%(4) - INIMIGO
' T%(5) - INIMIGO
' T%(6) - INIMIGO
' T%(7) - TIRO

FILE "TemaHJ6.akm"            ' 0 - Music (exported from Arkos Tracker 2)
FILE "gd1.akx"            ' 1 - Sound Effects (expord from Arkos Tracker 2)
FILE "TILES.chr.plet5"  ' 2 - Tiles Patterns (exported from nMSXTiles)
FILE "TILES.clr.plet5"  ' 3 - Tiles Colors (exported from nMSXTiles)
FILE "S8.SPR"           ' 4 - Sprites (exported from TinySprite)
FILE "TEXTO.TXT"        ' 5

FILE "T01.plet5"      ' 6
FILE "T02.plet5"      ' 7
FILE "T03.plet5"      ' 8
FILE "T04.plet5"      ' 9
FILE "T05.plet5"      ' 10
FILE "T06.plet5"      ' 11
FILE "T07.plet5"      ' 12
FILE "T08.plet5"      ' 13
FILE "T09.plet5"      ' 13
FILE "T10.plet5"      ' 13
FILE "T11.plet5"      ' 13
FILE "T12.plet5"      ' 13
FILE "T13.plet5"      ' 13
FILE "T14.plet5"      ' 13
FILE "T15.plet5"      ' 13
FILE "T16.plet5"      ' 13
FILE "T17.plet5"      ' 13
FILE "T18.plet5"      ' 13
FILE "T19.plet5"      ' 13
FILE "T20.plet5"      ' 13
FILE "T21.plet5"      ' 13
FILE "T22.plet5"      ' 13
FILE "T23.plet5"      ' 13
FILE "T24.plet5"      ' 13
FILE "T25.plet5"      ' 13
FILE "T26.plet5"      ' 13
FILE "T27.plet5"      ' 13
FILE "T28.plet5"      ' 13
FILE "T29.plet5"      ' 13
FILE "T30.plet5"      ' 13
FILE "T31.plet5"      ' 13
FILE "T32.plet5"      ' 13
FILE "T33.plet5"      ' 13
FILE "T34.plet5"      ' 13
FILE "T35.plet5"      ' 13



0 '
01 DEFINT A-Z : UE%=0  : CMD TURBO 1

02 CMD RESTORE 5
03  DIM MA%(60)              'PROXIMAS TELAS
04 DIM IN%(2,5)             'INIMIGOS
05 DIM WK%(2)               'CONTA PASSOS INIMIGO
06 DIM SPR%(2)              'CONTROLE DE SPRITE INIMIGO
07 DIM GR(30)               'CONTROLE TIRO
08 DIM J1%(2,4)             'VARRE A TELA
09 U%=162:U1%=235:U2%=236

11 X%=8:Y%=79:TY%=12:S%=0   'POISICAO INICIAL DO JOGADOR
'12 DX%=8                   'POSIÇÃO INICIAL CANTO ESQUERDA - VIRADO PARA DIREITA

12 GOSUB 31250 'COR JOGADOR '
13 AS%=8 'passadas

19 X11%=09:Y11%=12 'PLATAFORMA

' V%  - OBJETOS DO ALTO
' V1% - EXPLOSÃO
' 
14 DIM T%(29) : DIM V%(21): DIM V1%(6):DIM KJ%(8)
15 DIM O%(30,5):DIM OL%(30,5):DIM OC%(30,5)
16 PR%=1 'PORTAL ATIVADO
'TIME / CONTROLE DO FLUXO / 
17 DIM PC%(2)
18 DIM P%(5,4)
21 DIM MF%(3,1)
22 DIM E%(30,5):DIM EL%(30,5):DIM EC%(30,5) 'ITENS COLETADOS
23 DIM EP%(5) 'PILHA DE OBJETOS
24 DIM SQ%(15) 
25 _MS%=0:_TM%=6

'26 ZK%=18:R$="": GOSUB 31800

10 GOSUB 10000       'INICIALIZA GAME
'20 GOSUB 10200       'DEFINE VARIÁVEIS INICIAIS
30 GOTO  10570       'INICIALIZA JOGO TELA 1

'===>GET USER INPUT
9100 K% = INKEY
9101 J% = STICK(0) OR STICK(1)
9102 B% = STRIG(0) OR STRIG(1) 
9104 C% = STRIG(3) 
9105 RETURN
 
'===>EXIBE JOGADOR
9200 IF JP%>0 THEN IF DI%=-1 THEN S%=24 ELSE S%=21 '**** DEFINE O SPRITE NO PULO
9201 PUT SPRITE  0,(X%,Y%), CO1% ,S%   'COR AZUL 5
9202 PUT SPRITE  1,(X%,Y%), CO2% ,S%+1  'COR PELE  9
9203 PUT SPRITE  2,(X%,Y%), CO3% ,S%+2  'COR SAPATO
9205 IF F%=1 THEN RETURN 'FIM DO JOGO ?
9206 RX%=INT(X%/8):RY%=TY%:CF2%=TILE(RX%+1,TY%) 
9208 IF JP%=10 THEN GOSUB 30300 'PEGA NO ALTO
9209 GOSUB 9400  'controle queda 

'DETECTA OBSTACULOS
9210 B1%=TILE(RX%+1,TY%-1):B2%=TILE(RX%+1,TY%-2)
9212 GOSUB 30380
9213 RETURN

'**********************************************************************************************/
' ** MOVIMENTO DO JOGADOR
'**********************************************************************************************/
9300 IF ST%=1                                   THEN RETURN                  'SE TIVER EM QUEDA NÃO MOVIMENTA AS SETAS
9301 IF TIME-T1%<1                             THEN RETURN ELSE T1%=TIME    'TIME
9310 IF JP%=0 AND US%<>1                        THEN IF B%<>0 THEN 9741      'PULO
  
' TR%=0 NÃO DEIXA APERTAR O TIRO QDO JÁ TEM UM EM ANDAMENTO
' RX%>2 AND RX%<28 - LIMITES DA TELA PARA O TIRO
'9311 IF US%<>1 AND TR%=0 THEN IF C%<>0 THEN 9900 ' 9745      'TIRO
'9313 IF C%<>0 then print C%,",";
'9311 IF C%<>0  THEN GOSUB 9915 

9312 IF US%<>1 AND TR%=0 THEN IF C%<>0  THEN GOSUB 9900 'TIRO


9321 IF J%=1 OR J%=5                            THEN GOSUB 4000:RETURN '1=SOBE/5=DESCE
9325 IF J%=3 AND SD%=1  AND US%<>1              THEN GOSUB 9360:RETURN 'DIREITA
9326 IF J%=7 AND SE%=1  AND US%<>1              THEN GOSUB 9350:RETURN 'ESQUERDA
9327 IF J%=0 AND (S%<>0 and S%<>9) AND US%<>1   THEN 9470 'DEFINE POSIÇÃO SENTIDO 
9340 RETURN
'**********************************************************************************************/
'VERIFICA TOPO NO PULO
9741 IF TILE(RX%+1,RY%-3)<>U% THEN JP%=20:SE%=1:SD%=1  'TOP PERSONAGEM
9744 RETURN 

'**********************************************************************************************/
' MOVE ESQUERDA
'**********************************************************************************************/
9350 IF RX%<0 THEN 10600
9359 IF S%<6 THEN S%=9 'CORRIGE A DIREÇÃO DO PERSONAGEM
9351 SD%=1:GOSUB 9700 'VERIFICA SE HÁ PAREDE DO LADO ESQUERDO
9352 IF SE%=0 THEN SE%=1:RETURN 
9353 DI%=-1:X%=X%-1
9354 IF AS%=8 THEN AS%=0:GOSUB 9711 ELSE AS%=AS%+1'passadas
9358 GOTO  9200 'EXIBE JOGADOR

9700 XT%=TILE(RX%,RY%-2)
9704 IF XT%=U% OR XT%=U2% OR (XT%>153 AND XT%<156)  THEN SE%=0    'PAREDE
9706 N%=0:GOSUB 9750                     'PEGA OBJETOS
9707 IF XT%=175 AND SP%=1 THEN X%=X%-16:GOSUB 9880  'SAIDA PORTAL
9708 RETURN 

9711 IF S%=6 THEN S%=9 ELSE S%=6 'passadas
9712 T2%=TIME
9713 RETURN
'**********************************************************************************************/

'**********************************************************************************************/
' MOVE DIREITA
'**********************************************************************************************/
9360 IF RX%+1>30 THEN 10604
9370 IF S%>3 THEN S%=0 'CORRIGE A DIREÇÃO DO PERSONAGEM
9361 SE%=1:GOSUB 9720 'VERIFICA A DIREITA
9363 IF SD%=0 THEN SD%=1:RETURN
9366 DI%=1:X%=X%+1 
9367 IF AS%=8 THEN AS%=0:GOSUB 9730 ELSE AS%=AS%+1
9369 GOTO 9200 'EXIBE JOGADOR

9720 XT%=TILE(RX%+2,RY%-2) 
9722 IF XT%=U% OR XT%=U1% OR (XT%>153 AND XT%<156)  THEN SD%=0 'PAREDE

9724 IF XT%<>0  THEN N%=2:GOSUB 9750     'PEGA OBJETOS
9725 IF XT%=175 AND SP%=1 THEN X%=X%+16:GOSUB 9880 'SAIDA PORTAL
9726 IF XT%=252 AND SP%=1 THEN X%=X%+20:GOSUB 9880 'SAIDA PORTAL AZUL
9729 RETURN 

9730 IF S%=3 THEN S%=0 ELSE S%=3
9731 T2%=TIME
9732 RETURN 
'**********************************************************************************************/

'=== PEGA OBJETOS
9750 IF (XT%>145 AND XT%<153) THEN 9757                            'PEGA OBJETO ESCONDE
9751 IF XT%=76                THEN 31280 'FECHADURA AZUL
9752 IF XT%=180               THEN 31140 'FECHADURA AMARELA
9753 IF XT%=222               THEN ES%=1:RETURN  'DISQUETE ESCONDIDO
9754 IF XT%=246 OR XT%=5      THEN 30570 'COMPUTADOR-"DESATIVAR PORTAL"
9755 IF XT%=79 THEN H2%=1  'aciona flecha
9758 IF XT%=80 THEN N9%=1  'ATIVA ARANHA
9756 RETURN
' ESCONDE OBJETO
9757 I=RX%+N%:K=RY%-2:W=SC%'I=Coluna, K=Linha, W=TELA ATUAL
9759 PUT TILE MA%(58),(I,K)  : FOR A2=0 TO 5:IF O%(W,A2)=0 THEN 9760 ELSE NEXT A2
9760 O%(W,A2)=XT%:OC%(W,A2)=I:OL%(W,A2)=K 

' EXIBE 100
'9761 IF XT%=22 THEN T%(28)=TIME:AT%=1:GOTO 9769 'POÇÃO FORÇA
9761 PT%=PT%+100 : GOSUB 31630 'PONTUAÇÃO
9762 UY%=Y%
9763 UX%=I*8:UY%=UY%-10:L0%=TIME
9764 FOR L1%=0 TO 3
9765    PUT SPRITE 7,(UX%,UY%),15,39
9766    IF TIME-L0%<1 THEN 9766 ELSE UY%=UY%-1:L0%=TIME
9767 NEXT 
9768 UE%=1 : T%(18)=TIME
9769 RETURN
'
9770 IF TIME-T%(18)<20 THEN RETURN  
9772 PUT SPRITE 7,(-100,-100),0,0:UE%=0
9775 RETURN

'**********************************************************************************************/
' CONTROLE DA QUEDA
'**********************************************************************************************/
9400 IF US%=1     THEN 9410 'SUBINDO ESCADA
9401 IF CF2%=20   THEN 9440 'PLATAFORMA
9404 IF (CF2%<>U1% AND CF2%<>U2% AND CF2%<>U% AND CF2%<>188 AND CF2%<>189) AND JP%=0 THEN Q%=8:ST%=1 ELSE Q%=0:ST%=0  '=== VERIFICA PISO
9406 IF TY%>23 THEN GOSUB 10611 ' MUDA DE TELA
9410 RETURN

'=== QUEDA LIVRE
9500 IF TIME-T%(0)<3 OR Q%=0 THEN RETURN  ' CONTROLA VELOCIDADE DA QUEDA
9502 T%(0)=TIME
9510 GOSUB 9400 'CONTROLE DA QUEDA
9520 IF Q%=0 THEN RETURN
9530 Y%=Y%+Q%:TY%=TY%+ST%
9531 GOSUB 9200
9590 RETURN
'**********************************************************************************************/

'=== QUEDA DESLIGADA (PLATAFORMA)
9440 IF ST%=0 THEN RETURN
9441 Q%=0:ST%=0 
9450 RETURN

'**********************************************************************************************/
'PULO
'**********************************************************************************************/
9600 IF TIME-T%(2)<2 OR JP%=0 THEN RETURN 
9602 T%(2)=TIME
9620 JP%=JP%-1                           
9630 IF JP% < 10  THEN U=1 ELSE U=-1
9631 Y%=Y%+U
9632 GOSUB 31600 'COLISÃO DO PULO
9641 GOTO 9200


'**********************************************************************************************/
' SE JOGADOR ESTIVER PARADO COLOCAR POSIÇÃO DE SENTIDO
'**********************************************************************************************/
9470 IF TIME-T2%<15 THEN RETURN      
9472 T2%=TIME
9473 IF S%=3 AND AS%>7 OR S%=3 OR S%=21 THEN S%=0:AS%=0
9474 IF S%=6 AND AS%>7 OR S%=6 OR S%=24 THEN S%=9:AS%=0
9475 IF (S%=18 OR S%=15)  AND US%=0 THEN 9478 'FIM DE ESCADA
9476 GOSUB 9200 
9477 RETURN
9478 IF RX%>15 THEN S%=9 ELSE S%=0
9479 AS%=0:GOTO 9476

'**********************************************************************************************/
'=== SOB/DESCE ESCADA
'**********************************************************************************************/
4000 I%=RY%-2:W%=-1:H%=0
4001 IF J%=5 THEN I%=RY%+1:W%=1:H%=0
4002 IF US%=1 THEN 4020

4005 EE%=TILE(RX%+1,I%):ED%=TILE(RX%,I%) 
4010 IF EE%=188 OR EE%=189 OR ED%=189 OR ED%=188  THEN US%=1 ELSE RETURN 'VERIFICA SE ESTÁ NA 
4011 IF EE%=188 THEN X%=(RX%*8)+8 
4012 IF ED%=188 THEN X%=(RX%*8)   
4013 IF ED%=189 THEN X%=(RX%*8)-8 
4020 IF (TIME-T%(1))<10 THEN RETURN ELSE T%(1)=TIME 'TIME
4021 IF S%=15 THEN S%=18 ELSE S%=15
4030 Y%=Y%+8*W%:TY%=TY%+1*W%
4051 IF J%=1 AND TY%<=5 THEN GOSUB 10619 : RETURN 'LIMITE SUPERIOR DA TELA
4052 IF J%=5 AND TY%=23 THEN GOSUB 10611 : RETURN 'LIMITE INFERIOR DA TELA
4031 GOSUB 9200
4040 EE%=TILE(RX%+1,RY%+H%)
4050 IF US%=1 AND (EE%=138 OR EE%=128 OR EE%=148 OR EE%=149 OR EE%=162) THEN US%=0 'TERMINA A ESCADA
4090 RETURN
'**********************************************************************************************/

'DEBUG
5000 'LOCATE 0,23 : PRINT S$
5020 K% = INKEY:IF K%=13 THEN RETURN ELSE GOTO 5020
5060 RETURN 

'**********************************************************************************************/
'=== LUZ DA TOCHA
3391 IF TIME-T%(3)<20 THEN RETURN ELSE T%(3)=TIME 
3392 IF CL%<>6 THEN CL%=6 ELSE CL%=9
3393 SET TILE COLOR 160,CL%
3399 RETURN
'**********************************************************************************************/
'=== PISCA A CHAVE
 3400 IF TIME-T%(4)<5 THEN RETURN ELSE T%(4)=TIME 
 3401 IF KL%=11 THEN KL%=0 ELSE KL%=11
 3402 SET TILE COLOR 172,KL%
 3403 RETURN
'**********************************************************************************************/
' CONFIGURAÇÃO INICIAL
'**********************************************************************************************/

' INICIALIZA JOGO
10000 COLOR 15,0,0:SCREEN 2,2,0
10002 SET TILE ON  
10005 CMD WRTSPR  4        ' Load sprite resource
10007 CMD PLYLOAD 0, 1     ' Load music and sound effect resource
10008 CMD PLYSONG 0        ' Load game song theme (Bach Invention 14)
10009 CMD PLYPLAY          ' Play theme
10010 SET TILE COLOR 164,0
'10011 CMD PLYMUTE
'10024 SET TILE COLOR 156,0
10020 CMD WRTCHR 2       ' Load tiles patterns resource
10021 CMD WRTCLR 3       ' Load tiles colors resource
'10022 CMD WRTSPR 4
'10020 CMD SETFNT  1
'10024 SET TILE COLOR 156,0: SET TILE COLOR 169,0:SET TILE COLOR 130,0:SET TILE COLOR 131,0

10022 LN%=52:GOSUB 31200  'portal azul
10023 LN%=53:GOSUB 31200  'CARREGA SQUAD CENTRAL
10024 LN%=50:GOSUB 31200  'CARREGA DOS OBEJTOS DO ALTO - LINHA 50

'10023 FOR A=0 TO 10 : LOCATE 15,A:PRINT A,V1%(A):NEXT A :GOSUB 5000
10030 RETURN    

'==== DEFINE VARIÁVEIS INICIAL POR TELA
10200 SD%=1:SE%=1     'HAB DIR / ESQ
10230 Q%=0 ':ST%=0    'CONTROLE DA QUEDA
10250 F%=0            'FIM DE JOGO
'10251 KY%=0 ' CHAVE 
'10252 M1%=1 ' OBSTACULOS ARMADILHAS
10253 M2%=0 ' CONTROLE TEMPO SAÚDE
10254 SP%=0 ' PORTAL TRANCADO
10255 Z2%=0:Z1%=0
10260 RETURN

'==== FUNÇÃO TELA NOVA
10300 CMD DISSCR
10305 CMD WRTSCR SC%+5 'Carrega tela
'10306 locate 10,0:print pa:pa=pa+1:LOCATE 25,0:PRINT MA%(57),MA%(58)

'10360 CMD SETFNT  1
10369 LOCATE 1,1:PRINT CHR$(44)+CHR$(45) + SC%
10371 SET TILE COLOR 175, (6,6,6,9,9,15,6),(0,0,0,0,0,9,0) 'PINTA PORTA PORTAL
10374 GOSUB 8421  'VOLTA FLIP
10375 GOSUB 31100 'LISTA BARRA DE VIDA




10378 GOSUB 31120 'BARRA itens
10379 GOSUB 31630 'PONTUAÇÃO

'10379 SET TILE COLOR 200,(0,15,15,15,14,15,14,15) ,(5,4,4,4,4,4,4,4) 'PINTA PORTA PORTAL

10380 RETURN

'******************************************************************************
' FLUXO DA TELA
'******************************************************************************

10420 GOSUB 10200       'CONFIGURAÇÃO INICIAL

10421 PUT SPRITE 6,(-10,-10),0,0 'ESCONDE SPRITE MORCEGO

10430 GOSUB 10300       'CARREGA TELA
10500 GOSUB 11000       'INICIALIZA OGROS 
10501 GOSUB 9200        'EXIBE JOGADOR
10502 CMD ENASCR   
10503 ME%=0
10504 return

'******************************************************************************
' LOOP - INI
'******************************************************************************
  10510 GOSUB 9100  'GET USER INPUT
  10520 GOSUB 9300  'MOVIMENTOS HEROI
  10521 IF ME%=1 THEN GOSUB 10420:goto 10510

  10530 GOSUB 9600  'PULO
  10540 IF Q%>0               THEN  GOSUB 9500  'QUEDA LIVRE
  10541 GOSUB 3391        'LUZ DA TOCHA

'10532 GOSUB 3400        'PISCA CHAVE

10531 IF X13%>0              THEN GOSUB 7000  'GOTEIRA

  10542 IF M1%>0 AND PQ%>0     THEN GOSUB 30420 'ARMADILHA ESTACA
  '10543 IF XXXXX              THEN GOSUB 30420 'ARMADILHA
  '10544 IF E1%>0               THEN GOSUB 30700 'BATE ESTACA


  '10544 IF AT%=1 THEN GOSUB 31240 'PISCA JOGADOR

  10545 IF PO%>0 AND PR%=1     THEN GOSUB 30500 'PORTAL
  10572 IF SK%=1               THEN GOSUB 30600 'SKRUL
  10546 IF UE%=1               THEN GOSUB 9770  'APAGA 100
  10547 IF TR%=1               THEN GOSUB 9800  'TIRO
  10548 IF N1%>0               THEN GOSUB 30800 'MOLUSCO/MORCEGO/ARANHA
  10549 IF XP%>0               THEN GOSUB 31350 'APAGA A EXPLIOSÃO DA COLISÃO

  10550 FOR V=0 TO 2:GOSUB 8310:NEXT V              'OGROS
  10551 IF H1%=0 AND H2%=1 THEN GOSUB 31000  'ativa flecha 'GOSUB 30930 ELSE GOSUB 31000 'FLECHA
  11552 IF CD2%=0 THEN GOSUB 31040 ELSE GOSUB 31050 'RELAMPAGO
  11553 GOSUB 31230 ' COLISÃO SPRITES

  'PLATAFORMA
  10555 IF (SC%>31 AND SC%<34) OR SC%=10 THEN GOSUB 30201     'PLATAFORMA 


  10554 IF TIME<0 THEN GOSUB 10568                  'ZERA O TIMER

10559 GOTO 10510
'******************************************************************************
' LOOP - FIM
'******************************************************************************

'==== ZERA O TIME
10568 TIME=0:T1%=0:T2%=0:FOR A%=0 TO 27:T%(A%)=0:NEXT A%
10569 RETURN'AQUI2
'******************************************************************************
' FLUXO DA TELA - FIM

'******************************************************************************

'==== TELA INICIAL
10570 SC%=34
10571 GOSUB 20000 'RESTORE
10573 LF%=5 ' TIME DA LUZ DE FUNDO
10582 gosub 10420
10583 goto 10510

'******************************************************************************
'==== VERIFICA ESQUERDA
10600 SC%=MA%(0) 
10601 GOSUB 20000 
10602 X%=232:RX%=INT(X%/8):ME%=1
10603 RETURN
'10603 GOTO 10420
'******************************************************************************
'==== VERIFICA DIREITA
10604 SC%=MA%(1) 
10605 GOSUB 20000  
10606 X%=4:RX%=INT(X%/8):ME%=1
10607 RETURN

'******************************************************************************
'==== MUDA TELA 
10608 SC%=MA%(4) 
10609 GOSUB 20000 
10610 ME%=1: RETURN

'==== DESCE MUDA DE TELA
10611 SC%=MA%(2) 
10612 GOSUB 20000 
10613 TY%=5:Y%=((TY%*8)-16)-1
'10614 GOTO 10420
10614 ME%=1:RETURN

'==== DESCE MUDA DE TELA
10619 SC%=MA%(3) 
10620 GOSUB 20000 
10621 TY%=22:Y%=((TY%*8)-16)-1
'10622 GOTO 10420
10622 ME%=1:RETURN


'******************************************************************************
'=== RESTORE - INI
'*******************
' C é o ponteiro
' R índice obtem par da tela
'******************************************************************************
' 20000 RESTORE R
' 20030 READ S$
' 20110 H$="":C=0 :M1%=0
' 20120 FOR A=1 TO LEN(S$)
' 20121   C$=MID$(S$,A,1)
' 20122   IF C$="," THEN  MA%(C)=H$:H$="":C=C+1 ELSE H$=H$+C$
' 20123 NEXT A
' 20124 MA%(C)=VAL(H$)


20000 LN%=SC%:TR%=0:M1%=0
20001 GOSUB 31200


'************************************************************

' GOTEIRA
20125 IF MA%(28)>0 THEN GOSUB 8122 ELSE X13%=0  ' GOTEIRA

'ARMADILHA
20151 IF MA%(20)>0 THEN GOSUB 30361 
'SKRULL (SETA SE EXISTE PERSONAGEM COBRA / ESCORPIAO)
20152 SK%=0 : IF MA%(33)>0 THEN SK%=1 
'MORCEGO - CONFIG PARAMETROS INICIAIS 
20153 IF MA%(48)>0 THEN GOSUB 30810 ELSE GOSUB 30821 'INICIA VARS / LIMPA MORCEGO
'BATE ESTACA - CONFIG PARAMETROS INICIAIS 
'20154 IF MA%(24)>0 THEN GOSUB 30790 ELSE E1%=0
'PORTAL
20155 PO%=MA%(30)
'CORES
'20163 IF SC%>0  AND SC%<5   THEN 20204
'20164 IF SC%>12 AND SC%<17  THEN 20180
'20165 IF SC%>15 AND SC%<21  THEN 20190
'20165 IF SC%>15 AND SC%<21  THEN 20205
'20166 IF SC%>20             THEN 20200

'**** BACKGROUD
'57 BACKGROUND TOP
'58 BACKGROUND
'20156 LOCATE 1,21:PRINT MA%(57),MA%(58):gosub 5000
20170 RETURN
'******************************************************************************
'=== RESTORE - FIM
'******************************************************************************

'20171 SET TILE COLOR A,C:RETURN
'20172 SET TILE COLOR A, (2,12,12,0,2,12,12),(0,0,0,0,0,0,0)     :RETURN
'20173 SET TILE COLOR A, (10,14,10,0,10,14,10),(0,0,0,0,0,0,0)   :RETURN 'AMARELO
'20174 SET TILE COLOR A, (15,14,14,0,15,14,14),(0,0,0,0,0,0,0):RETURN 'AMARELO
'20174 SET TILE COLOR A, (7,5,5,0,7,5,5),(0,0,0,0,0,0,0)         :RETURN 'AMARELO
'20175 SET TILE COLOR A, (6,8,9,0,6,8,9),(0,0,0,0,0,0,0):RETURN 'VERMELHO
'20175 SET TILE COLOR A, (15,14,14,0,15,14,14),(0,0,0,0,0,0,0)   :RETURN 'AMARELO

'SC%>12 AND SC%<17
'20180 A=U%:GOSUB 20172:A=U1%:GOSUB 20172:A=U2%:GOSUB 20172:C=2:GOSUB 20500:C=12:GOSUB 20501:RETURN
'CINZA
'20190 C=14:A=U% :GOSUB 20174:A=U1%:GOSUB 20174:A=U2%:GOSUB 20174: C=4:GOSUB 20500:C=5:GOSUB 20501:RETURN
' SC%>20 
'20200 A=U%:GOSUB 20174:A=U1%:GOSUB 20174:A=U2%:GOSUB 20174:C=5:GOSUB 20500:C=4:GOSUB 20501:RETURN
'VERMELHO SC%>0  AND SC%<5 
'20204 A=U%:GOSUB 20175:A=U1%:GOSUB 20175:A=U2%:GOSUB 20175:C=5:GOSUB 20500:C=4:GOSUB 20501: RETURN
'15 AND SC%<21
'20205 A=U%:GOSUB 20175:A=U1%:GOSUB 20175:A=U2%:GOSUB 20175:C=14:GOSUB 20500:C=14:GOSUB 20501: RETURN
'COLUNA ESQUERDA
'20500 A=230:GOSUB 20171:A=231:GOSUB 20171:A=232:GOSUB 20171:RETURN
'20501 A=141:GOSUB 20171:A=142:GOSUB 20171:A=143:GOSUB 20171:RETURN
'******************************************************************************

'******************************************************************************
'=== INIMIGO
'******************************************************************************
8310 IF TIME-T%(V+4)<5 OR IN%(V,3)=0 THEN RETURN  
8311 T%(V+4)=TIME
8312 IF WK%(V)=3 THEN GOSUB 8401 
8313 IF IN%(V,2)=1 THEN z=2 ELSE z=0
8314 j=IN%(V,0)/8+z:l=(IN%(V,1)/8)+1

8315 _tl%=TILE(j,l)

8316 IF _tl%=U% OR _tl%=U1% OR _tl%=U2% OR j>30 or j<1 THEN IN%(V,2)=IN%(V,2)*-1  : GOSUB 8410 

8318 G=TILE(j,l+2):IF G<>U% THEN IN%(V,2)=IN%(V,2)*-1
8370 IN%(V,0)=IN%(V,0)+IN%(V,2)
'8371 IF SPR%(V)=0 THEN SPR%(V)=IN%(V,3)

8390 PUT SPRITE V+3,(IN%(V,0),IN%(V,1)),IN%(V,5),SPR%(V)
8391 WK%(V)=WK%(V)+1
8400 RETURN
'TROCA SPRITE
8401 WK%(V)=0:IF SPR%(V)=IN%(V,3) THEN SPR%(V)=IN%(V,4) ELSE SPR%(V)=IN%(V,3)
8403 RETURN

'FLIP SPRITE ' CONTROLE DO FLIP
8410 I1%=IN%(V,3)
8411 IF SPR%(V)=I1% OR SPR%(V)=I1%+1 THEN  SET SPRITE FLIP I1%,0:SET SPRITE FLIP I1%+1,0 
8412 IF MF%(V,1)=0 THEN MF%(V,1)=1 ELSE MF%(V,1)=0 'ROTINA CONTROLE FLIP
8413 MF%(V,0)=I1%   'SPRITE
8420 RETURN

' AJUSTA FLIP NA VIRADA DA TELA
8421 FOR A=0 TO 2
8422    I1%=MF%(A,0) 
8423    IF MF%(A,1)=1 THEN SET SPRITE FLIP I1%,0:SET SPRITE FLIP I1%+1,0:MF%(A,1)=0
8424 NEXT A 
8425 FLP%=0
8426 RETURN

'=======================================================================
'**** INICIALIZA OGROS
'=======================================================================
11000 M=3:J=0:A=0
11001 IN%(A,0)=-1:IN%(A,1)=-1:IN%(A,3)=0:IN%(A,4)=0:IN%(J,5)=0 'LIMPA POSIÇÕES DOS SPRITES
11002 J1%(A,0)=MA%(A+5)  'PEGA LINHAS DOS SPRITE DOS OGROS
11003 J1%(A,1)=MA%(A+8)  'PEGA COLUNAS DOS SPRITE DOS OGROS
11004 J1%(A,2)=MA%(A+11) 'COR
11005 J1%(A,3)=MA%(A+14) 'DIRECAO
11006 J1%(A,4)=MA%(A+17) 'SPRITE
11007 PUT SPRITE M+A,(-20,-20),0,0 'ESCONDE SPRITE OGRO
11008 A=A+1    
11009 IF A<3 THEN 11001 

'LOOP
11010 A=J1%(J,4):IF A<>0 THEN SPR%(J)=A:IN%(J,3)=A:IN%(J,4)=A+1:GOSUB 11022
11040 IF J>1 THEN 11060 ELSE J=J+1:M=M+1
11050 GOTO 11010

11022 IN%(J,0)=J1%(J,1)*8     'COLUNA
11023 IN%(J,1)=(J1%(J,0)*8)-1 'LINHA
11024 IN%(J,5)=J1%(J,2)       'COR
11025 PUT SPRITE M,(IN%(J,0),IN%(J,1)),IN%(J,5),IN%(J,3)
11026 IF J1%(J,3)=1 THEN IN%(J,2)=1 ELSE IN%(J,2)=-1 'DIREÇÃO INICIAL

'TILES - ESCONDE
11060 I=SC%
11061 FOR A=0 TO 5
11062   IF O%(I,A)<>0 THEN PUT TILE MA%(58),(OC%(I,A),OL%(I,A))
'11063   LOCATE 20,A:PRINT I,O%(I,A),OC%(I,A),OL%(I,A)
11064 NEXT 
'*** ESCONDE OBJETOS DO ALTO
11065 FOR A=0 TO 5
11066   IF E%(I,A)>0 THEN PUT TILE MA%(57),(EC%(I,A),EL%(I,A))
11067 NEXT

11068 GOSUB 31120

11070 RETURN


'**********************************************************************************************
'*** ENTRA NO PORTAL
'**********************************************************************************************
9880 C=JP% : JP%=0 ': S%=18 ': GOSUB 9201 'IF JP%>0 THEN JP%=0 ELSE Y%=Y%-2
9881 FOR W%=1 TO 6
9882    IF S%=15 THEN S%=18 ELSE S%=15
9883    GOSUB 9200 
9884    IF TIME-a<20 THEN 9884 
9885    a=TIME  
9386 NEXT W%
9387 JP%=C : GOSUB 10608
9388 RETURN 

'**********************************************************************************************
'*** DETECTA TIRO
'**********************************************************************************************
9745 TR%=1:TX%=RX%:MTX%=TX%: TL%=(Y%/8)+2:TG=0:ZZ=0
9746 FOR A=0 TO 31:GR(A)=TILE(A,TL%):NEXT 
9747 GR1=TILE(30,TL%):GR2=TILE(31,TL%)
9748 IF S%=3 OR S%=0 OR S%=21 THEN DR%=1 ELSE DR%=0
9749 RETURN 

'**********************************************************************************************
'=== TIRO
'**********************************************************************************************
9800 IF TIME-T%(8)<2 THEN RETURN  ELSE T%(8)=TIME
9802 IF  DR%=1 THEN 9803 ELSE 9820 'TIRO DIREITA/ESQUERDA

'**********************************************************************************************
'=== TIRO DIREITA
'**********************************************************************************************
9803 PUT TILE GR(TX%),(TX%,TL%):PUT TILE 190,(TX%+1,TL%):PUT TILE 191,(TX%+2,TL%)
9804 TX%=TX%+1
9805 IF ZZ=0 THEN PUT TILE GR(MTX%+1),(MTX%+1,TL%):ZZ=1 'CORRIGE A PRIMEIRA POSIÇÃO DO TIRO
9806 IF TX%>29 THEN 9815 'LIMITE DA TELA
9807 L=TILE(TX%+2,TL%)
'****************************
'DETECTA COBRINHA / SKRULL
'****************************
9808 IF (L>82 AND L<92) OR L=101 OR  L=103 THEN 9858
'****************************
'****************************
9809 IF L=U% OR L=U1% OR L=U2%  THEN 9811 'BATEU NUMA PAREDE - TIRO DIREITA
9810 RETURN
'=== BATEU NUMA PAREDE
9811 PUT TILE GR(TX%),(TX%,TL%)
9812 PUT TILE GR(TX%+1),(TX%+1,TL%)
9813 TR%=0:TX%=0
9814 RETURN
'=== LIMITE DA TELA
9815 PUT TILE GR1,(30,TL%):PUT TILE GR2,(31,TL%)
9816 TR%=0:TX%=0:RETURN
'**********************************************************************************************

'**********************************************************************************************
'=== TIRO ESQUERDA
'**********************************************************************************************
9820 PUT TILE 173,(TX%-2,TL%):PUT TILE 174,(TX%-1,TL%) 
9821 AX1%=GR(TX%) : IF AX1%>87 AND AX1%<90 THEN AX1%=0  
9822 PUT TILE  AX1%,(TX%,TL%) 'RASTRO
9823 TX%=TX%-1
9824 IF TX%<2 THEN 9830 'LIMITE DA TELA
9825 L=TILE(TX%-2,TL%)

'****************************
'DETECTA COBRINHA / SKRULL
'****************************
9826 IF (L>32 AND L<42) OR (L>99 AND L<106) OR L=101 OR  L=103 THEN 9850

'****************************
'****************************
9827 IF L=U% OR L=U1% OR L=U2%  THEN 9840 'BATEU NUMA PAREDE - TIRO ESQUERDA
9828 RETURN

'=== BATEU NUMA PAREDE
9840 PUT TILE GR(TX%-1),(TX%-1,TL%)
9842 PUT TILE GR(TX%) ,(TX%,TL%)
9843 TR%=0:TX%=0
9844 RETURN
'=== LIMITE DA TELA
9830 PUT TILE GR(0),(0,TL%):PUT TILE GR(1),(1,TL%)
9831 TR%=0:TX%=0:RETURN

'**********************************************************************************************
'**  EXPLODE (ESQUERDA)
9850 GOSUB 9840 'LIMPA FLECHA
9854 GOSUB 30625 'APAGA COBRINHA
'9855 LOCATE 1,3:PRINT _W:GOSUB 5000
9855 _W2%=_W*8:GOSUB 30650 'exibe explosão
9856 RETURN

'*** EXPLODE (DIREITA)
9858 GOSUB 9811 'LIMPA FLECHA
9859 GOSUB 30625 'APAGA COBRINHA
9860 _P=_P-1:_W2%=_W*8:GOSUB 30650 'exibe explosão
9861 RETURN

'**** VERIFICA SE O JOGADOR ESTÁ DO LADO ESQUERDO E VIRADO PARA O LADO ESQUERDO

'9900 E=27:GOSUB 31111:IF RT%=0 THEN RETURN'RETIRA ARCO DA LISTA / NÃO ENCONTROU


'RETIRA ARCO DA LISTA / NÃO ENCONTROU
9900 IF TIME-T%(29)>120 THEN T%(29)=TIME ELSE RETURN
9901 E=27:GOSUB 31111:IF RT%=0 THEN RETURN 
9911 IF S%=3 OR S%=0 OR S%=21 THEN DR%=1 ELSE DR%=0
9912 IF DR%=0 AND RX%<2  THEN RETURN 
9913 IF DR%=1 AND RX%>29 THEN RETURN 
9914 GOTO 9745
' poção power
'9915 'IF TIME-T%(29)<5 THEN RETURN ELSE T%(29)=TIME
'9916 E=22:GOSUB 31111:IF RT%=0 THEN RETURN
'9917 T%(28)=TIME:T%(29)=TIME:RETURN




'************************************************************************

 'PLATAFORMA
''''''''''30201 XI%=5:XF%=26
30201 XI%=10:XF%=21:XB%=187
30210 IF TIME-T%(11)<13 THEN RETURN  
30215 T%(11)=TIME
30217 IF X11% > XF%  THEN JX%=-1
30218 IF X11% < XI%  THEN JX%=1 
30220 _S=XB%:GOSUB 30250
30221 X11%=X11%+JX%
30223 _S=20:GOSUB 30250
30224 _K=(Y%/8)+3 : HJ%=TILE(X%/8+JX%,(Y%/8)+3):HW%=TILE(X%/8+(JX%*2),(Y%/8)+3)
30225 IF HJ%=20 OR HW%=20 AND JP%=0  THEN  X%=X%+(8*JX%):GOSUB 9200
30233 RETURN

' 'SUB ROTINA - PLATAFORMA
30250 FOR A%=0 TO 1
30251   PUT TILE _S,(X11%+A%,Y11%)
30252 NEXT A%
30253 RETURN
'************************************************************************

'************************************************************************
' OBJETOS DA BARRA DE ITENS
'************************************************************************
30300 IF TIME-T%(25)<4 THEN RETURN ELSE T%(25) = TIME 
30301 E = TILE(RX%+1,RY%-4) 
'30302 S=V%(1):IF E=V%(0)             THEN KL%=0:KY%=9:GOTO 30309  'CHAVE ESCONDIDA
'30303 S=V%(3):IF E=V%(2) AND KY%=0   THEN 30309 'CHAVE 
'30303 S=V%(3):IF E=V%(2)    THEN 30309 'CHAVE 
30304 FOR A=0 TO 20 STEP 2
30305     S=V%(A+1) : IF E=V%(A) THEN 30308
30306 NEXT 
30307 RETURN

30308 IF S=210 THEN S=MA%(57)
30309 PUT TILE S,(RX%+1,RY%-4)

'--- Guarda o item da tela 
30310 W=SC%:I=RX%+1:K=RY%-4 ' W=Tela Atual, I=Coluna, K=Linha
30311 IF S=MA%(57) THEN 30321 'OBJETO DO ALTO
30312 FOR A=0 TO 5
30313	  IF E%(W,A)=0 THEN 30316
30315 NEXT A
30316 E%(W,A)=S:EC%(W,A)=I:EL%(W,A)=K 
30317 RETURN

' OBEJTO DO ALTO
30321 FOR A=0 TO 5
30322	  IF EP%(A)=0 THEN 30324
30323 NEXT A
30324 EP%(A)=E
30330 GOSUB 31120
'30330 FOR A=0 TO 5:LOCATE 20,A:PRINT EP%(A):NEXT A
30331 RETURN
'************************************************************************

'*****************************************************************************************************************************
'*** ARMADILHA -OK
'*****************************************************************************************************************************
30420 IF TIME-T%(12)<30 THEN RETURN  ELSE T%(12)=TIME:ON ES%+1 GOTO 30325,30326,30327
30325 ES%=1:FOR FF%=0 TO PQ%: V=M1%   : B=PC%(FF%):Q=PD% : GOSUB 30328                                          :NEXT :RETURN
30326 ES%=2:FOR FF%=0 TO PQ%: V=M1%+1 : B=PC%(FF%):Q=PD% : GOSUB 30328: V=M1%     : B=PC%(FF%):Q=PD%-1 :GOSUB 30328 :NEXT :RETURN
30327 ES%=0:FOR FF%=0 TO PQ%: V=M1%   : B=PC%(FF%):Q=PD% : GOSUB 30328: V=MA%(58) : B=PC%(FF%):Q=PD%-1 :GOSUB 30328 :NEXT :RETURN
30328 PUT TILE V,(B,Q) 
30329 GOSUB 9210 : RETURN 'VERIFICA SE O HEROI ESTÁ EM CIMA DA ARMADILHA
'30330 RETURN
'*****************************************************************************************************************************
'ARMADILHA - ACENDE LUZ DE FUNDO
30340 '
30341 LF%=LF%-1:GOSUB 31100:IF LF%=0 THEN 31260 ELSE H2%=0:COLOR ,,8:T%(19)=TIME: GOSUB 30350
30342 RETURN 

'*****************************************************************************************************************************
' acende a cor de fundo
'*****************************************************************************************************************************
30350 IF TIME-T%(19)<3 THEN 30350 ELSE 30360 
'*****************************************************************************************************************************
'ARMADILHA VOLTA COR 
'*****************************************************************************************************************************
30360 COLOR ,,0:M2%=1:RETURN 
'*****************************************************************************************************************************
' CONFIG
'*****************************************************************************************************************************
30361 M1%    = MA%(20)    'CHAR
30362 PC%(0) = MA%(21)    'ESTACA 1
30363 PC%(1) = MA%(21)+4  'ESTACA 2
30364 PC%(2) = MA%(21)+8  'ESTACA 3 
30365 PD%    = MA%(22)    ' Y 
30366 PQ%    = MA%(23)    ' QTDE
30367 RETURN


' OBSTACULOS
'198-203 Pontas
'59-64   Escorpião
'99-106  Skrull
'32-42   cobra esquerda
'82-92   cobra direita
'133-136 ESTACAS

'''''30370 IF TIME-T%(26)<25 THEN RETURN ELSE T%(26)=TIME
'''''30371 IF DI%>0 THEN I2%=2 ELSE I2%=1
'''''30372 B1%=TILE(RX%+I2%,RY%-1) : B2%=TILE(RX%+I2%-1,RY%-1) 
'''''30373 IF JP%=0 AND ((B1%>32 AND B1%<42) OR  (B1%>82 AND B1%<92) OR (B1%>198 AND B1%<203) OR (B1%>59 AND B1%<64) OR (B1%>99 AND B1%<106) OR B1%=37)THEN 30340:RETURN
'''''30374 IF JP%=0 AND ((B2%>32 AND B2%<42) OR  (B2%>82 AND B2%<92) OR (B2%>198 AND B2%<203) OR (B2%>59 AND B2%<64) OR (B2%>99 AND B2%<106) OR B2%=37)THEN 30340:RETURN
''''30376 RETURN

'
30380 IF TIME-T%(26)<25 AND ZK%=1 THEN RETURN ELSE T%(26)=TIME:ZK%=0
30381 IF JP%=0 AND ((B1%>59 AND B1%<64) OR (B1%>198 AND B1%<203) OR (B1%>32 AND B1%<42) OR (B1%>99 AND B1%<106) OR (B1%>32 AND B1%<42) OR (B1%>82 AND B1%<92) OR (B1%>133 AND B1%<136)) THEN ZK%=1 : GOTO 30340
30382 IF JP%>0 AND (B2%=201 OR B2%=134 OR B2%=41 OR B2%=37)  THEN ZK%=1: GOTO 30340
30384 IF B1%=186 OR B1%=133 OR (TY%>22 AND (B1%=163 OR B1%=136)) THEN 31260
30385 RETURN




'*****************************************************************************************************************************
'*** GOTEIRA
'*****************************************************************************************************************************
7000 IF TIME-T%(13)<LT% THEN RETURN ELSE T%(13)=TIME
7002 ON F1% GOTO 0,0,0,7040,7045,7046,7047:GOTO 7030
'=== DESVIOS - P%(0,0) = CHAR GOTAS
'7010 F1%=1:TG%=193:GOTO 8000 
'7020 F1%=2:TG%=194:GOTO 8000 
7030 F1%=4:TG%=195:GOTO 8000 

7040 LT%=10:F1%=5:Y13%=Y13%+1 :C%=MA%(57):GOSUB 8000:RETURN
7045 Y13%=Y13%+1              :C%=MA%(58):GOSUB 8000:RETURN              'CAINDO
7046 TG%=196                  :GOSUB 8000:F1%=7:RETURN    'COLIDIU
7047 TG%=MA%(58)              :GOSUB 8000:F1%=0:Y13%=MY13%:LT%=30:RETURN
' '*****************************************************************************************************************************
' '*****************************************************************************************************************************
' '*** EXIBE GOTEIRA
' '*****************************************************************************************************************************
8000 PUT TILE TG%,(X13%,Y13%)
8012 IF F1%=5 THEN  PUT TILE C%,(X13%,Y13%-1):GOSUB 8100 'APAGA RASTRO QDO ESTÁ CAINDO
8014 IF TILE(X13%,Y13%+1)<>MA%(58) THEN F1%=6      'COLISÃO COM O CHÃO
8090 RETURN
' '=== COLISAO
8100 CT%=TILE(X%/8,TY%-3):CK%=TILE(X%/8+1,TY%-3)
8110 IF CT%=195 OR CK%=195 THEN F1%=6:COLOR ,,8:T%(19)=TIME:GOSUB 8121:GOTO 7046'reduz coração
8120 RETURN
' '*****************************************************************************************************************************
 8121  IF TIME-T%(19)<3 THEN 8121 ELSE COLOR ,,0:RETURN
' '*****************************************************************************************************************************
' 'CONF VAR GOTEIRA
8122 X13%=MA%(28) : Y13%=MA%(29) : MY13%=Y13%
8123 RETURN
' '*****************************************************************************************************************************


'*****************************************************************************************************************************
'*** PORTAL
'*****************************************************************************************************************************
30500 IF TIME-T%(14)<10 THEN RETURN  ELSE T%(14)=TIME
30510 IF R=1 THEN R=0:_G%=PO% ELSE R=1:_G%=PO%+1
30550 FOR A=0 TO 2:PUT TILE _G%,(MA%(31),MA%(32)+A):NEXT 
30560 RETURN
'**** DESATIVAR PORTAL

  30570 E=223:GOSUB 31111 'RETIRA DISQUETE DA LISTA
  30571 IF RT%=0 THEN 30574 'NÃO ENCONTROU
  30573 C=MA%(57):PR%=0:FOR A=0 TO 2:PUT TILE C,(MA%(31),MA%(32)+A):C=MA%(58):NEXT 'LIMPA O PORTAL
  30574 RETURN
  '*****************************************************************************************************************************

'*****************************************************************************************************************************
'**** EXPLOSÃO
'*****************************************************************************************************************************
30600 IF TIME-T%(15)<MA%(47) THEN RETURN  ELSE T%(15)=TIME
30609 _P=MA%(33) : _W=MA%(34)  
'30610 Y=_R+1
30610 ON _R+1 GOTO 30616,30613,30622
30611 RETURN
'30611  IF _R=0 THEN 30616 ELSE IF _R=1 THEN 30613 ELSE IF _R=2 THEN 30622 else return'30619 ELSE 30622

30613 _R=0 : _W2%=_W   : _C%=35:GOSUB 30641
30614        _W2%=_W+1 : _C%=38:GOSUB 30641
30615 RETURN

30616 _R=1 : _W2%=_W   : _C%=41:GOSUB 30641
30617        _W2%=_W+1 : _C%=44:GOSUB 30641
30618 RETURN       

'***** APAGA COBRINHA
 30625 MA%(47)=3:T%(15)=TIME : _R=2 :  _W=MA%(34)  
 30626 _W2%=_W   : GOSUB 30641
 30627 _W2%=_W+1 : GOSUB 30641
 30629 RETURN    

'***** APAGA EXPLOSÃO
 30622 _W2%=-20:GOSUB 30650
 30623 _R=0:SK%=0 
 30624 RETURN 

'**** MONTA INIMIGO
30641 FOR _I% = 0 TO 2
30642   IF _R<2 THEN _C2%=MA%(_C%+_I%) ELSE _C2%=0
30643   PUT TILE _C2%,(_P+_I%,_W2%)
30645 NEXT  _I%  
30646 RETURN

'**** EXPLOSÃO/LIMPA EXPLOSÃO
30650 PUT SPRITE 9,((_P*8)+8,_W2%), 15,42 'EXPLOSÃO
30658 RETURN

'*****************************************************************************************************************************



' '*****************************************************************************************************************************
' '*** BATE ESTACA - OK
' '*****************************************************************************************************************************
' 30700 IF TIME-T%(16)<11 THEN RETURN  ELSE T%(16)=TIME:ON EK%+1 GOTO 30710,30711,30720,30720,30731,30731,30733,30710
' '
' 30710 EK%=1:E3%=MA%(26):GOTO 30747
' 30711 GOTO 30750
' 30720 E3%=E3%+1 :GOTO 30750
' 30731 E3%=E3%-1 :GOTO 30750
' '
' 30733 E3%=E3%-1 :GOTO 30770

' 30747 GOSUB 30780 
' 30748 RETURN
' '
' 30750 EK%=EK%+1
' 30751 GOSUB 30782:GOSUB 30781 
' 30753 IF EK%>4 THEN GOSUB 30783
' 30760 RETURN
' '
' 30770 EK%=EK%+1
' 30771 GOSUB 30781:GOSUB 30783 
' 30772 RETURN
' '
' 30780 PUT TILE E1%,(E4%,E3%)  :PUT TILE E1%+1,(E4%+1,E3%)   :RETURN
' 30781 PUT TILE E1%,(E4%,E3%+1):PUT TILE E1%+1,(E4%+1,E3%+1) :RETURN
' 30782 PUT TILE E2%,(E4%,E3%)  :PUT TILE E2%+1,(E4%+1,E3%)   :RETURN
' 30783 PUT TILE   0,(E4%,E3%+2):PUT TILE     0,(E4%+1,E3%+2) :RETURN

' '
' '**************************************
' 'BATE ESTACA  - CONFIG
' '**************************************
' 30790 E1%=MA%(24) 'CHAR1
' 30791 E2%=MA%(25) 'CHAR2
' 30792 E3%=MA%(26) 'Y 
' 30793 E4%=MA%(27) 'X 
' 30794 EK%=1
' 30795 RETURN
'*****************************************************************************************************************************



'*****************************************************************************************************************************
'***** MORCEGO
' Z1% = contador para mudar sprite (CONTROLE)
' Z2% = sprite (CONTROLE)
'*****************************************************************************************************************************

30800 IF TIME-T%(17)<N6% THEN RETURN  ELSE T%(17)=TIME

'30803 IF N5%>150 THEN IF DI%<0 THEN Z6%=X%-30 ELSE Z6%=X%+30 'SOMENTE PARA O POLVO - MUDA X
'30804 IF N7%<0   THEN N6%=2 ELSE N6%=5         'TIME AJUSTE 

30802 IF N5%>N3% OR N5%<N4%	THEN N7%=N7%*-1  'MUDA DIRECAO QDO ATINGIR OS LIMITE
30801 IF Z1%=0 THEN Z1%=4:IF Z2%=N1% THEN Z2%=N1%+1 ELSE Z2%=N1% 'CONTADOR / MUDAR SPRITE
30805 PUT SPRITE 6,(N2%,N5%),N8%,Z2%
30806 IF N9%=1 THEN N5%=N5%+N7%:Z1%=Z1%-1
30807 RETURN

'MORCEGO CONF PAR
30810 N1%=MA%(48) 'SPRITE
30811 N2%=MA%(49) 'X
30812 N3%=MA%(50) 'Y-TOP
30813 N4%=MA%(51) 'Y-DOWN
30814 N5%=MA%(52) 'Y-INI 
30815 N6%=MA%(53) 'TIME
30816 N7%=MA%(54) 'SPT/X
30817 N8%=MA%(55) 'COR
30818 N9%=MA%(56) 'ATIVO
30820 RETURN

' LIMPA MORCEGO
30821 PUT SPRITE 6,(-20,-20),0,0
30822 N1%=0
30823 RETURN

'30900 Z1%=4 'CONTADOR MUDA SPRITE
'30902 IF Z2%=37 THEN Z2%=38 ELSE Z2%=37
'30902 IF Z2%=31 THEN Z2%=32 ELSE Z2%=31
'30910 RETURN

'**** MUDA X DO POLVO
' 30811 IF DI%<0 THEN N2%=X%-30 ELSE N2%=X%+30
'30812 RETURN

'30901 IF Z2%=31 THEN Z2%=32 ELSE Z2%=31 
'30901 IF Z2%=29 THEN Z2%=30 ELSE Z2%=29
'30902 IF Z2%=37 THEN Z2%=38:Z5%=8 ELSE Z2%=37:Z5%=9

'*****************************************************************************************************************************

'Compiled code occupied 75.0% of avaliable space
'Compiled code occupied 75.5% of avaliable space
'Compiled code occupied 80.7% of avaliable space
'Compiled code occupied 82.9% of avaliable space
'Compiled code occupied 86.7% of avaliable space

'***  FLECHA
30930 IF TIME-T%(21)>180 THEN H1%=1
30931 RETURN

31000 IF TIME-T%(20)<1 THEN RETURN  ELSE T%(20)=TIME
31011 PUT SPRITE 8,(FL%,Y%),9  ,40
31012 IF COLLISION(0, 8)>0 THEN 31031
31020 IF FL%<150 THEN FL%=FL%+4 ELSE GOSUB 31032
31030 RETURN

'FLECHA ATINGE 
31031 GOSUB 30340
31032 H2%=0:T%(21)=TIME:H1%=0:FL%=8:PUT SPRITE 8,(-20,-20),5,0
31033 RETURN

'1 - RELAMPAGO
31040 IF TIME-T%(23)>1000 THEN T%(23)=TIME:CD2%=5:CD%=15
31041 RETURN

'2 - RELAMPAGO
31050 IF TIME-T%(24)<10 THEN 31060 ELSE T%(24)=TIME:CD2%=CD2%-1
31051 IF CD%=4 THEN CD%=15 ELSE CD%=4
 
31052 FOR Z%=214 TO 217
31053      SET TILE COLOR Z%,CD%
31055 NEXT 
31060 RETURN

'VIDA
31100 FOR X=1 TO LF%:PUT TILE 171,(X,23):NEXT X:PUT TILE 0,(X,23)
31110 RETURN

  '**** RETIRA ITEM DA LISTA
  31111 RT%=1:A=0 ': LOCATE 0,0:PRINT TIME : GOSUB 5000 'RETORNO
  
  31112 FOR A=0 TO 5
  31113	 IF EP%(A)=E THEN 31117
  31114 NEXT A

  31115 RT%=0 
  31116 RETURN

'EXCLUIR ITEM
31117 EP%(A)=0
'31118 IF TIME-kt%<20 THEN 31118
'LISTA ITENS
31120 X=30  
31121 FOR A2=0 TO 5
31124   PUT TILE EP%(A2),(X,23):X=X-2
31125 NEXT A2
31126 RETURN

'**** FECHADURA ABRE O PORTAL
31140 E=172:GOSUB 31111 'RETIRA CHAVE DA LISTA
31141 IF RT%=1 THEN SP%=1:SET TILE COLOR 175,0 ' ENCONTROU
31142 RETURN 

' 31150
' 31160

'***********************
' CARREGA DADOS
'***********************
31200 RESTORE LN%-1
31202 READ S$
31203 H$="":C=0 ': LOCATE 0,0:PRINT S$,LEN(S$)
31204 FOR A=1 TO LEN(S$)
31205   C$=MID$(S$,A,1)
31206   IF C$="," THEN GOSUB 31220  ELSE H$=H$+C$
31207 NEXT A
31208 GOSUB 31220
31209 RETURN

'**** CONFIGURA DETALHES DA TELA
31220 IF LN%=50 THEN  V%(C) = VAL(H$) 'ITENS DE CIMA
31221 IF LN%<50 THEN MA%(C) = VAL(H$) 'DADOS TELAS
31222 IF LN%=52 THEN KJ%(C) = VAL(H$) 'PORTAL AZUL
31223 IF LN%=53 THEN SQ%(C) = VAL(H$) 'SQUAD CENTRAL
31225 H$="":C=C+1
31226 RETURN


'===> COLISÃO DE SPRITES
31230 IF TIME-T%(27)>20 THEN T%(27)=TIME ELSE 31237
31233 IF COLLISION(1, 2)+COLLISION(1, 3)+COLLISION(1, 4)+COLLISION(1, 5)+COLLISION(1, 6)+COLLISION(1, 8)>0 THEN 30340
31237 RETURN

' PISCA JOGADOR
31240 IF TIME-T%(27)>8 THEN T%(27)=TIME ELSE RETURN
31241 IF CO1%=8 THEN CO1%=7 ELSE CO1%=8
31242  GOSUB 9200
31243 IF TIME-T%(28)>120 THEN  31250
31245 RETURN

31250 CO1%=12:CO2%=9:CO3%=15:GOSUB 9201:RETURN

'**** GAME OVER
 
31260 GOSUB 30360
31261 F%=1:S%=12:GOSUB 9201
31270 GOTO 31270



' PORTAL AZUL
31280 E=25:GOSUB 31111 : IF RT%=0 THEN RETURN
31285 IF RT%=1 THEN SP%=1:GOTO 31291
31290 RETURN 

'ABRE PORTAL AZUL
31291 KC%=MA%(59):KI%=MA%(60)
31293 FOR A=0 TO 8
31294   PUT TILE KJ%(A),(KC%,KI%) 
31295   IF  A=2 OR A=5 THEN KI%=KI%+1:KC%=27 ELSE KC%=KC%+1
31296 NEXT
'31296 CMD WRTSCR SC%+5 
31297 RETURN

'**********
'31300 PUT SPRITE 4,(IN%(1,0),IN%(1,1)), 8,42 
'31320 IN%(1,3)=0 : T%(15)=TIME : XP%=1
'31330 RETURN

'APAGA EXPLOSAO DA COLISÃO
31350 IF TIME-T%(15)>5 THEN 31351 ELSE 31361
31351 IF XP%=2 THEN C=10: XP%=0:IN%(IDX%,0)=-20:IN%(IDX%,1)=-20:GOTO 31353
31352 IF XP%=1 THEN C=8 : XP%=2:GOTO 31353 'MOSTRA EXPLOSÃO
31353 PUT SPRITE 9,(IN%(IDX%,0),IN%(IDX%,1)), C,42  
31354 T%(15)=TIME
31361 RETURN

'XP%=0
31390 GOSUB 31500 
31391 PUT SPRITE IDX%+3,(-20,-20), 2,42 'ESCONDE INIMIGO
31392 IN%(IDX%,3)=0 
31393 C=15 : XP%=1 
31394 GOTO 31353 'MOSTRA EXPLOSÃO

31500 ZZ=IN%(IDX%,0)
31501 IF S%=3 OR S%=21 THEN _I%=3  ELSE _I%=-3

31502 FOR A=1 TO 5
31510 PUT SPRITE IDX%+3,(ZZ,IN%(IDX%,1)), IN%(IDX%,5),IN%(IDX%,3) 'ESCONDE INIMIGO
31515 IF TIME-T%(15)<2 THEN 31515 ELSE T%(15)=TIME
31516 ZZ=ZZ+_I%
31520 NEXT A
31521 IN%(IDX%,0) = ZZ
31530 RETURN

' COLISÃO CHUTE
31600 FOR A=0 TO 2
31601   IF  COLLISION(1, A+3)>0 AND JP%>0 THEN IDX% = A : GOTO  31390
31610 NEXT
31620 RETURN



31630 LOCATE 1,2: PRINT CHR$(49)+CHR$(46)+STR$(PT%) 
31631 LOCATE 28,1: PRINT CHR$(219)+CHR$(220)+CHR$(221)
31632 LOCATE 27,2: PRINT STR$(_MS%) + CHR$(120) + "6"

 31700 _X=14:_Y=0:_I%=0
 31701 FOR A=0 TO 3
 31702  FOR A2 = 0 TO 3 
 31703    PUT TILE SQ%(_I%),(_X+A2,A)
 31704    _I%=_I%+1
 31705  NEXT A2
 31706 NEXT A 
 31707 RETURN

'

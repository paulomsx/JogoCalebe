FILE "gd1.akm"            ' 0 - Music (exported from Arkos Tracker 2)
FILE "gd1.akx"            ' 1 - Sound Effects (expord from Arkos Tracker 2)

FILE "TILES.chr.plet5"  ' 2 - Tiles Patterns (exported from nMSXTiles)
FILE "TILES.clr.plet5"  ' 3 - Tiles Colors (exported from nMSXTiles)

FILE "S8.SPR"           ' 4 - Sprites (exported from TinySprite)

FILE "TELA0.plet5"      ' 5 - Tela 1 

0 '
11 X%=8:Y%=79:TY%=12:S%=0  'POISICAO INICIAL DO JOGADOR
12 DX%=8:S%=0              'POSIÇÃO INICIAL CANTO ESQUERDA - VIRADO PARA DIREITA

10 GOSUB 10000       'INICIALIZA GAME
20 GOSUB 10200       'DEFINE VARIÁVEIS INICIAIS
30 GOTO  10570       'INICIALIZA JOGO TELA 1

'===>GET USER INPUT
9100 K% = INKEY
9101 J% = STICK(0) OR STICK(1)
9102 B% = STRIG(0) OR STRIG(1)
9105 RETURN
 
'===>EXIBE JOGADOR
9200 IF JP%>0 THEN IF DI%=-1 THEN S%=24 ELSE S%=21 '**** DEFINE O SPRITE NO PULO
9201 PUT SPRITE  0,(X%,Y%), 5,S%    'COR AZUL
9202 PUT SPRITE  1,(X%,Y%), 9,S%+1  'COR BRANCA
9203 PUT SPRITE  2,(X%,Y%),15,S%+2  'COR PELE

9204 'LOCATE 0,0:PRINT "                                                   " : LOCATE 0,0:PRINT "X:",X%,"-TX",X%/8,"/Y:",Y%,"-TY:",TY%,"-TL",TL%-4,"US",US%
9205 IF F%=1 THEN RETURN 'FIM DO JOGO ?
9206 RX%=X%/8:RY%=TY%:CF%=TILE(RX%,TY%):CF2% = TILE(RX%+1,TY%) 'TILE PISO 
9207 GOSUB 9400  'controle queda 
9210 RETURN



'**********************************************************************************************/
' ** MOVIMENTO DO JOGADOR
'**********************************************************************************************/
9300 IF ST%=1                       THEN RETURN 'SE TIVER EM QUEDA NÃO MOVIMENTA AS SETAS
'PULO
9301 IF JP%=0 AND US%<>1          THEN IF B%<>0 THEN JP%=6:SE%=1:SD%=1:RETURN           'PULO
9320 DT%=TIME-T1%:IF DT%<7          THEN RETURN ELSE T1%=TIME 'TIME
'SOBE
9321 IF J%=1                        THEN GOSUB 3300:RETURN 'SOBE
'DESCE
9322 IF J%=5                       THEN GOSUB 4000:RETURN  'DESCE
9325 IF J%=3 AND SD%=1  AND US%<>1 THEN SE%=1:GOSUB 9360:RETURN 'DIREITA
9326 IF J%=7 AND SE%=1  AND US%<>1 THEN SD%=1:GOSUB 9350:RETURN 'ESQUERDA
9327 IF J%=0 AND (S%<>0 OR S%<>9)  THEN GOSUB 9460:RETURN  'DEFINE POSIÇÃO SENTIDO
9340 RETURN
'**********************************************************************************************/

'**********************************************************************************************/
'MOVE ESQUERDA
'**********************************************************************************************/
9350 GOSUB 9700 'VERIFICA SE HÁ PAREDE DO LADO ESQUERDO
9352 IF SE%=0 THEN SE%=1:RETURN
9353 DI%=-1:DX% =-8:X%=X%+DX%:IF S%=6 THEN S%=9 ELSE S%=6 
9355 GOSUB 9200 'EXIBE JOGADOR

9700 'XT%=TILE(RX%-1,RY%-1) 'PÉ
9701 XU%=TILE(RX%-1,RY%-2)  'NARIZ
9703 IF XT%=128 OR XU%=128 THEN SE%=0:RETURN   'BLOCO VERMELHO (PAREDE) 157-PORTAL VERDE
9719 RETURN 
'**********************************************************************************************/

'**********************************************************************************************/
'MOVE DIREITA
'**********************************************************************************************/
9360 GOSUB 9720 'VERIFICA A DIREITA
9363 IF SD%=0 THEN SD%=1:RETURN
9366 DI%=1:DX%=8:X%=X%+DX%:IF S%=3 THEN S%=0 ELSE S%=3 
9368 GOTO 9200 'EXIBE JOGADOR

9720 XT%=TILE(RX%+2,RY%-1)   'PÉ
'9723 XU%=TILE(RX%+2,RY%-2)

9724 IF XT%=128 THEN SD%=0:RETURN 'BLOCO VERMELHO (PAREDE)
9729 RETURN 


'**********************************************************************************************/
' CONTROLE DA QUEDA
'**********************************************************************************************/
9400 IF US%=1 THEN RETURN  ' SUBINDO ESCADA
9404 IF (CF%<>128 AND CF2%<>128 AND CF%<>188 AND CF2%<>188 AND CF%<>189 AND CF2%<>189)  AND JP%=0 THEN Q%=8:ST%=1 ELSE Q%=0:ST%=0  '=== VERIFICA PISO
9410 RETURN


'=== QUEDA LIVRE
9500 IF TIME-VQ%<4 OR Q%=0 THEN RETURN  ' CONTROLA VELOCIDADE DA QUEDA
9502 VQ%=TIME
9510 GOSUB 9400 'CONTROLE DA QUEDA
9520 IF Q%=0 THEN RETURN
9522 GOSUB 9460 'CAI EM PÉ
9530 Y%=Y%+Q%:TY%=TY%+ST%
9590 RETURN
'**********************************************************************************************/

'**********************************************************************************************/
'PULO
'**********************************************************************************************/
9600 IF TIME-T16%<5 OR JP%=0 THEN RETURN 
9602 T16%=TIME
9620 JP%=JP%-1                           
9630 IF JP% > 3 THEN Y%=Y%-8:TY%=TY%-1
9631 IF JP% < 1 THEN Y%=Y%+8:TY%=TY%+1
9641 GOTO 9200

'=== DEFINE POSIÇÃO SENTIDO (APÓS QUEDA OU PULO)
9460 IF US%=1 THEN RETURN 'SUBINDO ESCADA
9463 IF DX%<0 THEN S%=9 ELSE S%=0 
9464 GOSUB 9200
9465 RETURN 

'**********************************************************************************************/
'=== SOBE
3300 IF US%=1 THEN 3320 'ATIVADO ESCADA
3305 EE% =TILE(RX%+1,RY%-2):ED%=TILE(RX%  ,RY%-2) 
3310 IF EE%=188 OR EE%=189 OR ED%=189  THEN US%=1 ELSE RETURN 'VERIFICA SE ESTÁ NA PONTA DA ESCADA PRA SUBIR
'POSICIONA NO MEIO 
3311 IF ED%  = 189 THEN X%=X%-8 'LADO DIREITO 
3312 IF EE%  = 188 THEN X%=X%+8 'LADO ESQUERDO
3320 IF S%=15 THEN S%=18 ELSE S%=15 'ALTERNA SPRITES DA SUBIDA DA ESCADA
3321 Y%=Y%-8:TY%=TY%-1:GOSUB 9200 
'VERIFICA TILE ACIMA PARA SABER DE A ESCADA TERMINOU
3322 EE%=TILE(RX%+1,RY%-1) 
3323 IF US%=1 AND (EE%=0 or EE%=187 or EE%=139) THEN US%=0 'TERMINOU A ESCADA
3324 IF TY%=5 THEN 10781 'LIMITE SUPERIOR DA TELA
3390 RETURN
'**********************************************************************************************/
'=== DESCE ESCADA
4000 IF US%=1 THEN 4020
4005 EE%=TILE(RX%+1,RY%+1)
4006 ED%=TILE(RX%,RY%+1) 
4010 IF EE%=188 OR EE%=189 OR ED%=189 OR ED%=188  THEN US%=1 ELSE RETURN 'VERIFICA SE ESTÁ NA PONTA DA ESCADA PRA SUBIR
4011 IF ED% = 189 THEN  X%=X%-8 'LADO DIREITO 
4012 IF EE% = 188 THEN  X%=X%+8 'LADO ESQUERDO
4020 IF S%=15 THEN S%=18 ELSE S%=15
4030 Y%=Y%+8:TY%=TY%+1:GOSUB 9200
4040 EE%=TILE(RX%+1,RY%) 
4050 IF US%=1 AND (EE%=138 OR EE%=128 OR EE%=148 OR EE%=149) THEN US%=0
4090 RETURN
'**********************************************************************************************/

'DEBUG
5000 'LOCATE 0,0:PRINT STRING$(40," ")
5010 LOCATE 0,23 : PRINT TIME, " - US%",US%
5020 K% = INKEY:IF K%=13 THEN RETURN ELSE GOTO 5020
5060 RETURN 
'5000 RETURN 

'**********************************************************************************************/
' CONFIGURAÇÃO INICIAL
'**********************************************************************************************/

' INICIALIZA TELA
10000 COLOR 15,0,0:SCREEN 2,2,0
10002 SET TILE ON  
10005 CMD WRTSPR  4        ' Load sprite resource
'10007 CMD PLYLOAD 0, 1     ' Load music and sound effect resource
'10008 CMD PLYSONG 0        ' Load game song theme (Bach Invention 14)
'10009 CMD PLYPLAY          ' Play theme
'10023 SET TILE COLOR 164,0
'10024 SET TILE COLOR 156,0
10020 CMD WRTCHR 2       ' Load tiles patterns resource
10021 CMD WRTCLR 3       ' Load tiles colors resource
'10022 CMD WRTSPR 4
10022 TV%=20
10023 CMD SETFNT  1
10024 SET TILE COLOR 169,0
10030 RETURN    

'==== DEFINE VARIÁVEIS INICIAL
10200 T1%=TIME:P%=TL%-5         
10220 SD%=1:SE%=1
10230 Q%=0:ST%=0:VQ%=T1%    'CONTROLE DA QUEDA
10240 JP%=0                 'PULO
10250 F%=0                  'FIM DE JOGO
10252 DIM TL$(4)
10260 RETURN

'==== FUNÇÃO TELA NOVA
10300 CMD DISSCR
' 10301 CMD WRTCHR 2       ' Load tiles patterns resource
' 10302 CMD WRTCLR 3       ' Load tiles colors resource
' 10303 CMD WRTSPR 4
10303 FOR A%=4 TO 6:PUT SPRITE A%,(0,0),15,-1:NEXT A%
10305 CMD WRTSCR TL% 'Carrega tela
10360 'CMD SETFNT  1
10365 'SET TILE COLOR 164,0:SET TILE COLOR 190,0
10366 'SET TILE COLOR 156,0:SET TILE COLOR 169,0
10370 CMD ENASCR   
10380 RETURN

'====
10420 GOSUB 10200       'CONFIGURAÇÃO INICIAL
10430 GOSUB 10300       'FUNCAO TELA

' Altera cor das colunasd na tela 5
'10431 IF TL%>=9 THEN FOR I%=208 TO 213 STEP 2:SET TILE COLOR I%,11:NEXT I%

10500 GOSUB 9200        'EXIBE JOGADOR
'LOOP
10510 GOSUB 9100        'GET USER INPUT
10520 GOSUB 9300        'MOVIMENTOS HEROI
10530 GOSUB 9600        'PULO
10540 GOSUB 9500        'QUEDA LIVRE
10550 GOSUB 10561       'ZERA O TIMER
10560 GOTO 10510

'==== ZERA O TIME
10561 IF TIME<0 THEN TIME=0:VQ%=0:T1%=0:T%=0:VT%=0:T7%=0:DT4%=0:T4%=0:T5%=0:T11%=0:T13%=0:T14%=0:T15%=0:T10%=0:T16%=0
10562 RETURN

'==== TELA 1
'X%=8:Y%=79:TY%=12
10570 TL%=5                                 'POSICAO INICIAL DO JOGADOR
10571 RP%=16:CP%=31                         'ABRE PORTÃO FASE 1
'10572 US%=0                                'UPSTAIR SOBE ESCADA ATIVADO
'10573 VT%=T1%:CL%=9                        'LUZ DA TOCHA
10574 S7%=134:T7%=T1%: Y7%=21: X7%=13       'RIVER
10582 GOTO 10420

'==== TELA 2
'X%=232:
10600 TL%=6 : IF A%=1 THEN X%=232 ELSE X%=8
10604 RETURN 

'==== TELA 3
10605 TL%=7 
10608 RETURN 



'******************************************************************************************
'=== ESQUERDA
10700 A%=TL%-4:X%=232:HP%=0
 10703 ON A% GOSUB 10600,10605, 0 
10704 GOTO 10420
'******************************************************************************************
'******************************************************************************************
'=== DIREITA
 10712 A%=TL%-4:X%=8:HP%=0
 10714 ON A% GOSUB 10570,10600 
 10715 GOTO 10420
 '******************************************************************************************
'******************************************************************************************
'=== DESCE ESCADA
 10770 A%=TL%-4:TY%=5:Y%=((TY%*8)-16)-1
  10773 GOTO 10420
'******************************************************************************************
'=== SOBE ESCADA
10781 A%=TL%-4:TY%=22:Y%=((TY%*8)-16)-1
10784 GOTO 10420





@echo off
setlocal enabledelayedexpansion
set dt=C:\Users\%username%\desktop\ficha.txt
set commands=ajuda sair nome hp pp move
title Ficha Pokemon
color 02
cls
:: Se ja tem ficha
IF EXIST %dt% (
	set found=0
	set var=0
	FOR /F "delims=" %%I IN (%dt%) DO (
		IF "!found!"=="1" (
			set var=%%I
			IF "!var!"=="ECHO is off." set "var= "
			IF "!pkmn!"=="" (
				set pkmn=!var!
			) ELSE IF "!hp!"=="" (
				set "hp=!var!"
			) ELSE IF "!pp!"=="" (
				set "pp=!var!"
			) ELSE IF "!m1!"=="" (
				set m1=!var!
			) ELSE IF "!m2!"=="" (
				set m2=!var!
			) ELSE IF "!m3!"=="" (
				set m3=!var!
			) ELSE (
				set m4=!var!
			)
		)
		IF "%%I"=="variaveis" set "found=1"
	)
	goto loop
) ELSE (
	:: Variaveis
	echo ---[ Tracos ]---
	set /p pkmn=Qual o seu pokemon? 
	set /p hp=Qual o HP? 
	set /p pp= Qual o PP? 
	echo.
	echo ---[ Moves ]---
	set /p m1=Move 1: 
	set /p m2=Move 2: 
	set /p m3=Move 3: 
	set /p m4=Move 4: 
	echo ---------------
)

:loop
cls
@echo ---[ Tracos ]---> %dt%
@echo Nome: %pkmn% >> %dt%
@echo HP: "%hp%">> %dt%
@echo PP: "%pp%">> %dt%
@echo ---[ Moves ]--->> %dt%
@echo Move 1: %m1%>> %dt%
@echo Move 2: %m2%>> %dt%
@echo Move 3: %m3%>> %dt%
@echo Move 4: %m4%>> %dt%
@echo --------------->> %dt%
@echo digite "ajuda" para a lista de comandos>> %dt%
@echo variaveis>> %dt%
@echo %pkmn%>> %dt%
@echo "%hp:"=%">> %dt%
@echo "%pp:"=%">> %dt%
@echo %m1%>> %dt%
@echo %m2%>> %dt%
@echo %m3%>> %dt%
@echo %m4%>> %dt%

set found=variaveis
FOR /F "delims=" %%A IN (%dt%) DO (
    	IF "%%A" neq "!found!" (
		echo %%A
	) ELSE (
		goto prompt
	)
)

:prompt
set up=-
set /p up="~> "
set command=%up:.=&:%
set n=%up:*.=%

FOR %%I IN (%commands%) DO (
	IF /I "%%I"=="%command%" (
		goto %command%
	)
)
goto loop

:ajuda
cls
@echo ----[ Ajuda ]----
@echo ajuda: mostra esse texto
@echo.
@echo sair: sair da ficha, mas seus dados estao salvos
@echo.
@echo nome.N: altera o nome do pokemon em que N e o nome do pokemon.
@echo [Exemplo]: nm.Pikachu retorna Nome: Pikachu
@echo.
@echo hp.N: altera o HP em que N e um numero a calcular.
@echo [Exemplo]: hp.-1 retorna PP: 9/10
@echo.
@echo pp.N: altera o PP em que N e um numero a calcular.
@echo [Exemplo]: hp.-1 retorna HP: 9/10
@echo.
@echo move.N: altera o move em que N e o nome do move.
@echo [Exemplo 1]: move.Thunderbolt muda o move no slot da sua escolha
@echo [Exemplo 2]: move sem caractere de "." faz o pokemons esquecer sem bugs 
@echo.
@echo ---------------
pause
goto loop

:sair
cls
choice /M "Voce tem certeza de que quer sair?"
IF %errorlevel% == 1 exit
goto loop

:nome
set pkmn=%n%
goto loop

:hp
set /a hp=%hp:"=%+%n%
goto loop

:pp
set /a pp=%pp:"=%+%n%
goto loop

:move
cls
choice /c 1234 /M "Qual slot deseja alterar?"
IF "%n%"=="move" set "n= "
set m%errorlevel%=%n%
goto loop
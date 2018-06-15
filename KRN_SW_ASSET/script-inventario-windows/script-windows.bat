@echo off
set USUARIO=root
set SENHA=xman

if not exist "lista" (
  mkdir "lista"
  if "!errorlevel!" EQU "0" (
    echo Diretorio lista criado com Sucesso!
  ) else (
    echo Erro ao criar o diretorio lista, que ira salvar as informacoes
  )
) else (
  echo Diretorio ja existente, OK

)

for /F %%i in (servidores.txt) do ( 
echo Coletando as informacoes para o node: %%i
if exist lista\%%i.txt (
	echo Arquivo de saida ja existe, zerando ...
	del lista\%%i.txt
)
echo Hostname %%i >> lista\%%i.txt
wmic /node:%%i /user:%USUARIO% /password:%SENHA% computersystem get name >> lista\%%i.txt 
wmic /node:%%i /user:%USUARIO% /password:%SENHA% OS get Name >> lista\%%i.txt
wmic /node:%%i /user:%USUARIO% /password:%SENHA% CPU get name, caption,  maxclockspeed, systemname  /format:textvaluelist.xsl >> lista\%%i.txt
wmic /node:%%i /user:%USUARIO% /password:%SENHA% OS get TotalVisibleMemorySize /Value >> lista\%%i.txt
wmic /node:%%i /user:%USUARIO% /password:%SENHA% PRODUCT get name,version /format:csv >> lista\%%i.txt
cscript //U software-instalados-outro-lugar-do-registro.vbs %%i >> lista\%%i.txt
)
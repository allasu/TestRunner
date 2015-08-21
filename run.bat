@ECHO OFF
::===============================
SET GITHUB_ACCOUNT=allasu
SET WS_DIR=Workspace
SET REPO_NAME=Title_Validation_CSV
SET APP_VERSION=1.1
SET MAIN_CLASS=core.Validation_CVS
SET ARGS_01=
::================================
IF "%JAVA_HOME%" == "" GOTO EXIT_JAVA
ECHO Java installed
IF "%M2%" == "" GOTO EXIT_MVN
ECHO Maven installed
CALL git --version > nul 2>&1
IF NOT %ERRORLEVEL% == 0 GOTO EXIT_GIT
ECHO Git installed

GOTO NEXT

:NEXT
IF NOT EXIST C:\%WS_DIR% GOTO NO_WORKSPACE
IF EXIST C:\%WS_DIR%\%REPO_NAME% RD /S /Q C:\%WS_DIR%\%REPO_NAME%
ECHO Subdirectory %REPO_NAME% is removed
CD C:\%WS_DIR%
git clone https://github.com/%GITHUB_ACCOUNT%/%REPO_NAME%.git
SLEEP 2
CD %REPO_NAME%
SLEEP 2
CALL mvn package -Dbuild.version=%APP_VERSION%
ECHO.
SLEEP 2
CALL chdir
ECHO Executing Java program ... 
java -cp .\target\%REPO_NAME%-%APP_VERSION%-jar-with-dependencies.jar %MAIN_CLASS% %ARGS_01%
GOTO END

:EXIT_JAVA
ECHO No Java installed
GOTO END
:EXIT_MVN
ECHO No Maven installed
GOTO END
:EXIT_GIT
ECHO No Git installed
GOTO END
:NO_WORKSPACE
ECHO %WS_DIR% does not exist
GOTO END
:END
CD\
#!bin/sh
#===============================
GITHUB_ACCOUNT=allasu
WS_DIR=Workspace
REPO_NAME=Title_Validation_PF
APP_VERSION=1.1
MAIN_CLASS=core.Validation_Properties
ARGS_01=
#================================

if ! which java > /dev/null 2>&1; then echo Java not installed; return; fi
if ! which mvn > /dev/null 2>&1; then echo Maven not installed; return; fi
if ! which git > /dev/null 2>&1; then echo Git not installed; return; fi

if [ -d "$HOME/$WS_DIR" ]; then cd ~/$WS_DIR; else echo $WS_DIR directory does not exist; return; fi

if [ -d "$HOME/$WS_DIR/$REPO_NAME" ]; then rm -rf $HOME/$WS_DIR/$REPO_NAME; fi

git clone https://github.com/$GITHUB_ACCOUNT/$REPO_NAME.git

cd ./$REPO_NAME

mvn package -Dbuild.version $APP_VERSION
echo Executing Java program ...

java -cp $HOME/$WS_DIR/$REPO_NAME/target/$REPO_NAME-$APP_VERSION-jar-with-dependencies.jar $MAIN_CLASS $ARGS_01

gi
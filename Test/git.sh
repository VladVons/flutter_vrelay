#!/bin/bash
# Created: 28.09.2016
# Vladimir Vons, VladVons@gmail.com

User="VladVons"
Name="flutter_vrelay"
Mail="vladvons@gmail.com"
#
Branch="master"
#Branch="v3"
#
Url="https://github.com/$User/$Name.git"


Log()
{
  aMsg="$1";

  Msg="$(date +%Y-%m-%d-%a), $(date +%H:%M:%S), $(id -u -n), $aMsg"
  echo "$Msg"
}


Clean()
{
  echo "delete objects"
  #find ./ \( -name "*.pyc" -o -name "*.log" -o -name "*.pyi" -o -name "*.db" \) -type f -delete
  #find ./ \( -name '*.so'  -o -name "*.exe" \) -type f -delete
  #find . -name '*.log' -exec rm -v -f -R {} \;
  #find . -name '*.log' -exec rm -v -f -R {} \;
  #find . -name '__pycache__' -exec rm -v -f -R {} \;

  echo
  echo "Statistics *.dart"
  #find . -name '*.py' -ls | awk '{total += $7} END {print total}'
  find ./lib -name '*.dart' | xargs wc | cat -n
  #find . -name '*.py' | wc -l

  #echo
  #du -s -b py-relay/src/* | sort -n -r
  #find py-relay/src/ -ls -type f | awk '{sum += $7} END {print sum}'

  #echo
  #echo "Files *.py"

  #echo
  #echo "Statistics *.json"
  #find . -name '*.json' | xargs wc
}


GitAuth()
{
  Log "$0->$FUNCNAME"

  echo "enter pasword for SUDO user"
  sudo chown -R $USER .

  # sign with eMail
  git config --global user.email $Mail
  git config --global user.name $User

  # no password 
  git config --global credential.helper 'cache --timeout=36000'
}


GitCreate()
{
  Log "$0->$FUNCNAME"

  # create new project on disk
  git init
  GitAuth

  # remote git server location
  git remote add origin $Url

}


GitClone()
{
  Log "$0->$FUNCNAME"

  # restore clone copy fromserver to disk 
  git clone --single-branch -b $Branch $Url
  GitAuth

  #web admin access here
  #https://github.com/VladVons/appman
}


GitFromServMissed()
{
  git fetch --all
  git reset --hard origin/$Branch
  #
  git ls-files -d | xargs git checkout --
}


GitSyncToServ()
# sync only changes from disk to server 
{
  aComment="$1";
  Log "$0->$FUNCNAME"

  git status

  #git add install.sh
  #git rm TestClient.py
  #git mv README.md README
  #git log

  git add -u -v
  git commit -a -m "$aComment"
  git push -u origin $Branch
}


GitFromServ()
# sync changes from server to disk
{
  Log "$0->$FUNCNAME"

  git pull origin $Branch
}


GitToServ()
# sync changes from disk to serv
{
  aComment=${1:-"MyCommit"};
  Log "$0->$FUNCNAME"

  Clean
  # add all new files
  git add -A -v
  GitSyncToServ "$aComment"
}


GitNewBranch()
# sync changes from disk to serv
{
  Log "$0->$FUNCNAME"

  git checkout -b $Branch
  #GitSyncToServ
}


GitReset()
{
  Log "$0->$FUNCNAME"
  
  git checkout --orphan TEMP_BRANCH
  git add -A
  git commit -am "Initial commit"
  git branch -D $Branch
  git branch -m $Branch
  git push -f origin $Branch
}


Diff()
{
  diff -r dir1 dir2 | sed '/Binary\ files\ /d' > diff.txt
}


Help()
{
  echo "Unknown option"
}


#GitUpdate

clear
case $1 in
    Clean)               "$1"        "$2" "$3" ;;
    GitAuth)             "$1"        "$2" "$3" ;;
    GitCreate)           "$1"        "$2" "$3" ;;
    GitToServ|t)         GitToServ   "$2" "$3" ;;
    GitFromServ|f)       GitFromServ "$2" "$3" ;;
    GitFromServMissed|m) GitFromServMissed "$2" "$3" ;;
    GitNewBranch)        "$1"        "$2" "$3" ;;
    GitClone)            "$1"        "$2" "$3" ;;
    *)                   Help ;;
esac

#!/bin/bash

color() {
     echo "$@" | sed \
             -e "s/\(\(@\(red\|green\|yellow\|blue\|magenta\|cyan\|white\|reset\|b\|u\)\)\+\)[[]\{2\}\(.*\)[]]\{2\}/\1\4@reset/g" \
             -e "s/@red/$(tput setaf 1)/g" \
             -e "s/@green/$(tput setaf 2)/g" \
             -e "s/@yellow/$(tput setaf 3)/g" \
             -e "s/@blue/$(tput setaf 4)/g" \
             -e "s/@magenta/$(tput setaf 5)/g" \
             -e "s/@cyan/$(tput setaf 6)/g" \
             -e "s/@white/$(tput setaf 7)/g" \
             -e "s/@reset/$(tput sgr0)/g" \
             -e "s/@b/$(tput bold)/g" \
             -e "s/@u/$(tput sgr 0 1)/g"
  }
  
color @b@blue

echo " █████╗ ██████╗ ███████╗██╗  ██╗"
echo "██╔══██╗██╔══██╗██╔════╝╚██╗██╔╝"
echo "███████║██████╔╝█████╗   ╚███╔╝ "
echo "██╔══██║██╔═══╝ ██╔══╝   ██╔██╗ "
echo "██║  ██║██║     ███████╗██╔╝ ██╗"
echo "╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝"
echo "-------------------------------------------------"
echo " Online-Trending WebApp - SEN Project - Group 2 "
echo "--------------------------------------------------"



function ask_user() {    



color @b@cyan

echo -e "
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
| 0.) Pip install                           |
| 1.) Runserver                             |
| 2.) Migrate                               |
| 3.) Makemigrations                        |
| 4.) Load-Data JSON for Crawler Services   |
| 5.) Crawl Services                        | 
| 6.) Git Fetch and PULL origin             |
| 7.) Git status                            |
| 8.) Git Add and Push Origin               |
| 9.) Git Username - Password               | 
| 10.) Git stash                            |
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#\n"

read -e -p "Select 1: " choice

if [ "$choice" == "0" ]; then

pip install -r requirements.txt


elif [ "$choice" == "1" ]; then

python manage.py runserver

elif [ "$choice" == "2" ]; then

python manage.py migrate

elif [ "$choice" == "3" ]; then

python manage.py makemigration

elif [ "$choice" == "4" ]; then

python manage.py loaddata services.json

elif [ "$choice" == "5" ]; then

function ask_for_services() {

color @b@yellow

echo -e "
#-----------------------------------#
| 1.) Reddit                        |
| 2.) Nytimes                       |
| 3.) Github                        |
| 4.) Exit                          |
|-----------------------------------#\n"

read -e -p "Select 1: " choice

if [ "$choice" == "1" ]; then 

python manage.py crawl reddit

elif [ "$choice" == "2" ]; then

python manage.py crawl nytimes

elif [ "$choice" == "3" ]; then

python manage.py crawl github

elif [ "$choice" == "4" ]; then

    clear && exit 0

else 
	clear &&  ask_for_services
fi
}
ask_for_services




elif [ "$choice" == "6" ]; then

if git checkout master &&
    git fetch origin master &&
    [ `git rev-list HEAD...origin/master --count` != 0 ] &&
    git merge origin/master
then
    echo 'Updated!'
else
    echo 'Not updated.'
fi



elif [ "$choice" == "7" ]; then

git status


elif [ "$choice" == "8" ]; then

read -p "Commit description: " desc
git add . && \
git add -u && \
git commit -m "$desc" && \
git push origin master


elif [  "$choice" == "9" ]; then

 
read -p "User Name:" usr
read -p "Password:" pass
git config --global user.name  "$usr"
git config --global user.email "$pass"

elif [ "$choice" == "10" ]; then 

git stash

elif [ "$choice" == "11" ]; then

    clear && exit 0


else

    echo "Please select 1, 2, or 3." && sleep 3
    clear && ask_user

fi
}

ask_user


#!/bin/bash

createCommand() {
    rm $2 2> /dev/null
    echo "#!/bin/bash" >> $2
    echo "docker run -i --rm -v \$(pwd):\$(pwd) -w \$(pwd) jeremyjumeau/phpcli $1 \$@" >> $2
    chmod +x $2
}

commands=(php composer coke phpcs php-cs-fixer phpmd phpunit phploc)

for command in "${commands[@]}"
do
    file="/usr/local/bin/$command"
    if [ -f $file ]; then
        echo -e "\e[0;37m$file \e[0;33malready exists\e[0m"
        read -p $'\e[34mWould you like to replace it? (y/n) \e[0m' -e -i "y" replace
        if  [ $replace != 'y' ]; then
        	continue
        fi
    fi
    createCommand $command $file
    $command --version
done

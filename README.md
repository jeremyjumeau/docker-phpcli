# Overview
This docker image aims to containerize PHP CLI with useful devtools such as:

- [composer](https://getcomposer.org/) *v1.5.1*
- [php-cs-fixer](https://github.com/FriendsOfPHP/PHP-CS-Fixer) *v2.5.0*
- [phpmd](https://github.com/phpmd/phpmd) *v2.6.0*
- [phpunit](https://github.com/sebastianbergmann/phpunit) *v6.3.0*
- [phploc](https://github.com/sebastianbergmann/phploc) *v4.0.0*
- [phpcs](https://github.com/squizlabs/PHP_CodeSniffer) ~~*v3.0.2*~~ *v2.9.1*
- [coke](https://github.com/M6Web/Coke) *v2.2.0*
- [Symfony coding standard](https://github.com/M6Web/Symfony2-coding-standard) *v3.3.0*

# Usage
## As a one shot command
#### php example

- Show PHP's version :
```bash
docker run -it --rm jeremyjumeau/phpcli --version
```

- Run a single PHP script :
```bash
docker run --rm -v $(pwd):$(pwd) -w $(pwd) jeremyjumeau/phpcli php your-script.php
```

:warning: *Notice that the local working directory (where your launch this command) is mounted on the container as the working directory*

#### php-cs-fixer example
- Describe @Symfony coding styles rules
```bash
docker run --rm jeremyjumeau/phpcli php-cs-fixer describe @Symfony
```
- Fix a php file's coding style to fit Symfony coding standard
```bash
# get the example file
wget https://raw.githubusercontent.com/jeremyjumeau/docker-phpcli/master/example-script.php
docker run --rm -v $(pwd):$(pwd) -w $(pwd) jeremyjumeau/phpcli php-cs-fixer fix example-script.php --rules=@Symfony --path-mode=override --using-cache=no --no-interaction
```

#### phpcs example
- Show PSR-2 (default) coding style violations
```bash
# get the example file
wget https://raw.githubusercontent.com/jeremyjumeau/docker-phpcli/master/example-script.php
docker run -i --rm -v $(pwd):$(pwd) -w $(pwd) docker-phpcli-with-devtools phpcs example-script.php
```

## As local *command(s)* on your machine/server
#### $ php
First, let's create the `php` script file in `/usr/local/bin`:
`sudo vi /usr/local/bin/php` (your can replace `vi` with your favourite editor)

Copy/paste the content below:
```bash
#!/bin/sh
docker run -i --rm -v $(pwd):$(pwd) -w $(pwd) jeremyjumeau/phpcli php $@
```
Then, give permissions to all users to execute this file:
`sudo chmod +x /usr/local/bin/php`

Finally, test the `php` command:
`php --version`

#### Install all available commands
```bash
wget https://raw.githubusercontent.com/jeremyjumeau/docker-phpcli/master/cli-setup.sh
chmod +x cli-setup.sh
./cli-setup.sh
```

This will install `php` commands and all commands listed in the *Overview* section.


## For [**Atom.io**](https://atom.io/) users

Now that you've set the shell commands above (have you?), just install those atom.io packages:

- [linter-php package](https://atom.io/packages/linter-php)
- [linter-phpmd package](https://atom.io/packages/linter-phpmd)
- [linter-phpcs](https://atom.io/packages/linter-phpcs)
- [php-cs-fixer package](https://atom.io/packages/php-cs-fixer)

##### Linter-php
Should work out of the box 👍!

##### Linter-phpmd
Should work out of the box 👍!

#### Linter-phpcs
Go to the **Settings** panel, then in the *Packages* section, search `phpcs` and click *Settings* to set set those values:
- Executable Path : `/usr/local/bin/phpcs`
- **Uncheck** "Search for executables"
- Code Standard Or Config File : `vendor/m6web/symfony2-coding-standard/Symfony2`
*Notice that you'll have to add the dev dependency to the package in your `composer.json` config: `composer require --dev m6web/symfony2-coding-standard`*
- **Uncheck** "Disable When No Config File"
- **Check** "Search for configuration files"

#### Atom-php-cs-fixer
Go to the **Settings** panel, then in the *Packages* section, search `php-cs-fixer` and click *Settings* to set set those values:
- Executable Path : `/usr/local/bin/php-cs-fixer`
- If you're a Symfony user, set the "PHP-CS-Fixer Rules" to `@Symfony`

## Need help?
Feel free to report any issue!

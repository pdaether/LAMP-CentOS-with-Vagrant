# LAMP Setup based on CentOS 6.3 with Vagrant / Puppet

## Overview

I put together this configuration to get up a full LAMP enviroment based on CentOS.
So you get a CentOS-VM with 

* Apache
* MySQL
* PHP
* phpMyAdmin
* ImageMagick

**Attention:** This is just a quick vagrant based VM for local development and testing.
Don't use this VM in a production enviroment.


## Installation

Befor yout start: 
I am using a 64 bit version of CentOS as base box. So make sure that you can virtualize a 64 bit system.

Clone this repo

```bash

git clone https://github.com/pdaether/LAMP-CentOS-with-Vagrant.git .

```

or just download the sourcecode as Zip file.

Start the VM:

```bash

vagrant up

```

## Usage

Now, you can reach the webroot with `http://localhost:8080`.
Also you can find a working installtion of PhpMyAdmin under `http://localhost:8080/phpMyAdmin/`.

The Mysql password for root is emtpy.

To login into the VM type
```bash
vagrant ssh
```

To halt the VM:
```bash
vagrant halt
```

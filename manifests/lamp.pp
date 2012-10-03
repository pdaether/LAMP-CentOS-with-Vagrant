# Puppet manifest for my PHP dev machine
 


class iptables {

  package { "iptables": 
    ensure => present;
  }

  service { "iptables":
    require => Package["iptables"],

    hasstatus => true,
    status => "true",

    # hasrestart => false,

  }

  file { "/etc/sysconfig/iptables":
    owner   => "root",
    group   => "root",
    mode    => 600,
    replace => true,
    ensure  => present,
    # source  => "puppet:///files/iptables.txt",
    source  => "/vagrant/files/iptables.txt",
    # content => template("puppet:///templates/iptables.txt"),
    require => Package["iptables"],

    notify  => Service["iptables"],
    ;
  }

}


class misc {

  exec { "grap-epel":
    command => "/bin/rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-7.noarch.rpm",
    creates => "/etc/yum.repos.d/epel.repo",
    alias   => "grab-epel",
  }

  package { "emacs":
    ensure => present
  }

  package { "ImageMagick":
    ensure => present
  }

}


class httpd {

  exec { 'yum-update':
    command => '/usr/bin/yum -y update'
  }

  package { "httpd":
    ensure => present
  }

  package { "httpd-devel":
    ensure  => present
  }

  service { 'httpd':
    name      => 'httpd',
    require   => Package["httpd"],
    ensure    => running,
    enable    => true
  }

  file { "/etc/httpd/conf.d/vhost.conf":
    owner   => "root",
    group   => "root",
    mode    => 644,
    replace => true,
    ensure  => present,
    source  => "/vagrant/files/vhost.conf",
    require => Package["httpd"],
    notify  => Service["httpd"]
  }

}

class phpdev {

  package { "libxml2-devel":
  ensure  => present,
  }


  package { "libXpm-devel":
  ensure  => present,
  }

  package { "gmp-devel":
  ensure  => present,
  }

  package { "libicu-devel":
  ensure  => present,
  }

  package { "t1lib-devel":
  ensure  => present,
  }

  package { "aspell-devel":
  ensure  => present,
  }

  package { "openssl-devel":
  ensure  => present,
  }

  package { "bzip2-devel":
  ensure  => present,
  }

  package { "libcurl-devel":
  ensure  => present,
  }

  package { "libjpeg-devel":
  ensure  => present,
  }

  package { "libvpx-devel":
  ensure  => present,
  }

  package { "libpng-devel":
  ensure  => present,
  }

  package { "freetype-devel":
  ensure  => present,
  }

  package { "readline-devel":
  ensure  => present,
  }

  package { "libtidy-devel":
  ensure  => present,
  }

  package { "libxslt-devel":
  ensure  => present,
  }
}

class mysql {

  package { "mysql-server":
    ensure  => present,
  }

  package { "mysql":
    ensure  => present,
  }

  service { "mysqld":
    ensure => running, 
    require => Package["mysql-server"]
  }

}

class php {

  package { "php":
    ensure  => present,
  }

  package { "php-cli":
    ensure  => present,
  }

  package { "php-common":
    ensure  => present,
  }

  package { "php-devel":
    ensure  => present,
  }

  package { "php-gd":
    ensure  => present,
  }

  package { "php-mcrypt":
    ensure  => present,
  }

  package { "php-intl":
    ensure  => present,
  }

  package { "php-ldap":
    ensure  => present,
  }

  package { "php-mbstring":
    ensure  => present,
  }

  package { "php-mysql":
    ensure  => present,
  }

  package { "php-pdo":
    ensure  => present,
  }

  package { "php-pear":
    ensure  => present,
  }

  package { "php-pecl-apc":
    ensure  => present,
  }

  package { "php-soap":
    ensure  => present,
  }

  package { "php-xml":
    ensure  => present,
  }

  package { "uuid-php":
    ensure  => present,
  }

  package { "php-pecl-imagick":
    ensure  => present,
    require => Exec["grab-epel"]
  }

}

class phpmyadmin {

  package { "phpMyAdmin":
    ensure  => present,
  }

  file { "/etc/httpd/conf.d/phpMyAdmin.conf":
    owner   => "root",
    group   => "root",
    mode    => 644,
    replace => true,
    ensure  => present,
    source  => "/vagrant/files/phpMyAdmin.conf",
    require => Package["httpd"],

    notify  => Service["httpd"],
    ;
  }

  file { "/etc/phpMyAdmin/config.inc.php":
    owner   => "root",
    group   => "root",
    mode    => 644,
    replace => true,
    ensure  => present,
    source  => "/vagrant/files/phpmy_admin_config.inc.php",
    require => Package["phpMyAdmin"]
  }



}



class rpmforge {
  exec {
    "/usr/bin/wget http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm":
    alias   => "grab-rpmforge",
  }

  exec {
    "/bin/rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt":
    alias   => "import-key",
    require => Exec["grab-rpmforge"],
  }

  exec {
    "/bin/rpm -i rpmforge-release-0.5.2-2.el6.rf.*.rpm":
    alias   => "install-rpmforge",
    require => Exec["import-key"],
  }

  package { "libmcrypt-devel":
  ensure  => present,
    require => Exec["install-rpmforge"]
  }
}


include iptables
#include rpmforge
include misc
include httpd
include phpdev
include mysql
include php
include phpmyadmin
# == Class: sensu_web
#
# Class to manage the Sensu Go Web.
#
# @example
#   include sensu_web
#
# @param revision
#   Git revision of Sensu Go Web to download with git
#   This can be a git tag, branch of commit SHA
# @param source
#   Sensu Go Web git repo source URL
# @param install_dir
#   Path of where to install Sensu web
# @param port
#   Port to use for Sensu Web
#   Default is 3000
#   Changing the value below 1024 requires setting service_user=root and service_group=root
# @param service_user
#   The user to run sensu-web service as
#   Defaults to root
# @param service_group
#   The group to run sensu-web service as
#   Defaults to root
#
class sensu_web (
  Optional[String] $revision        = 'v1.0.1',
  Stdlib::HTTPSUrl $source          = 'https://github.com/sensu/web.git',
  Stdlib::Absolutepath $install_dir = '/opt/sensu-web',
  Stdlib::Port $port                = 3000,
  Optional[String] $service_user    = root,
  Optional[String] $service_group   = root,
) {

  if $facts['service_provider'] != 'systemd' {
    fail('Class sensu_web is only supported on systems that support systemd')
  }

  include sensu
  include git
  include yarn

  class { 'nodejs':
    repo_url_suffix       => '10.x',
    nodejs_package_ensure => '10.23.0-1nodesource',
  }

  Package['nodejs'] -> Package['yarn']

  $api_url = $sensu::api_url

  file { 'sensu-web-dir':
    ensure => 'directory',
    path   => $install_dir,
    owner  => $service_user,
    group  => $service_group,
    mode   => '0755',
    before => Vcsrepo['sensu-web'],
  }

  vcsrepo { 'sensu-web':
    ensure   => 'latest',
    path     => $install_dir,
    provider => 'git',
    revision => $revision,
    source   => $source,
    user     => $service_user,
    notify   => Exec['sensu-web-touch-install'],
  }

  exec { 'sensu-web-touch-install':
    path        => '/usr/bin:/bin',
    command     => "touch ${install_dir}/.install",
    refreshonly => true,
    user        => $service_user,
    before      => Exec['sensu-web-install'],
  }
  exec { 'sensu-web-install':
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    command => "yarn install && rm -f ${install_dir}/.install",
    cwd     => $install_dir,
    onlyif  => "test -f ${install_dir}/.install",
    timeout => 0,
    user    => $service_user,
    require => Package['yarn'],
  }

  systemd::unit_file { 'sensu-web.service':
    content => epp("${module_name}/sensu-web.service.epp"),
    notify  => Service['sensu-web'],
  }

  if versioncmp($facts['puppetversion'],'6.1.0') < 0 {
    # Puppet 5 does not execute 'systemctl daemon-reload' automatically (https://tickets.puppetlabs.com/browse/PUP-3483)
    # and camptocamp/systemd only creates this relationship when managing the service
    Class['systemd::systemctl::daemon_reload'] -> Service['sensu-web']
  }

  service { 'sensu-web':
    ensure    => 'running',
    enable    => true,
    subscribe => Exec['sensu-web-install'],
  }

}

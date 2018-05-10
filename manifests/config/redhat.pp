#
# == Class: updater::config::redhat
#
# RedHat-specific updater (yum-cron) configuration
#
class updater::config::redhat
(
    Enum['yes','no'] $install

) inherits updater::params
{
    if $install == 'yes' {
        $check_only = 'no'
        $download_only = 'no'
    } else {
        $check_only = 'no'
        $download_only = 'yes'
    }

    file { 'updater-config':
        ensure  => present,
        name    => '/etc/sysconfig/yum-cron',
        owner   => $::os::params::adminuser,
        group   => $::os::params::admingroup,
        mode    => '0644',
        content => template('updater/yum-cron.erb'),
        require => Class['updater::install'],
    }
}

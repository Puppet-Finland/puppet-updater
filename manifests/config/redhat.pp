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
        $apply_updates = 'yes'
    } else {
        $apply_updates = 'no'
    }

    file { 'updater-config':
        ensure  => present,
        name    => '/etc/yum/yum-cron.conf',
        owner   => $::os::params::adminuser,
        group   => $::os::params::admingroup,
        mode    => '0644',
        content => template('updater/yum-cron.conf.erb'),
        require => Class['updater::install'],
    }
}

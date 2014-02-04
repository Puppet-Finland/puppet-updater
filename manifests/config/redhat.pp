#
# == Class: updater::config::redhat
#
# RedHat-specific updater (yum-cron) configuration
#
class updater::config::redhat
(
    $install
)

    if $install == 'yes' {
        $check_only = 'no'
        $download_only = 'no'
    } else {
        $check_only = 'no'
        $download_only = 'yes'        
    }

    file { 'updater-config':
        ensure => present,
        name => '/etc/sysconfig/yum-cron',
        owner => root,
        group => root,
        mode  => 644,
        content => template('updater/yum-cron.erb'),
        require => Class['updater::install'],
    }
}

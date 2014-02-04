#
# == Class: updater::config::debian
#
# Debian-specific updater (cron-apt) configuration
#
class updater::config::debian
(
    $install
)
{
    file { 'updater-5-dist-upgrade':
        ensure => $install ? {
            'yes' => 'present',
            'no' => 'absent',
            default => 'absent',
        },
        name => '/etc/cron-apt/action.d/5-dist-upgrade',
        owner => root,
        group => root,
        mode  => 644,
        content => template('updater/5-dist-upgrade.erb'),
        require => Class['updater::install'],
    }

    file { 'updater-config':
        ensure => present,
        name => '/etc/cron-apt/config',
        owner => root,
        group => root,
        mode  => 644,
        content => template('updater/config.erb'),
        require => Class['updater::install'],
    }

}


#
# @summary Debian-specific updater (cron-apt) configuration
#
class updater::config::debian
(
    Enum['yes','no']           $install,
    Enum['','error','upgrade'] $mailon

) inherits updater::params
{

    $ensure_dist_upgrade = $install ? {
            'yes'   => 'present',
            'no'    => 'absent',
            default => 'absent',
        }

    file { 'updater-5-dist-upgrade':
        ensure  => $ensure_dist_upgrade,
        name    => '/etc/cron-apt/action.d/5-dist-upgrade',
        owner   => $::os::params::adminuser,
        group   => $::os::params::admingroup,
        mode    => '0644',
        content => template('updater/5-dist-upgrade.erb'),
        require => Class['updater::install'],
    }

    file { 'updater-config':
        ensure  => present,
        name    => '/etc/cron-apt/config',
        owner   => $::os::params::adminuser,
        group   => $::os::params::admingroup,
        mode    => '0644',
        content => template('updater/config.erb'),
        require => Class['updater::install'],
    }

}


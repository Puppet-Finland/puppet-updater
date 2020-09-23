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
        name    => $::updater::params::config_name,
        owner   => $::os::params::adminuser,
        group   => $::os::params::admingroup,
        mode    => '0644',
        content => template($::updater::params::template_name),
        require => Class['updater::install'],
    }

    if $::updater::params::has_service {
        service { 'dnf-automatic':
            ensure    => 'running',
            enable    => true,
            subscribe => File['updater-config'],
        }
    }
}

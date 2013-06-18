#
# == Class: updater::config
#
# Configure automated updates
#
class updater::config(
    $email
)
{
    include updater::params

    file { 'updater-config':
        ensure => present,
        name => $updater::params::updater_config,
        owner => root,
        group => root,
        mode  => 644,
        content => template("updater/${::osfamily}.erb"),
        require => Class['updater::install'],
    }
}

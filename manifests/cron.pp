#
# @summary
#   Add automated updates to cron. This class is currently only used on
#   Debian-based operating systems that use cron-apt; RedHat operating systems
#   set up cron entries automatically or use a system service for launching
#   upgrades.
#
class updater::cron
(
    Variant[Integer,String] $hour,
    Variant[Integer,String] $minute,
    Variant[Integer,String] $weekday

) inherits updater::params
{
    # cron-apt bundles a cron.d fragment, which need to get rid off
    file { 'updater-cron-apt':
        ensure => absent,
        name   => '/etc/cron.d/cron-apt',
    }

    cron { 'updater-cron':
        ensure  => present,
        command => $::updater::params::updater_cron_command,
        user    => root,
        hour    => $hour,
        minute  => $minute,
        weekday => $weekday,
    }

}

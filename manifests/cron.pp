#
# == Class: updater::cron
#
# Add automated updates to cron. This class is currently only used on 
# Debian-based operating systems that use cron-apt; RedHat's yum-cron package 
# sets up cron.daily entries automatically without giving any configuration 
# options.
#
class updater::cron
(
    $hour,
    $minute,
    $weekday
)
{
    include updater::params

    cron { 'updater-cron':
        command => $::updater::params::updater_cron_command,
        user => root,
        hour => $hour,
        minute => $minute,
        weekday => $weekday,
    }

}

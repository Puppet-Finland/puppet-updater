#
# == Class: updater
#
# Configure automatic updates. Currently only downloads updates but does not 
# install them.
#
# == Parameters
#
# [*email*]
#   Address for notification emails. Defaults to $::serveradmin.
# [*hour*]
#   Hour(s) when the agent gets run. Defaults to 3 (all hours). Only affects 
#   Debian-based operating systems and cron-apt.
# [*minute*]
#   Minute(s) when the agent gets run. Defaults to 15. Only affects Debian-based 
#   operating systems and cron-apt.
# [*weekday*]
#   Weekday(s) when the agent gets run. Defaults to * (all weekdays). Only 
#   affects Debian-based operating systems and cron-apt.
#
# == Examples
#
# class { 'updater':
#   email => 'monitor@domain.com',
# }
#
# == Authors
#
# Samuli Seppänen <samuli@openvpn.net>
#
# == License
#
# BSD-lisence
# See file LICENSE for details
#
class updater
(
    $email = $::serveradmin,
    $hour = '3',
    $minute = '15',
    $weekday = '*'
)
{

    include updater::install

    class { 'updater::config':
        email => $email,
    }

    # cron-apt (Debian) requires setting up a cron entry
    # yum-cron (RedHat) packages setup cron-daily entries automatically
    if $::osfamily == 'Debian' {
        class { 'updater::cron':
            hour => $hour,
            minute => $minute,
            weekday => $weekday,
        }
    }

}

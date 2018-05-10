#
# == Class: updater
#
# Configure automatic updates. Currently only downloads updates but does not 
# install them.
#
# == Parameters
#
# [*manage*]
#   Whether to manage automatic updates with Puppet or not. Valid values are 
#   true (default) and false.
# [*install*]
#   Install updates automatically. Valid values 'yes' and 'no'. Defaults to 
#   'no'.
# [*email*]
#   Address for notification emails. Defaults to $::servermonitor.
# [*mailon*]
#   When cron-apt sends mail. Valid values '' (never), 'error', 'upgrade',
#   'changes', 'output' and 'always'. Defaults to 'upgrade'. More details in 
#   config.erb.
# [*hour*]
#   Hour(s) when the agent gets run. Defaults to 3. Only affects Debian-based 
#   operating systems and cron-apt.
# [*minute*]
#   Minute(s) when the agent gets run. Defaults to 15. Only affects Debian-based 
#   operating systems and cron-apt.
# [*weekday*]
#   Weekday(s) when the agent gets run. Defaults to * (all weekdays). Only 
#   affects Debian-based operating systems and cron-apt.
#
class updater
(
    Boolean $manage = true,
            $install = 'no',
            $email = $::servermonitor,
            $mailon = 'upgrade',
            $hour = 3,
            $minute = 15,
            $weekday = '*'
)
{

if $manage {

    include ::updater::install

    class { '::updater::config':
        install => $install,
        email   => $email,
        mailon  => $mailon,
    }

    # cron-apt (Debian) requires setting up a cron entry
    # yum-cron (RedHat) packages setup cron-daily entries automatically
    if $::osfamily == 'Debian' {
        class { '::updater::cron':
            hour    => $hour,
            minute  => $minute,
            weekday => $weekday,
        }
    }
}
}

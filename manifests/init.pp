#
# @summary
#   Configure automatic updates using the default/common tools for the
#   operating system.
#
# @param manage
#   Whether to manage automatic updates with Puppet or not.
# @param install
#   Install updates automatically
# @param upgrade_type
#   Type of upgrade to do. For best compatibility only 'default' (all upgrades)
#   and 'security' are supported. Only applicable on RHEL/CentOS/Fedora.
# @param email
#   Address for notification emails.
# @param mailon
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
    Boolean                      $manage = true,
    Enum['yes', 'no']            $install = 'no',
    Enum['default', 'security']  $upgrade_type = 'default',
    String                       $email = $::servermonitor,
    Enum['', 'error', 'upgrade'] $mailon = 'upgrade',
    Variant[Array[String], Array[Integer[0-23]], String, Integer[0-23]] $hour = 3,
    Variant[Array[String], Array[Integer[0-23]], String, Integer[0-23]] $minute = 15,
    Variant[Array[String], Array[Integer[0-23]], String, Integer[0-23]] $weekday = '*'
)
{

if $manage {

    include ::updater::install

    class { '::updater::config':
        install      => $install,
        upgrade_type => $upgrade_type,
        email        => $email,
        mailon       => $mailon,
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

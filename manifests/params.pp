#
# == Class: updater::params
#
# Defines some variables based on the operating system
#
class updater::params {

    case $::osfamily {
        'RedHat': {
            $updater_package = 'yum-cron'
            $updater_config = '/etc/sysconfig/yum-cron'
        }
        'Debian': {
            $updater_package = 'cron-apt'
            $updater_config = '/etc/cron-apt/config'
            $updater_cron_command = '/usr/sbin/cron-apt'
        }
        default: {
            $updater_package = 'cron-apt'
            $updater_config = '/etc/cron-apt/config'
            $updater_cron_command = '/usr/sbin/cron-apt'
        }
    }
}

#
# == Class: updater::params
#
# Defines some variables based on the operating system
#
class updater::params {

    include ::os::params

    case $::osfamily {
        'RedHat': {
            case $facts['os']['release']['major'] {
                /(6|7)/: {
                    $updater_package = 'yum-cron'
                    $config_name = '/etc/yum/yum-cron.conf'
                    $template_name = 'updater/yum-cron.conf.erb'
                    $has_service = false
                }
                default: {
                    $updater_package = 'dnf-automatic'
                    $config_name = '/etc/dnf/automatic.conf'
                    $template_name = 'updater/automatic.conf.erb'
                    $has_service = true
                }
            }
        }
        'Debian': {
            $updater_package = 'cron-apt'
            $updater_cron_command = '/usr/sbin/cron-apt'
        }
        default: {
            fail("Unsupported operating system ${::osfamily}!")
        }
    }
}

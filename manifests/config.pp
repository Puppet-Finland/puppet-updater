#
# == Class: updater::config
#
# Configure automated updates
#
class updater::config
(
    Enum['yes','no']           $install,
    String                     $email,
    Enum['','error','upgrade'] $mailon

) inherits updater::params
{
    # The logic required for RedHat and Debian is quite different and therefore 
    # handled in separate classes.
    if $::osfamily == 'RedHat' {
        class { '::updater::config::redhat':
            install => $install,
        }
    } elsif $::osfamily == 'Debian' {
        class { '::updater::config::debian':
            install => $install,
            mailon  => $mailon,
        }
    }
}

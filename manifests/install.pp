#
# @summary Install the package required for automated updates
#
class updater::install inherits updater::params {

    package { 'updater':
        ensure => present,
        name   => $::updater::params::updater_package,
  }
}

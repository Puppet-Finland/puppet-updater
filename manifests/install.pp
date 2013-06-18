#
# == Class: updater::install
#
# Install the package required for automated updates
#
class updater::install {

    include updater::params

    package { 'updater':
        ensure => present,
        name => $::updater::params::updater_package,
	}
}

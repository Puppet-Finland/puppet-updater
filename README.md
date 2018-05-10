# updater

A Puppet module for managing automated updates

# Module usage

Download but do not install updates:

  include ::updater

or

  class { '::updater':
    install => 'no',
  }

Automatically download and install updates:

  class { '::updater':
    install => 'yes',
  }

The "mailon" parameter determines when to send notification emails: '' means 
never, 'error' means only on errors and 'upgrade' means on every upgrade.

On Debian the update cronjob can be customized like this:

  class { '::updater':
    hour    => 4,
    minute  => 35,
    weekday => '*',
  }

For more information see [init.pp](manifests/init.pp) and 
[cron.pp](manifests/cron.pp).

# sensu_web

#### Table of Contents

1. [Description](#description)
1. [Before you start](#Before-you-start)
1. [Usage](#usage)
1. [Reference](#reference)
1. [Limitations](#limitations)
1. [Development](#development)
1. [Release Notes and Contributors](#Release-Notes-and-Contributors)

## Description

Starting from version 6.0 of Sensu GO, the Web UI has been taken out from the community version and it's now a different application. This module sets up Sensu GO Web UI on Sensu 6.0 and higher.  
The manifest was taken from the [official sensu module](https://github.com/sensu/sensu-puppet) and since it was removed from there, it is now being offered as a separate module.  
It works only in conjunction with the [official sensu module](https://github.com/sensu/sensu-puppet) and it requires a modern system, runing systemd.  
This is what the module does when the version number is changed:

1. pulls the application from the repositoy [Sensu Web](https://github.com/sensu/web.git)
2. installs the application using a tool called `yarn`.  

The version is the release defined in [Sensu Web Github Release](https://github.com/sensu/web/releases). A valid version number looks like: `v1.2.3`

## Before you start

You need to increase the `sysctl` system-wide limit as shown below (this is not handled by this module):

```conf
fs.inotify.max_user_watches=524288
```

## Usage

you can use the defaults:

```puppet
include sensu_web
```

or you can specify a version (through the git tags availabe on [https://github.com/sensu/web.git](https://github.com/sensu/web.git)):

```puppet
class { 'sensu_web':
  revision => 'v1.2.3';
}
```

a full list of paramters is available inside the file `init.pp`

## Reference

* the official [Puppet module for Sensu](https://github.com/sensu/sensu-puppet)

## Limitations

* No Spec test available
* No changelog available
* sysctl parameter not handled by this module

## Development

Feel free to make pull requests and/or open issues on [my GitHub Repository](https://github.com/maxadamo/sensu_web)

## Release Notes and Contributors

special thanks to [Garrett Honeycutt](https://github.com/ghoneycutt) and [treydock](https://github.com/treydock)

# sensu_web

#### Table of Contents

1. [Description](#description)
1. [Setup](#setup)
1. [Usage](#usage)
1. [Reference](#reference)
1. [Limitations](#limitations)
1. [Development](#development)

## Description

Starting from version 6.0 of Sensu GO, the Web UI has been taken out from the community version and it's now a different application.  
This module sets up Sensu GO Web on Sensu 6.0 and higher.  
The manifest was taken from the [official sensu module](https://github.com/sensu/sensu-puppet) and since it will be removed from there, it is now being offered as a separate module.

## Setup

The module works only in conjunction with the [official sensu module](https://github.com/sensu/sensu-puppet) and it requires a modern system, runing systemd.  

1. First, the application is pulled from the git repository: https://github.com/sensu/web.git
2. Then, the application is installed with the tool called `yarn`.  

The version of the application is the release number defined in Github

## Usage

you can use the defaults:

```puppet
include sensu_web
```

or you can specify a version (through the git tags availabe on https://github.com/sensu/web.git):

```puppet
class { 'sensu_web':
  revision => 'v1.2.3';
}
```

a full list of paramters is available inside `init.pp`

you also need to increase the system-wide limit (`sysctl` paramter):

```conf
fs.inotify.max_user_watches=524288
```

## Reference

* the official [Puppet module for Sensu](https://github.com/sensu/sensu-puppet)

## Limitations

* No Spec test available yet
* No changelog is available
* sysctl parameter not handled through this module

## Development

Feel free to make pull requests and/or open issues on [my GitHub Repository](https://github.com/maxadamo/sensu_web)

## Release Notes/Contributors/Etc. **Optional**

special thanks to [Garrett Honeycutt](https://github.com/ghoneycutt) and [treydock](https://github.com/treydock)

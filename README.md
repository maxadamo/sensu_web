# sensu_web

#### Table of Contents

1. [Description](#description)
1. [Setup](#setup)
    * [Beginning with sensu_web](#beginning-with-sensu_web)
1. [Usage](#usage)
1. [Reference](#reference)
1. [Limitations](#limitations)
1. [Development](#development)

## Description

This module sets up and Sensu GO Web on Sensu 6.0

The manifest is taken from the official module and since it will be remove from there, it is now put in a separate module.

## Setup

### Beginning with sensu_web

This module works only in conjunction with the [official sensu module](https://github.com/sensu/sensu-puppet) and it requires a modern system, runing systemd.  
First, the application is pulled by this git repository: https://github.com/sensu/web.git  
Then, the application is installed through the tool called `yarn`.  
The version of the application is the release number defined in Github

## Usage

you can use the defaults:

```puppet
include sensu_web
```

or you may want to use a specific git release for the Sensu Web application:

```puppet
class { 'sensu_web':
  revision => 'v1.2.3';
}

```

## Reference

## Limitations

* No Spec test available yet
* No changelog is available

## Development

Feel free to make pull requests and/or open issues on [my GitHub Repository](https://github.com/maxadamo/sensu_web)

## Release Notes/Contributors/Etc. **Optional**

special thanks to [Garrett Honeycutt](@ghoneycutt) and [treydock](treydock)

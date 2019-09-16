# puppet-vundle

#### Table of Contents

1. [Description](#description)
2. [Setup](#setup)
    * [What vundle affects](#what-vundle-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with vundle](#beginning-with-vundle)
3. [Usage](#usage)
4. [Reference](#reference)
5. [Limitations](#limitations)
6. [Contribute](#contribute)

## Description

This is a module designed to configure and install [Vundle](https://github.com/VundleVim/Vundle.vim), the plug-in manager for [Vim](http://www.vim.org).  It has been designed with Linux and Unix systems in mind for Puppet 4+.  Separate installations of Vundle for every user are easily handled which gives a great degree of flexibility.

While not required due to the complexity of some of the options Hiera's usage is strongly encouraged.

## Setup

### Setup Requirements

* Git
* Vim
* Puppet >= 4.0
* Facter >= 3.0

### Beginning with vundle

Getting started with Vundle is as simple as including the module with the name of the user desired:

```
vundle::installation { 'username': }
```

Additional options can be attached easily:
```
vundle::installation { 'username:'
  plugins => [ 'someuser/someplugin', 'otheruser/someplugin'],
}
```

If using Hiera which is highly recommended you'll end up with this:

*puppet code*
```
$vundleusers = lookup('vundleusers', { ‘merge’ => ‘hash’ })
create_resources('vundle::installation', $vundleusers)
```

*hiera.yaml*
```
---
vundleusers:
  user1:
    plugins:
      - 'vundlemaker/vundleplugin'
      - 'vundlemaker2/vundleplugin'
```

## Usage

Vundle is installed and configured on a per-user basis.  You're going to want to as a result use the defined type, `vundle::installation { 'username': }`.  To create many, it's recommend to use a hash in Hiera and use a `create_resources` call to do this, like so:
__puppet code:__
```
$userList = lookup('vundle-users', { ‘merge’ => ‘hash’ })
create_resources('vundle::installation', $userList)
```

__hiera file:__
```
---
vundle-users:
  'user1':
    plugins:
      - 'vundlemaker3/vim-someplugin'
  'user2':
    path:     '/home/notnormal/user2'
    plugins:
      - 'vundlemaker4/vim-otherplugin'
      - 'L9'
```

If desired, this plugin can also install Vim easily by setting `viminstall => true`.

## Reference

* `name`:  used as the username to install Vundle under.
* `path`:  path to the user's home.  Default:  `/home/${name}`
* `plugins`:  array of strings for Plugin lines in the `.vimrc`.  Default: `[]`
* `viminstall`:  allows installing Vim directly.  Default:  `false`

## Limitations

This module has only been tested on Ubuntu systems.  It will likely work with others but has not been tested at this time.

## Contribute

* Fork it
* Create a topic branch
* Improve/fix
* Push new topic branch
* Submit a MR

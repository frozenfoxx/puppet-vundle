# puppet-vundle

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with vundle](#setup)
    * [What vundle affects](#what-vundle-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with vundle](#beginning-with-vundle)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This is a module designed to configure and install [Vundle](https://github.com/VundleVim/Vundle.vim), the plug-in manager for [Vim](http://www.vim.org).  It has been designed with Linux and Unix systems in mind for Puppet 4+.  Separate installations of Vundle for every user are easily handled which gives a great degree of flexibility.

While not required due to the complexity of some of the options Hiera's usage is strongly encouraged.

## Setup

### Setup Requirements

* Git
* Vim
* Puppet >= 4.0
* Facter >= 3.0
* Stdlib module

### Beginning with vundle

The very basic steps needed for a user to get the module up and running. This
can include setup steps, if necessary, or it can be an example of the most
basic use of the module.

## Usage

Vundle is installed and configured on a per-user basis.  You're going to want to as a result use the defined type, `vundle::installation { 'vundle-[username]': user => "[username]" }`.

## Reference

Here, include a complete list of your module's classes, types, providers,
facts, along with the parameters for each. Users refer to this section (thus
the name "Reference") to find specific details; most users don't read it per
se.

## Limitations

This module has only been tested on Ubuntu systems.  It will likely work with others but has not been tested at this time.

## Contribute

* Fork it
* Create a topic branch
* Improve/fix
* Push new topic branch
* Submit a PR

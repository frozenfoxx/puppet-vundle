# == Class: vundle::installation
#
# An installation of Vundle for a user.
#
# === Attributes
# * name       => user whose installation this is.
# * path       => path to the user's home directory.  Default:  /home/${name}
# * plugins    => array of plugins for Vundle.
# * viminstall => whether to install the Vim package or not.  Default:  false.
#
define vundle::installation (
  $path       = "/home/${name}",
  $plugins    = [],
  $viminstall = false
  ) {
  # Plugins for Vimrc
  $pluginlist = $plugins

  if $viminstall {
    package {'vim': }
  }

  # Install Vundle for a user
  exec { "vundle-install-${name}":
    command => "git clone https://github.com/VundleVim/Vundle.vim.git ${path}/.vim/bundle/Vundle.vim",
    user    => $name,
    cwd     => $path,
    path    => '/usr/bin/:/bin/',
    creates => "${path}/.vim/bundle/Vundle.vim",
  }

  # Update a Vundle install for a user
  exec { "vundle-update-${name}":
    command     => 'vim --not-a-term +PluginInstall +qall',
    user        => $name,
    cwd         => $path,
    path        => '/usr/bin/:/bin/',
    environment => ["HOME=${path}"],
    refreshonly => true,
    require     => Exec["vundle-install-${name}"],
  }

  # Build the vimrc for a user
  concat { "${name}-vimrc":
    ensure  => 'present',
    path    => "${path}/.vimrc",
    owner   => $name,
    group   => $name,
    mode    => '0644',
    require => Exec["vundle-install-${name}"],
    notify  => Exec["vundle-update-${name}"],
  }

  concat::fragment { "${name}-vimrc-header":
    target  => "${name}-vimrc",
    order   => 0,
    content => template('vundle/vimrc-header.erb'),
  }

  concat::fragment { "${name}-vimrc-plugins":
    target  => "${name}-vimrc",
    order   => 10,
    content => template('vundle/vimrc-plugins.erb'),
  }

  concat::fragment { "${name}-vimrc-footer":
    target  => "${name}-vimrc",
    order   => 20,
    content => template('vundle/vimrc-footer.erb'),
  }
}

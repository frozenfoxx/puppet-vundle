# == Class: vundle::installation
#
# An installation of Vundle for a user.
#
# === Attributes
# * name    => user whose installation this is.
# * path    => path to the user's home directory.
# * plugins => array of plugins for Vundle.
#
# === Authors
#
# * FOXX <mailto:siliconfoxx@gmail.com>
#
# === Copyright
#
# Copyright 2016 FOXX.
#
define vundle::installation (
  $path         = "/home/${name}",
  $plugins      = []
  ) {
  # Plugins for Vimrc
  $pluginlist   = $plugins

  exec { "vundle-install-${name}":
    command     => "git clone https://github.com/VundleVim/Vundle.vim.git ${path}/.vim/bundle/Vundle.vim",
    creates     => "${path}/.vim/bundle/Vundle.vim",
  }

  exec { "vundle-update-${name}":
    command     => "vim +PluginInstall +qall",
    user        => $name,
    refreshonly => true,
    require     => Exec["vundle-install-${name}"],
  }

  concat { "${name}-vimrc":
    ensure      => 'file',
    path        => "${path}/.vimrc",
    owner       => $name,
    group       => $name,
    mode        => '0644',
    require     => Exec["vundle-install-${name}"],
    notify      => Exec["vundle-update-${name}"],
  }

  concat::fragment { "${name}-vimrc-header":
    target      => "${name}-vimrc",
    order       => 0,
    content     => template('vundle/vimrc-header.erb'),
  }

  concat::fragment { "${name}-vimrc-plugins":
    target      => "${name}-vimrc",
    order       => 10,
    content     => template('vundle/vimrc-plugins.erb'),
  }

  concat::fragment { "${name}-vimrc-footer":
    target      => "${name}-vimrc",
    order       => 20,
    content     => template('vundle/vimrc-footer.erb'),
  }
}

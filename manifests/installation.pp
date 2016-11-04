# == Class: vundle::installation
#
# An installation of Vundle.
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
  $user      = '',
  $user_dir  = '/home/#{::vundle::installation::user}',
  ) {
}

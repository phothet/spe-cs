# pre_req for SPE installation
# java_jre_32, zlib_32, sharutils, libuuid_32, ncompress, glibc, initscripts, 

# set variable for pre req packages
# $ pre_req

# install all the pre req packages
package { $pre_req:
  ensure => installed,
}

# create directory for SPE
file { '/opt/SYMSCAN':
  # make sure this is directory
  ensure => directory,
  # owner 
  # permission
  # inform symncscan serivice
  notify => Service ['symcscan'],
  # require
  require => [Package [$pre_req]],
}

# make sure service is enabled and installed
# future improvement - enable systemd serviec for SPE
service { 'symcscan':
  ensure  => running,
  enable  => true,
  require => [Package [$pre_req], File ['/opt/SYMSCAN']],
}

import 'dhcp'
import 'razor'
import 'sudo'

# Base Razor Setup

class { 'dhcp':
  dnsdomain   =>  [
                    'razor.lan',
                    '1.0.10.in-addr.arpa',
                  ],
  nameservers => ['10.0.1.50'],
  ntpservers  => ['us.pool.ntp.org'],
  interfaces  => ['eth1'],
  pxeserver   => '10.0.1.50',
  pxefilename => 'pxelinux.0',
}

dhcp::pool { 'cut.razor.lan':
  network => '10.0.1.0',
  mask    => '255.255.255.0',
  range   => '10.0.1.100 10.0.1.200',
  gateway => '10.0.1.1',
}

class { 'sudo': }

sudo::conf { 'vagrant':
  content => 'vagrant ALL=(ALL) NOPASSWD: ALL',
}

class { 'razor':
  username  => 'razor',
  directory => '/opt/razor',
  address   => '10.0.1.50',
  require   => Class['sudo'],
}

# Razor Ubuntu Precise Setup

rz_image { 'ubuntu-precise':
  ensure  => present,
  type    => 'os',
  version => '12.04.1',
  source  => '/vagrant/isos/ubuntu-12.04.2-server-amd64.iso',
  url     => 'http://releases.ubuntu.com/precise/ubuntu-12.04.2-server-amd64.iso',
}

rz_model { 'ubuntu-precise':
  ensure      => present,
  description => 'Ubuntu Precise Model',
  image       => 'ubuntu-precise',
  metadata    => {
    'domainname'      => 'cut.razor.lan',
    'hostname_prefix' => 'ubuntu-precise-',
    'rootpassword'    => 'electric',
  },
  template    => 'ubuntu_precise',
}

rz_tag { 'ubuntu-precise':
  tag_label   => 'ubuntu-precise',
  tag_matcher => [
    {
      'key'     => 'macaddress_eth0',
      'compare' => 'equal',
      'value'   => '08:00:27:7E:25:02',
    }
  ],
}

rz_policy { 'ubuntu-precise':
  ensure    => present,
  broker    => 'none',
  model     => 'ubuntu-precise',
  enabled   => true,
  tags      => ['ubuntu-precise'],
  template  => 'linux_deploy',
}

# Razor CentOS 6 Setup

rz_image { 'centos-6':
  ensure  => present,
  type    => 'os',
  version => '6.3',
  source  => '/vagrant/isos/CentOS-6.3-x86_64-minimal.iso',
  url     => 'http://mirror.rackspace.com/CentOS/6.3/isos/x86_64/CentOS-6.3-x86_64-minimal.iso',
}

rz_model { 'centos-6':
  ensure      => present,
  description => 'CentOS 6 Model',
  image       => 'centos-6',
  metadata    => {
    'domainname'      => 'cut.razor.lan',
    'hostname_prefix' => 'centos-6-',
    'rootpassword'    => 'electric',
  },
  template    => 'centos_6',
}

rz_tag { 'centos-6':
  tag_label   => 'centos-6',
  tag_matcher => [
    {
      'key'     => 'macaddress_eth0',
      'compare' => 'equal',
      'value'   => '08:00:27:7E:25:03',
    }
  ],
}

rz_policy { 'centos-6':
  ensure    => present,
  broker    => 'none',
  model     => 'centos-6',
  enabled   => true,
  tags      => ['centos-6'],
  template  => 'linux_deploy',
}

# Razor Post Install Broker

#rz_broker { 'puppet':
#  plugin => 'puppet',
#}

# Hacks to get tftpd properly working with xinetd.

file { '/usr/sbin/in.tftpd':
  ensure  => file,
  mode    => 'a+rx',
  require => Class['razor'],
}

File['/usr/sbin/in.tftpd'] ~> Service['xinetd']

#"
# This module is used to setup the puppetlabs repos
# that can be used to install puppet.
#
class puppet::repo::puppetlabs() {

  if($::osfamily == 'Debian') {
    Apt::Source { 'puppetlabs-pc1'
      location    => 'http://apt.puppetlabs.com',
      repos    => 'PC1',
      key      => {
        'id'     => '6F6B15509CF8E59E6E469F327F438280EF8D349F',
        'server' => 'pgp.mit.edu',
      },
    }
  } elsif $::osfamily == 'Redhat' {
    if $::operatingsystem == 'Fedora' {
      $ostype = 'fedora'
      $prefix = 'f'
    } else {
        $ostype = 'el'
        $prefix = $::operatingsystemmajrelease
    }
    yumrepo {'puppetlabs-pc1':
      baseurl  => "https://yum.puppetlabs.com/${ostype}/${version}/PC1/\$basearch",
      descr    => 'Puppetlabs PC1 Repository',
      enabled  => true,
      gpgcheck => '1',
      gpgkey   => 'https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs'
    }
  } else {
    fail("Unsupported osfamily ${::osfamily}")
  }
}

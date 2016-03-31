class ec2 (
  $hostname = undef,
) {
  if $hostname == undef {
    fail("hostname must be defined")
  }
  
  file { '/etc/hosts':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/hosts.erb"),
  }

  file { '/etc/hostname':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "${hostname}\n",
  }

  exec { 'hostname':
    command => "/bin/hostname ${hostname}",
  }

  file { '/etc/timezone':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => 'PDT8PST',
  }

  file { '/etc/localtime':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'file:///usr/share/zoneinfo/PST8PDT',
  }

}

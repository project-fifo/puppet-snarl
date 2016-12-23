class snarl::config {
  $base = "/opt/local/fifo-snarl"
  $file = "snarl.conf"
  $conf = "/data/snarl/etc/${file}"

  $ip        = $facts['ipaddress']
  $port      = 4200
  $ring_size = 64

  package { 'augeas':
    ensure => installed,
  }

  package { 'ruby-augeas':
    require => [ Package['augeas'], Package['pkg-config'] ],
    ensure   => 'installed',
    provider => 'gem',
  }

  file { $conf:
    require => [ File["${base}/etc"], Exec["make_rel_snarl"] ],
    source => "${base}/etc/${file}.example",
    ensure  => present,
  }

  augeas { $file:
    require => [ File[$conf], Package['ruby-augeas'] ],
    load_path => "/data/code/snarl/_build/default/lib/fifo_utils/priv/lenses",
    context   => "/files${conf}",
    changes   =>
    [
     "set ring_size ${ring_size}",
     "set ip ${ip}:${port}",
     "set listening_ip ${ip}",
     "set nodename snarl@${ip}",
     ]
  }
  }

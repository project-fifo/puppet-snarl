class snarl::svcs {
  class { fifo_test::svcs:
    svc     => 'snarl',
    require => [
                Exec[ 'user_privs_snarl' ],
                ]
  }
}

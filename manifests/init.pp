class snarl {
  class { snarl::deps:    }
  class { snarl::clone:   }
  class { snarl::compile: }
  class { snarl::link:    }
  class { snarl::config:  }
  class { snarl::svcs:    }

  }

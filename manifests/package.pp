class kafka::package(
  $ensure  = undef,
  $package = undef,
  $version = undef,
) {
  $real_ensure = $ensure ? {
    present => $version,
    default => absent
  }
  package { $package:
    ensure => $real_ensure,
  }

  homebrew::formula {'kafka':}

  ->
  Package[$package]

}

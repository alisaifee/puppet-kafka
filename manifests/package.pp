class kafka::package(
  $ensure  = undef,
  $version = undef,
) {
  $real_ensure = $ensure ? {
    present => $version,
    default => absent
  }

  package { 'kafka':
    ensure => $real_ensure,
  }
}

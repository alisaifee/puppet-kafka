class kafka::config(
  $ensure        = undef,

  $host          = undef,
  $port          = undef,

  $configdir     = undef,
  $datadir       = undef,
  $logdir        = undef,

  $broker_config = undef,
  $zookeeper     = undef,

  $executable    = undef,
  $servicename   = undef,
) {
  $dir_ensure = $ensure ? {
    present => directory,
    default => absent,
  }

  if $::operatingsystem == 'Darwin' {
    include boxen::config

    file {
      "/Library/LaunchDaemons/${servicename}.plist":
      ensure   => $ensure,
      content  => template('kafka/darwin/kafka.plist.erb'),
      group    => 'wheel',
      owner    => 'root' ;
    }

    ->
    boxen::env_script { 'kafka':
      ensure   => $ensure,
      content  => template('kafka/darwin/env.sh.erb'),
      priority => 'lower',
    }
  }

  file {
    [
      $configdir,
      $datadir,
      $logdir,
    ]:
      ensure => $dir_ensure ;

    "${configdir}/server.properties":
      ensure  => $ensure,
      content => template('kafka/server.properties.erb')
  }
}

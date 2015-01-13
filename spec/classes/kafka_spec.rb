require 'spec_helper'
# Rename this file to classname_spec.rb
# Check other boxen modules for examples
# or read http://rspec-puppet.com/tutorial/

Puppet::Util::Log.level = :debug
Puppet::Util::Log.newdestination(:console)

describe 'kafka' do
  let(:facts) { default_test_facts }

  it do
    should contain_package('kafka')

    should contain_service('dev.kafka')
  end
end

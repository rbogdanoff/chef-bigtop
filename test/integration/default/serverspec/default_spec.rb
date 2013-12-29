require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe 'bigtop::default' do
  it 'installed java' do
    expect(command('java')).to return_exit_status 0
  end
end

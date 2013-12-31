require 'spec_helper'

describe 'bigtop::base' do

  # was java install
  it 'installed oracle java version 6' do
    expect(command('java')).to return_exit_status 0
    expect(command('java -version')).to return_stdout /java version \"1.6/
    expect(command('java -version')).to return_stdout /Java\(TM\) SE Runtime Environment/
  end
end

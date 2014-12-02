require 'spec_helper'

describe 'bigtop::base' do

  describe 'java' do
    describe 'is installed' do
  	  describe command('java') do
        its(:exit_status) { should eq 0 }
      end
    end
    describe 'is version 6' do
      describe command('java -version') do
        its(:stdout) { should match /java version "1\.6/}
        its(:stdout) { should match /Java\(TM\) SE Runtime Environment/}
      end
    end
  end

end

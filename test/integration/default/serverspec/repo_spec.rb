require 'spec_helper'

describe 'bigtop::repo' do
  
  describe 'the bigtop repository' do
  	describe file('/etc/yum.repos.d/bigtop.repo') do
      it { should be_file }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 644}
    end
  end

end

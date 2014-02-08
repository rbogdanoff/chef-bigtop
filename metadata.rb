name             'bigtop'
maintainer       'Ron Bogdanoff'
maintainer_email 'ron.bogdanoff@gmail.com'
license          'apache 2.0'
description      'Installs/Configures bigtop'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.2'

recipe 'bigtop', 'Installs bigtop'

%w{ centos }.each do |os|
  supports os
end

depends 'java', '<= 1.19.2'

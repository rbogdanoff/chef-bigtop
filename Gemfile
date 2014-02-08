source 'https://rubygems.org'

# gem 'berkshelf',  '~> 2.0'
# NOTE: berkshelf 2.x has a dependency bug, need to use 3.x but
# 3.x not yet at rubygems.org see  https://github.com/berkshelf/berkshelf
# for more info
gem "berkshelf",  github: "berkshelf/berkshelf"
gem 'chefspec',   '~> 3.2.0'
gem 'foodcritic', '~> 3.0'
gem 'rubocop',    '<= 0.15'

group :integration do
  gem 'test-kitchen',    '~> 1.0.0.beta'
  gem 'kitchen-vagrant', '~> 0.11'	
  gem 'kitchen-ec2'
end

require 'serverspec'
# Set backend type
set :backend, :exec
# 
set :path, '/sbin:/usr/sbin:$PATH'

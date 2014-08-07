require 'bundler/capistrano'
require 'rvm/capistrano'
require 'visionbundles'

# RVM Settings
set :rvm_ruby_string, '2.1.0'
set :rvm_type, :user
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Recipes Settings
include_recipes :nginx, :puma, :db, :dev

# Nginx
set :nginx_vhost_domain, '128.199.216.178'
set :nginx_upstream_via_sock_file, false
set :nginx_app_servers, ['127.0.0.1:9290']

# Puma
set :puma_bind_for, :tcp
set :puma_bind_to, '127.0.0.1'
set :puma_bind_port, '9290'
set :puma_thread_min, 32
set :puma_thread_max, 32
set :puma_workers, 3

# Role Settings
server '128.199.216.178', :web, :app, :db, primary: true

# Capistrano Base Setting
set :application, 'artstore'
set :user, 'rails'
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rails_env, 'production'

# Git Settings
set :scm, :git
set :repository, "https://github.com/jimmy0328/#{application}.git"
set :branch, 'store-v3-solution'

# Others
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# Deploy Flow
after 'deploy', 'deploy:cleanup' # keep only the last 5 releases
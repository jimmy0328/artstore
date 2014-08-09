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
set :nginx_vhost_domain, '128.199.167.221'
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
server '128.199.167.221', :web, :app, :db, primary: true

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
set :branch, 'jimmytest'

# Others
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# Deploy Flow
after 'deploy', 'deploy:cleanup' # keep only the last 5 releases


namespace :deploy do
  task :setup_config_yml do 
    put File.read("config/config.yml.example"), "#{shared_path}/config/config.yml"
  end
  after 'deploy:setup', 'deploy:setup_config_yml'

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/config.yml #{release_path}/config/config.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"
end

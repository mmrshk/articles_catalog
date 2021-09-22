# config valid for current version and patch releases of Capistrano
lock '~> 3.16.0'

server 'ec2-3-128-160-236.us-east-2.compute.amazonaws.com', post: '3.128.160.236', user: 'ubuntu', roles: %w{app db web}, primary: true

set :application, 'articles_catalog'
set :repo_url, 'git@github.com:mmrshk/articles_catalog.git'
set :user, 'ubuntu'
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :branch, 'main'

append :linked_files, *%w(
  config/database.yml
  config/master.key
)

append :linked_dirs, *%w(
  log
  public/system
  public/uploads
  tmp/cache
  tmp/pids
  tmp/sockets
  vendor/bundle
  .bundle
)

# Puma config
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

set :keep_releases, 5

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc 'Upload config files'
  task upload_configs: ['deploy:check:linked_dirs'] do
    on roles(:all) do
      execute "mkdir -p #{shared_path}/config"
      upload! 'config/database.yml', "#{deploy_to}/shared/config/database.yml"
      upload! 'config/credentials.yml.enc', "#{deploy_to}/shared/config/secrets.yml"
    end
  end

  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/main`
        puts "WARNING: HEAD is not the same as origin/main"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end


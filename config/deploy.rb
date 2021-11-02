# config valid for current version and patch releases of Capistrano
lock '~> 3.16.0'

set :application, 'articles_catalog'
set :repo_url, 'git@github.com:mmrshk/articles_catalog.git'
set :user, 'ubuntu'
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :branch, 'main'
set :rbenv_ruby, '2.7.1'

server 'ec2-3-23-79-24.us-east-2.compute.amazonaws.com', post: '3.23.79.24', user: 'ubuntu', roles: %w{app db web}, primary: true

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

# namespace :sidekiq do
#   task :restart do
#     invoke 'sidekiq:stop'
#     invoke 'sidekiq:start'
#   end

#   before 'deploy:finished', 'sidekiq:restart'

#   task :stop do
#     on roles(:app) do
#       within current_path do
#         pid = p capture "ps aux | grep sidekiq | awk '{print $2}' | sed -n 1p"
#         execute("kill -9 #{pid}")
#       end
#     end
#   end

#   task :start do
#     on roles(:app) do
#       within current_path do
#         execute :bundle, "exec sidekiq -e #{fetch(:stage)} -C config/sidekiq.yml -d"
#       end
#     end
#   end
# end

namespace :deploy do
  desc "Remove all but the last release"
  task :cleanup_all do
      set :keep_releases, 1
      invoke "deploy:cleanup"
  end

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

  # before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup_all
  # after  :finishing,    :restart
end


set :repo_url, "git@github.com:omxhealth/metaboflo.git"
set :scm, :git
set :use_sudo, false
set :linked_files, ['config/database.yml',
                    'config/secrets.yml',
                    'config/app_config.yml']
set :linked_dirs, %w{tmp/pids tmp/sockets index log public/system}
set :keep_releases, 5

namespace :deploy do
  desc 'Start application'
  task :start do
    on roles(:web) do
      invoke('puma:start')
    end
  end

  desc 'Stop application'
  task :stop do
    on roles(:web) do
      invoke('puma:stop')
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:web) do
      invoke('puma:phased-restart')
    end
  end

  desc 'Hard-restart application'
  task :hard_restart do
    on roles(:web) do
      invoke('puma:restart')
    end
  end
end

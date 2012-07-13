set :application, "metaboflo"
set :repository,  "git@jrc.insiliflo.com:metaboflo.git"
set :branch, "einstein-demo"

set :scm, :git

role :web, "einstein.insiliflo.com"                          # Your HTTP server, Apache/etc
role :app, "einstein.insiliflo.com"                          # This may be the same as your `Web` server
role :db,  "einstein.insiliflo.com", :primary => true # This is where Rails migrations will run

set :deploy_via, :remote_cache
set :deploy_to, "/apps/#{application}/einstein"
set :user, "insiliflo"
set :use_sudo, false
set :keep_releases, 2


# Allow to stop/start/restart passenger
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace(:customs) do
  # Custom task to symlink the files from the shared to current
  task :config, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end
end

# Run our custom post-deploy recipes, and perform a cleanup (removes all releases except for the last 5)
before "deploy:assets:precompile", "customs:config"
after "deploy", "deploy:cleanup"

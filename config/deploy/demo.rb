set :application, "bovine_demo"
set :repository,  "svn+ssh://joseph@jrc.insiliflo.com/svn/insiliflo/bovine/trunk"
set :local_repository, "svn+ssh://jrc.insiliflo.com/svn/insiliflo/bovine/trunk"

set :scm, :subversion
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "bovine-demo.insiliflo.com"                          # Your HTTP server, Apache/etc
role :app, "bovine-demo.insiliflo.com"                          # This may be the same as your `Web` server
role :db,  "bovine-demo.insiliflo.com", :primary => true # This is where Rails migrations will run

set :user, "jcruz"
set :deploy_to, "/home/#{user}/rails_apps/#{application}"
set :use_sudo, false

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace(:customs) do
  # Create the config directory in shared and create an empty database.yml file
  task :setup_config, :roles => :app do
    run <<-CMD
      if ![ -d #{shared_path}/config ]; then mkdir #{shared_path}/config; fi && touch #{shared_path}/config/database.yml
    CMD
  end

  # Create the public directory in shared and create an empty .htaccess file
  task :setup_htaccess, :roles => :app do
    run <<-CMD
      if ![ -d #{shared_path}/public ]; then mkdir #{shared_path}/public; fi && touch #{shared_path}/public/.htaccess
    CMD
  end

  # Custom task to symlink the database.yml file from the shared/config to current/config
  task :config, :roles => :app do
    run <<-CMD
      ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml
    CMD
  end
  
  # Custom task to symlink the .htaccess file from the shared/public to current/public/config
  task :htaccess, :roles => :app do
    run <<-CMD
      ln -nfs #{shared_path}/public/.htaccess #{release_path}/public/.htaccess
    CMD
  end
end

# Run our custom post-deploy recipes, and perform a cleanup (removes all releases except for the last 5)
after "deploy:setup", "customs:setup_config"
after "deploy:setup", "customs:setup_htaccess"
after "deploy:update_code", "customs:config"
after "deploy:symlink","customs:htaccess"
after "deploy", "deploy:cleanup"
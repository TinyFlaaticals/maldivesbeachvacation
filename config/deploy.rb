require "mina/rails"
require "mina/git"
require "mina/rvm"

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :application_name, "resort-booking"
set :domain, "booking.mv-dev.xyz"
set :user, fetch(:application_name)
set :deploy_to, "/home/#{fetch(:user)}/app"
set :repository, "git@bitbucket.org:313zed/resort-booking.git"
set :branch, "main"
set :rvm_use_path, "/etc/profile.d/rvm.sh"

# Optional settings:
#   set :user, 'foobar'          # Username in the server to SSH to.
#   set :port, '30000'           # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# Shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`
# set :shared_dirs, fetch(:shared_dirs, []).push('public/assets')
set :shared_files, fetch(:shared_files, []).push("config/database.yml", "config/secrets.yml", "config/master.key", "config/credentials/production.yml.enc", "config/credentials/production.key")
set :shared_dirs, fetch(:shared_dirs, []).push("public/packs", "node_modules", "storage")

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :remote_environment do
  ruby_version = File.read(".ruby-version").strip
  raise "Couldn't determine Ruby version: Do you have a file .ruby-version in your project root?" if ruby_version.empty?

  invoke :'rvm:use', ruby_version
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  in_path(fetch(:shared_path)) do
    command %(mkdir -p config)

    # Create database.yml for Postgres if it doesn't exist
    path_database_yml = "config/database.yml"
    database_yml = %(production:
  database: #{fetch(:user)}
  adapter: postgresql
  pool: 5
  timeout: 5000)
    command %(test -e #{path_database_yml} || echo "#{database_yml}" > #{path_database_yml})

    # Create secrets.yml if it doesn't exist
    path_secrets_yml = "config/secrets.yml"
    secrets_yml = %(production:\n  secret_key_base:\n    #{`bundle exec rake secret`.strip})
    command %(test -e #{path_secrets_yml} || echo "#{secrets_yml}" > #{path_secrets_yml})

    # Remove others-permission for config directory
    command %(chmod -R o-rwx config)
  end
  command %(chmod g+rx,u+rwx "#{fetch(:shared_path)}/config")

  # Upload master.key
  command %(echo "#{File.read('config/master.key')}" > "#{fetch(:shared_path)}/config/master.key")
  command %(chmod 600 "#{fetch(:shared_path)}/config/master.key")

  # Upload credentials.yml.enc
  command %(echo "#{File.read('config/credentials/production.yml.enc')}" > "#{fetch(:shared_path)}/config/credentials/production.yml.enc")
  command %(chmod 600 "#{fetch(:shared_path)}/config/credentials/production.yml.enc")

  command %(echo "#{File.read('config/credentials/production.key')}" > "#{fetch(:shared_path)}/config/credentials/production.key")
  command %(chmod 600 "#{fetch(:shared_path)}/config/credentials/production.key")
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      command "sudo systemctl restart #{fetch(:user)}"
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs



desc "Drops the database and sets up a fresh one"
task :reset_db do
  command %(cd #{fetch(:current_path)})
  command %(bundle exec rake db:drop RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1)
end

desc "Resets the database and runs migrations"
task :reset_db_and_migrate do
  invoke :'reset_db'
  invoke :'rake[db:migrate]'
end

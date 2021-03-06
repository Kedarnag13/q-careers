require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
# require 'mina/rvm'    # for rvm support. (http://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :domain, 'it.q-careers.qwinixtech.com'
set :deploy_to, '/u01/apps/qwinix/q-careers'
set :repository, 'https://github.com/QwinixLabs/q-careers.git'
set :branch, 'master'

case ENV['to']
when 'it'
  set :deploy_to, 'Path_for_IT'
  set :env, 'it'
when 'staging'
  set :deploy_to, 'Path_for_STAGING'
  set :env, 'staging'
else
  set :deploy_to, 'Path_for_PRODUCTION'
  set :env, 'production'
end

# For system-wide RVM install.
#   set :rvm_path, '/usr/local/rvm/bin/rvm'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'config/secrets.yml', 'public/uploads', 'log']

# Optional settings:
set :user, 'deploy'   # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.
set :bundle_bin, %{PATH="#{deploy_to}/bin:$PATH" GEM_HOME="#{deploy_to}/gems" RUBYLIB="#{deploy_to}/lib" RAILS_ENV=#{env} #{deploy_to}/bin/bundle}

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use[ruby-1.9.3-p125@default]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
    end
  end
end

  namespace :apache do
    task :start => :environment do
      queue %{#{deploy_to}/bin/start}
    end
  end

  task :stop => :environment do
    queue %{#{deploy_to}/bin/stop}
  end

  task :restart => :environment do
    queue %{#{deploy_to}/bin/restart}
  end


task :logs do
  queue 'echo "[ TAIL CONTENTS OF LOG FILE ]"'
  queue %{tail -f #{deploy_to}/current/log/#{env}.log}
end

task :console => :environment do
  queue 'echo "[ STARTING EXTERNAL RAILS CONSOLE ]"'
  queue %{#{bundle_bin} exec rails c}
end


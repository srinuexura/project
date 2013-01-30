require 'bundler/capistrano'  # Add Bundler integration
load 'deploy/assets'  # only for rails 3.1 apps, this makes sure our assets are precompiled.

set :application, "web-l.nl"
role :web, "12.1.12.11"  # Your HTTP server, Apache/etc
role :app, "12.1.12.11"  # This may be the same as your `Web` server
role :db,  "12.1.12.11", :primary => true  # This is where Rails migrations will run

set :scm, :git
set :repository, "root@staging.exura.in:/root/REPOs/staging.git"
set :branch, "master"

set :user, "root"
set :deploy_to, "/var/www/staging"
set :deploy_via, :remote_cache
set :use_sudo, false
set :scm_passphrase, "exura2012"

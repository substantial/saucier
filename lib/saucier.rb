require 'capistrano'

require "saucier/recipes/chef_solo"
require "saucier/recipes/chef_librarian"

module Capistrano::Saucier
  def self.load_into(configuration)
    configuration.load do
      after 'deploy:setup', 'deploy:set_ownership'
      before 'chef_solo', 'deploy:bundle_install'

      namespace :provision do
        set :deploy_to, chef_deploy_to

        task :default do
          deploy.setup
          deploy.update_code
          chef_solo.default
          deploy.create_symlink
        end

        task :set_ownership do
          sudo "chown -R #{user}:#{group} #{deploy_to}"
        end

        task :bundle_install do
          command = []
          command << ". /etc/profile.d/rvm.sh"
          command << "cd #{current_release}"
          command << "rvm use #{chef_ruby}@#{chef_gemset} --create"
          command << "bundle install"
          run command.join(" && ")
        end
      end
    end
  end
end

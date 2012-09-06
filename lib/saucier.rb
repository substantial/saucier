require 'capistrano'

require "saucier/recipes/chef_solo"
require "saucier/recipes/chef_librarian"

module Capistrano::Saucier
  require 'saucier/helpers'

  def self.load_into(configuration)
    configuration.load do
      _cset(:chef_deploy_to, "/etc/chef")
      _cset(:user, "deploy")
      _cset(:group, "rvm")

      namespace :provision do
        after 'deploy:setup', 'provision:set_ownership'
        after 'deploy:update_code', 'provision:bundle_install'

        set :deploy_to, chef_deploy_to

        task :default do
          transaction do
            deploy.update_code
            chef_librarian.default
            chef_solo.default
            provision.symlink_cookbooks
            deploy.create_symlink
          end
        end

        task :setup do
          deploy.setup
        end

        task :set_ownership do
          sudo "chown -R #{user}:#{group} #{deploy_to}"
        end

        task :symlink_cookbooks do
          shared_cookbooks = File.join(shared_dir, 'cookbooks')
          release_cookbooks = File.join(current_release, 'cookbooks')
          run "mkdir -p #{shared_cookbooks}; ln -s #{shared_cookbooks} #{release_cookbooks}"
        end

        task :bundle_install do
          command = []
          command << "cd #{current_release}"
          command << rvm_wrapper("bundle install")
          run command.join(" && ")
        end
      end
    end
  end
end

if instance = Capistrano::Configuration.instance
  Capistrano::Saucier.load_into(instance)
end

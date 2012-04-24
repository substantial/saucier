require 'capistrano'
require 'cap-sous-chef/helpers'
require 'cap-sous-chef/recipes/chef_librarian'

module Capistrano::CapSousChef
  module Recipes
    module ChefSolo
      def self.load_into(configuration)
        configuration.load do

          before 'chef_solo:default', 'deploy:bundle_install'
          before 'chef_solo:install', 'chef_librarian:install'
          after 'deploy:setup', 'deploy:set_ownership'

          _cset(:chef_ruby, "default")
          _cset(:chef_gemset, "global")
          _cset(:deploy_to, "/etc/chef")
          _cset(:user, "deploy")
          _cset(:group, "rvm")
          _cset(:chef_solo_config, ".chef/solo.rb")
          _cset(:chef_node_config, ".chef/node.json")

          namespace :deploy do
            task :set_ownership do
              sudo "chown -R #{user}:#{group} #{deploy_to}"
            end

            task :bundle_install do
              command = []
              command << ". /etc/profile.d/rvm.sh"
              command << "cd #{current_release}"
              command << "rvm use #{chef_ruby}@#{chef_gemset}"
              command << "bundle install"
              run command.join(" && ")
            end
          end

          namespace :chef_solo do
            task :default do
              chef_solo.install
            end

            task :install do
              servers = find_servers_for_task(current_task)
              servers.each do |s|
                command = []
                command << ". /etc/profile.d/rvm.sh"
                command << "cd #{current_release}"
                command << "rvm use #{chef_ruby}@#{chef_gemset}"
                command << "rvmsudo chef-solo -c #{current_release}/#{chef_solo_config} -j #{current_release}/#{chef_node_config} -N #{s.options[:node_name]}"
                run command.join(" && ")
              end
            end
          end
        end
      end
    end
  end
end

if instance = Capistrano::Configuration.instance
  Capistrano::CapSousChef::Recipes::ChefSolo.load_into(instance)
end

require 'capistrano'
require 'saucier/helpers'
require 'saucier/recipes/chef_librarian'

module Capistrano::Saucier
  module Recipes
    module ChefSolo
      def self.load_into(configuration)
        configuration.load do
          _cset(:chef_ruby, "default")
          _cset(:chef_gemset, "global")
          _cset(:chef_deploy_to, "/etc/chef")
          _cset(:chef_solo_config, ".chef/solo.rb")
          _cset(:chef_node_config, ".chef/node.json")

          namespace :chef_solo do
            task :default do
              chef_librarian.install
              chef_solo.install
            end

            task :install do
              servers = find_servers_for_task(current_task)
              servers.each do |s|
                node_name = s.options[:node_name] ||= 'chef-node'
                command = []
                command << ". /etc/profile.d/rvm.sh"
                command << "cd #{current_release}"
                command << "rvm use #{chef_ruby}@#{chef_gemset} --create"
                command << "rvmsudo chef-solo -c #{current_release}/#{chef_solo_config} -j #{current_release}/#{chef_node_config} -N #{node_name}"
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
  Capistrano::Saucier::Recipes::ChefSolo.load_into(instance)
end
require 'capistrano'
require 'saucier/helpers'

module Capistrano::Saucier
  module Recipes
    module ChefSolo
      def self.load_into(configuration)
        configuration.load do
          _cset(:chef_ruby, "default")
          _cset(:chef_gemset, "global")
          _cset(:chef_solo_config, ".chef/solo.rb")
          _cset(:chef_node_config, ".chef/node.json")

          namespace :chef_solo do
            task :default do
              chef_solo.install
            end

            task :install do
              servers = find_servers_for_task(current_task)
              servers.each do |s|
                node_name = s.options[:node_name] || 'chef-node'
                command = []
                command << "cd #{current_release}"

                command << rvm_wrapper("rvmsudo -E env SSH_AUTH_SOCK=$SSH_AUTH_SOCK bash -c '$GEM_HOME/bin/chef-solo -c #{current_release}/#{chef_solo_config} -j #{current_release}/#{chef_node_config} -N #{node_name}'")
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


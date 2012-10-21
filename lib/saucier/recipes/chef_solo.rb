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
          _cset(:chef_node_config_path, ".chef")

          namespace :chef_solo do
            task :default do
              chef_solo.install
            end

            task :install do
              servers = find_servers_for_task(current_task)
              servers.each do |server|
                node_name = server.options[:node_name] || 'chef-node'
                roles = role_names_for_host(server)
                command = []
                command << "cd #{current_release}"
                roles.each do |role|
                  role_path = "#{current_release}/#{chef_node_config_path}/node_#{role}.json"
                  command << rvm_wrapper("rvmsudo env SSH_AUTH_SOCK=$SSH_AUTH_SOCK chef-solo -c #{current_release}/#{chef_solo_config} -j #{role_path} -N #{node_name}")
                end
                run command.join(" && "), hosts: [server]
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


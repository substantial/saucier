require 'capistrano'
require 'cap-sous-chef/helpers'

module Capistrano::CapSousChef
  module ChefLibrarian
    def self.load_into(configuration)
      configuration.load do

        _cset(:chef_ruby, "default")
        _cset(:chef_gemset, "global")

        namespace :chef_librarian do
          task :default do
            chef_librarian.install
          end

          task :install do
            command = []
            command << ". /etc/profile.d/rvm.sh"
            command << "cd #{current_release}"
            command << "rvm use #{default_ruby}@#{gemset}"
            command << "bundle exec librarian-chef install"
            run command.join(" && ")
          end
        end
      end
    end
  end
end


if Capistrano::Configuration.instance
  Capistrano::CapSousChef::ChefLibrarian.load_into(Capistrano::Configuration.instance)
end

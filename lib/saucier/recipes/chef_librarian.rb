require 'capistrano'
require 'saucier/helpers'

module Capistrano::Saucier
  module Recipes
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
              command << "cd #{current_release}"
              command << rvm_wrapper("bundle exec librarian-chef install")
              run command.join(" && ")
            end
          end
        end
      end
    end
  end
end

if instance = Capistrano::Configuration.instance
  Capistrano::Saucier::Recipes::ChefLibrarian.load_into(instance)
end

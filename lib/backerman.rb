require 'capistrano'

require "backerman/recipes/chef_solo"
require "backerman/recipes/chef_librarian"

if instance = Capistrano::Configuration.instance
  Capistrano::Backerman::ChefSolo.load_into(instance)
  Capistrano::Backerman::ChefLibrarian.load_into(instance)
end

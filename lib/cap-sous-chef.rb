require 'capistrano'

require "cap-sous-chef/recipes/chef_solo"
require "cap-sous-chef/recipes/chef_librarian"

if instance = Capistrano::Configuration.instance
  Capistrano::CapSousChef::ChefSolo.load_into(instance)
  Capistrano::CapSousChef::ChefLibrarian.load_into(instance)
end

require 'spec_helper'
require 'backerman/recipes/chef_solo'

describe Capistrano::Backerman::ChefSolo do
  load_capistrano_recipe(Capistrano::Backerman::ChefSolo)

  describe "tasks" do
    it "has :install" do
      recipe.must_have_task "chef_solo:install"
    end

    it "has :default" do
      recipe.must_have_task "chef_solo:default"
    end

    it "runs chef_librarian:install before chef_solo:install" do
      recipe.must_have_callback_before "chef_librarian:install", "chef_solo:install"
    end
  end


  describe "default values" do
    it "default_ruby is 'default'" do
      recipe.fetch(:default_ruby).must_equal "default"
    end

    it "gemset is 'global'" do
      recipe.fetch(:gemset).must_equal "global"
    end
  end
end

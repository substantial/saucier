require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe Capistrano::Saucier::Recipes::ChefSolo do
  load_capistrano_recipe(Capistrano::Saucier::Recipes::ChefSolo)

  describe "tasks" do
    it "has chef:install" do
      recipe.must_have_task "chef_solo:install"
    end

    it "has chef:default" do
      recipe.must_have_task "chef_solo:default"
    end
  end

  describe "default values" do
    it "chef_ruby" do
      recipe.fetch(:chef_ruby).must_equal "default"
    end

    it "chef_gemset" do
      recipe.fetch(:chef_gemset).must_equal "global"
    end

    it "chef_solo_config" do
      recipe.fetch(:chef_solo_config).must_equal ".chef/solo.rb"
    end

    it "chef_node_config" do
      recipe.fetch(:chef_node_config).must_equal ".chef/node.json"
    end

    it "sets chef_deploy_to" do
      recipe.fetch(:chef_deploy_to).must_equal "/etc/chef"
    end
  end
end

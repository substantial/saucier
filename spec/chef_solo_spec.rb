require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Capistrano::Backerman::ChefSolo do
  load_capistrano_recipe(Capistrano::Backerman::ChefSolo)

  describe "tasks" do
    it "has chef:install" do
      recipe.must_have_task "chef_solo:install"
    end

    it "has chef:default" do
      recipe.must_have_task "chef_solo:default"
    end

    it "has deploy:set_ownership" do
      recipe.must_have_task "deploy:set_ownership"
    end
  end

  describe "default values" do
    it "default_ruby" do
      recipe.fetch(:default_ruby).must_equal "default"
    end

    it "gemset" do
      recipe.fetch(:gemset).must_equal "global"
    end

    it "chef_solo_config" do
      recipe.fetch(:chef_solo_config).must_equal ".chef/solo.rb"
    end

    it "chef_node_config" do
      recipe.fetch(:chef_node_config).must_equal ".chef/node.json"
    end
  end

  describe "callbacks" do
    it "runs chef-librarian before chef-solo" do
      recipe.must_have_callback_before "chef_solo:install", "chef_librarian:install"
    end

    it "sets deploy_to ownership after deploy:setup" do
      recipe.must_have_callback_after "deploy:setup", "deploy:set_ownership"
    end
  end
end

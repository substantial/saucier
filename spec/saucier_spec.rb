require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe Capistrano::Saucier do
  load_capistrano_recipe(Capistrano::Saucier)

  describe "variables" do
    it "has a chef_deploy_to" do
      recipe.fetch(:chef_deploy_to).must_equal "/etc/chef"
    end

    it "sets deploy_to to the chef_deploy_to" do
      recipe.fetch(:deploy_to).must_equal recipe.fetch(:chef_deploy_to)
    end
  end

  describe "tasks" do
    it "sets ownership" do
      recipe.must_have_task "provision:set_ownership"
    end

    it "has a task for bundle install" do
      recipe.must_have_task "provision:bundle_install"
    end

    it "has a task for symlinking cookbooks" do
      recipe.must_have_task "provision:symlink_cookbooks"
    end

    it "has a setup task" do
      recipe.must_have_task "provision:setup"
    end
  end

  describe "callbacks" do
    it "bundle installs after update code" do
      recipe.must_have_callback_after "deploy:update_code", "provision:bundle_install"
    end

    it "sets ownership after setup" do
      recipe.must_have_callback_after "deploy:setup", "provision:set_ownership"
    end
  end
end

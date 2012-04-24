require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Capistrano::CapSousChef::ChefLibrarian do
  load_capistrano_recipe(Capistrano::CapSousChef::ChefLibrarian)

  describe "tasks" do
    it "has :install" do
      recipe.must_have_task "chef_librarian:install"
    end

    it "has :default" do
      recipe.must_have_task "chef_librarian:default"
    end
  end

  describe "default values" do
    it "chef_ruby is 'default'" do
      subject.fetch(:chef_ruby).must_equal "default"
    end

    it "chef_gemset is 'global'" do
      subject.fetch(:chef_gemset).must_equal "global"
    end
  end

  describe "task :install" do
    let(:install_command) {
      command = []
      command << ". /etc/profile.d/rvm.sh"
      command << "cd current/release/path"
      command << "rvm use default@global"
      command << "bundle exec librarian-chef install"
      command.join(" && ")
    }
    before do
      recipe.set(:current_release) { 'current/release/path' }
      recipe.find_and_execute_task("chef_librarian:install")
    end

    it "runs librarian-chef install" do
      recipe.must_have_run install_command
    end
  end
end

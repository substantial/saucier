# backerman

  backerman is a Capistrano Extension that uses [librarian](https://github.com/applicationsonline/librarian.git "chef-librarian")
and [chef-solo](https://github.com/opscode/chef "chef") to manage project dependencies and provision servers for your project.

Use Capistrano Multistage to manage your servers and environments.

Use with [cap-strap](https://github.com/substantial/cap-strap "cap-strap") to bootstrap new servers.

## Installation

Add this line to your application's Gemfile:

    gem 'backerman'

And then execute:

    $ bundle

## Usage
  Make sure your project has a Cheffile with required chef cookbooks.

###Configuration:

* `set :default_ruby, "<ruby version you'd like to run>"` - default: "default"
* `set :gemset, "<gemset for your project>"` - default: "global"
* `set :deploy_to, "<set path for deploying chef-solo>"` - default: "/etc/chef"
* `set :user, "<user that will be executing chef-solo>"` - default: "deploy"
* `set :group, "<group for deploy user. keep as rvm if using rvm>"` - default: "rvm"
* `set :chef_solo_config, "<relative path to the chef solo config>"` - default ".chef/solo.rb"
* `set :chef_node_config, "<relative path to your node config>"` - default ".chef/node.json"

## Testing

 We're https://github.com/fnichol/minitest-capistrano for testing the capistrano
configuration.

Running Tests:

* `rake test` - manually run the tests
* `bundle exec guard start` - Use guard to watch for changes and run tests automatically.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

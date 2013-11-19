require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/wraith'

Hoe.plugin :newgem
# Hoe.plugin :website
# Hoe.plugin :cucumberfeatures

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.spec 'wraith' do
  self.developer 'Philipp Bergsmann', 'p.bergsmann@opendo.at'
  self.post_install_message = 'PostInstall.txt' # TODO remove if post-install message not required
  self.rubyforge_name       = self.name # TODO this is default value
  self.extra_deps         = [['image_size','>= 1.1.3'], ['pry','>= 0.9.12.2'], ['anemone', '0.7.2'], ['robotex', '>= 1.0.0']]
  self.urls = ["http://google.com"]
  self.version = "0.0.7"
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }

# TODO - want other tests/tasks run by default? Add them to the list
# remove_task :default
# task :default => [:spec, :features]

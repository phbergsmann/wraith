require 'optparse'
require File.expand_path(File.dirname(__FILE__) + "/../../lib/wraith/wraith_manager")
require File.expand_path(File.dirname(__FILE__) + "/../../lib/wraith/wraith")

module Wraith
  class CLI
    def self.execute(stdout, arguments=[])

      # NOTE: the option -p/--path= is given as an example, and should be replaced in your application.

      options = {
        :config     => 'configs/config.yaml'
      }
      mandatory_options = %w(  )

      parser = OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /,'')
          This application is wonderful because...

          Usage: #{File.basename($0)} [options]

          Options are:
        BANNER
        opts.separator ""
        opts.on("-c", "--config CONFIG", String,
                "Path to the configuration-file",
                "Default: configs/config.yaml") { |arg| options[:config] = arg }
        opts.parse!(arguments)

        if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
          stdout.puts opts; exit
        end
      end

      @wraith_manager = WraithManager.new(options[:config])
      @wraith_manager.reset_shots_folder
      @wraith_manager.check_for_paths
      @wraith_manager.save_images
      @wraith_manager.crop_images
      @wraith_manager.compare_images
      @wraith_manager.generate_thumbnails

      exec "ruby #{File.dirname(__FILE__)}/../../create_gallery.rb #{File.expand_path(Dir.pwd + "/" + @wraith_manager.directory)}"
    end
  end
end
require "yaml"
module Wraith
  class Wraith
    attr_accessor :config

    def initialize(config_name)
      @config = YAML::load(File.open("#{config_name}"))
    end

    def directory
      @config['directory'].first
    end

    def snap_file
      @config['snap_file'] ? @config['snap_file'] : File.expand_path(File.dirname(__FILE__) + "/../../snap.js")
    end

    def widths
      @config['screen_widths']
    end

    def domains
      @config['domains']
    end

    def base_domain
      domains[base_domain_label]
    end

    def comp_domain
      domains[comp_domain_label]
    end

    def base_domain_label
      domains.keys[0]
    end

    def comp_domain_label
      domains.keys[1]
    end

    def spider_days
      @config['spider_days']
    end

    def paths
      @config['paths']
    end

    def engine
      @config['browser']
    end

    def capture_page_image (browser, url, width, file_name)
      puts `"#{browser}" #{@config['phantomjs_options']} "#{snap_file}" "#{url}" "#{width}" "#{file_name}"`
    end

    def compare_images (base, compare, output, info)
      puts `compare -fuzz 20% -metric AE -highlight-color blue #{base} #{compare} #{output} 2>#{info}`
    end

    def self.crop_images (crop, height)
      #For compatibility with windows file structures switch commenting on the following 2 lines
      puts `convert #{crop} -background none -extent 0x#{height} #{crop}`
      #puts `convert #{crop.gsub('/', '\\')} -background none -extent 0x#{height} #{crop.gsub('/', '\\')}`
    end

    def crop_images(crop, height)
      self.class.crop_images
    end

    def self.thumbnail_image(png_path, output_path)
      #For compatibility with windows file structures switch commenting on the following 2 lines
      `convert #{png_path} -thumbnail 200 -crop 200x200+0+0 #{output_path}`
      #`convert #{png_path.gsub('/', '\\')} -thumbnail 200 -crop 200x200+0+0 #{output_path}`
    end
  end
end
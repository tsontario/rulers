# frozen_string_literal: true

require_relative "rulers/version"
require_relative "rulers/utils"
require_relative "rulers/app"
require_relative "rulers/controller"
require_relative "rulers/file_model"
require_relative "rulers/config"

class Object
  class << self
    alias_method(:original_const_missing, :const_missing)
    def const_missing(c)
      require Rulers.to_underscore(c.to_s)
      const_get(c)
    rescue NameError, LoadError
      original_const_missing(c)
    end
  end
end

module Rulers
  extend Utils
  class Error < StandardError; end

  # #config yields a free form config object to allow setting arbitrary
  # configuration values to be consumed by the application
  def self.config
    @config ||= Config.new
    if block_given?
      @config.tap do |c|
        yield c
      end
    else
      @config
    end
  end
end

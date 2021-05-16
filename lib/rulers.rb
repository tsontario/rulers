# frozen_string_literal: true

require_relative "rulers/version"
require_relative "rulers/utils"
require_relative "rulers/app"
require_relative "rulers/controller"
require_relative "rulers/file_model"

class Object
  def self.const_missing(c)
    require Rulers.to_underscore(c.to_s)
    const_get(c)
  end
end

module Rulers
  extend Utils
  class Error < StandardError; end
end

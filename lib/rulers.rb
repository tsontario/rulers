# frozen_string_literal: true

require_relative "rulers/version"

class Object
  def self.const_missing(c)
    require Rulers.to_underscore(c.to_s)
    const_get(c)
  end
end

module Rulers
  class Error < StandardError; end

  # TODO: add test
  def self.to_underscore(s)
    s.gsub(
      /([A-Z]+)([A-Z][a-z])/,
      '\1_\2'
    ).gsub(
      /([a-z\d])([A-Z])/,
      '\1_\2'
    ).downcase
  end

  class Controller
    attr_reader(:env)

    def initialize(env)
      @env = env
    end
  end

  class App
    def call(env)
      klass, action = controller_and_action(env)
      # Forward action to target class. TODO: proper router so callers can't trigger arbitrary controller methods
      text = klass.new(env).send(action)
      [
        200,
        { "Content-Type" => "text/html" },
        [text]
      ]
    end

    private

    def controller_and_action(env)
      _, controller, action, after = env["PATH_INFO"].split("/")
      controller_class = Object.const_get("#{controller&.capitalize}Controller")
      [ controller_class, action]
    end
  end
end

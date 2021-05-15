# frozen_string_literal: true

require_relative "rulers/version"

module Rulers
  class Error < StandardError; end
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

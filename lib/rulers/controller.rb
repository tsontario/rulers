# frozen_string_literal: true
require "erb"

module Rulers
  class Controller
    attr_reader(:env)

    def initialize(env)
      @env = env
    end

    def request
      @request ||= Rack::Request.new(env)
    end

    def params
      request.params
    end

    # default binding is that of the caller
    def render(name, b = binding())
      template = "app/views/#{name}.html.erb"
      e = ERB.new(File.read(template))
      e.result(b)
    end
  end
end

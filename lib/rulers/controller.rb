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

    def render(view, b = binding())
      template = File.expand_path("app/views/#{controller_name}/#{view}.html.erb", Rulers.config.root)
      e = ERB.new(File.read(template))
      e.result(b)
    end

    private

    def controller_name
      Utils.to_underscore(self.class.name).delete_suffix("_controller")
    end
  end
end

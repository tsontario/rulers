# frozen_string_literal: true

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

    def render(view, locals = {})
      template = File.expand_path("app/views/#{controller_name}/#{view}.html.erb", Rulers.config.root)
      e = Erubis::Eruby.new(File.read(template))
      e.result(locals.merge(env: env))
    end

    private

    def controller_name
      Utils.to_underscore(self.class.name).delete_suffix("_controller")
    end
  end
end

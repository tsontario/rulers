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
      ivar_mapping = instance_variables.each_with_object({}) do |ivar, acc|
        acc[ivar] = instance_variable_get(ivar.to_sym)
      end
      locals.merge!(ivar_mapping)
      template = File.expand_path("app/views/#{controller_name}/#{view}.html.erb", Rulers.config.root)
      e = Erubis::Eruby.new(File.read(template))
      e.result(locals)
    end

    private

    def controller_name
      Utils.to_underscore(self.class.name).delete_suffix("_controller")
    end
  end
end

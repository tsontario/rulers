# frozen_string_literal: true
module Rulers
  class App
    def call(env)
      klass, action = controller_and_action(env)
      # Forward action to target class. TODO: proper router so callers can't trigger arbitrary controller methods
      text = klass.new(env).send(action)
      [
        200,
        { "Content-Type" => "text/html" },
        [text],
      ]
    end

    private

    def controller_and_action(env)
      _, controller, action, _after = env["PATH_INFO"].split("/")
      controller_class = Object.const_get("#{controller&.capitalize}Controller")
      [controller_class, action]
    end
  end
end

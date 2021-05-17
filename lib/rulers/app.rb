# frozen_string_literal: true
module Rulers
  class App
    def call(env)
      return favicon_404 if env["PATH_INFO"] == "/favicon.ico"
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

    def favicon_404
      [
        404,
        { "Content-Type" => "text/html" },
        [],
      ]
    end
  end
end

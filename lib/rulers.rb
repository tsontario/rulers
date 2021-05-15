# frozen_string_literal: true

require_relative "rulers/version"

module Rulers
  class Error < StandardError; end
  class App
    def call(env)
      [
        200,
        { "Content-Type" => "text/html" },
        ["Hello from Rulers"]
      ]
    end
  end
end

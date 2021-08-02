# frozen_string_literal: true

require_relative "test/dummy_app/config/dummy_app"

Rulers.config do |c|
  c.root = File.expand_path("./test/dummy_app", __dir__)
end
run DummyApp::App.new

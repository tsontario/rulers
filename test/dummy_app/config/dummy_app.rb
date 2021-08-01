# frozen_string_literal: true
require "rulers"
$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "app", "controllers")

module DummyApp
  class App < ::Rulers::App
  end
end

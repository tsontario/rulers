# frozen_string_literal: true
$LOAD_PATH.unshift(File.expand_path("./dummy_app/config", __dir__))
require "dummy_app"
$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require "rulers"
require "rack/test"

require "minitest/autorun"
require "byebug"

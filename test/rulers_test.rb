# frozen_string_literal: true

require "test_helper"

class RulersTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Rulers::VERSION
  end

  def test_app_returns_success
    env = { "PATH_INFO" => "/", "QUERY_STRING" => "" }
    assert_equal(200, ::Rulers::App.new.call(env)[0])
  end
end

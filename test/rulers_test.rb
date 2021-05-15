# frozen_string_literal: true

require "test_helper"

class TedController < Rulers::Controller
  def think
    "Whoah, man..."
  end
end

class RulersTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Rulers::VERSION
  end

  def test_new_controller_action
    env = { "PATH_INFO" => "/ted/think", "QUERY_STRING" => "" }
    assert_equal(200, ::Rulers::App.new.call(env)[0])
    assert_equal([TedController.new(nil).think], ::Rulers::App.new.call(env)[2])
  end
end

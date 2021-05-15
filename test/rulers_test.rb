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

  def test_to_underscore
    assert_equal("foo", Rulers.to_underscore("foo"))
    assert_equal("foo", Rulers.to_underscore("FOO"))
    assert_equal("foo_bar", Rulers.to_underscore("FooBar"))
    assert_equal("foo_bar", Rulers.to_underscore("FOOBar"))
    assert_equal("with2_numbers", Rulers.to_underscore("With2Numbers"))
  end

  def test_autorequire
    assert_raises(LoadError) { TestController }
    path = File.expand_path("fixtures/requires", __dir__)
    $LOAD_PATH << path
    assert(TestController)
  end
end

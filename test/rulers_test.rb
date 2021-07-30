# frozen_string_literal: true

require "test_helper"

class TedController < Rulers::Controller
  def think
    "Whoah, man..."
  end
end

class TestApp < Rulers::App
  def call(_env)
    [
      200,
      { "Content-Type" => "text/html" },
      ["OK"],
    ]
  end
end

class RulersTest < Minitest::Test
  include Rack::Test::Methods

  def test_that_it_has_a_version_number
    refute_nil(::Rulers::VERSION)
  end

  def test_request
    get("/")
    assert(last_response.ok?)
    body = last_response.body
    assert_equal(body, "OK")
  end

  def test_favicon_request_returns_404
    env = { "PATH_INFO" => "/favicon.ico" }
    assert_equal(404, ::Rulers::App.new.call(env)[0])
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
    assert_raises(NameError) { TestController }
    path = File.expand_path("fixtures/requires", __dir__)
    $LOAD_PATH << path
    assert(TestController)
  end

  private

  def app
    TestApp.new
  end
end

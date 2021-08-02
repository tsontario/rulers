# frozen_string_literal: true

require "test_helper"

class RulersTest < Minitest::Test
  include Rack::Test::Methods

  def test_that_it_has_a_version_number
    refute_nil(::Rulers::VERSION)
  end

  def test_request
    get("/root/index")
    assert(last_response.ok?)
    body = last_response.body
    assert_equal(body, "OK")
  end

  def test_favicon_request_returns_404
    get("/favicon.ico")
    assert(last_response.not_found?)
  end

  def test_new_controller_action
    get("/quotes/a_quote")
    assert(last_response.ok?)
    body = last_response.body
    assert_equal(body, QuotesController.new(nil).a_quote)
  end

  def test_to_underscore
    assert_equal("foo", Rulers.to_underscore("foo"))
    assert_equal("foo", Rulers.to_underscore("FOO"))
    assert_equal("foo_bar", Rulers.to_underscore("FooBar"))
    assert_equal("foo_bar", Rulers.to_underscore("FOOBar"))
    assert_equal("with2_numbers", Rulers.to_underscore("With2Numbers"))
  end

  def test_autorequire
    assert_raises(NameError) { FixtureTestController }
    path = File.expand_path("fixtures/requires", __dir__)
    $LOAD_PATH.unshift(path)
    assert(FixtureTestController)
  ensure
    $LOAD_PATH.shift
  end

  def test_render
    get("/quotes/shakes")
    assert(last_response.ok?)
    body = last_response.body
    assert_equal(body, "There is nothing either good or bad but winking makes it so.\n")
  end

  def test_render_passes_instance_variables
    get("/quotes/shakes_with_instance_var")
    assert(last_response.ok?)
    body = last_response.body
    assert_equal(body, "There is nothing either good or bad but sneaking makes it so.\n")
  end

  private

  def app
    app = DummyApp::App.new
    Rulers.config do |c|
      c.root = File.expand_path("./dummy_app", __dir__)
    end
    app
  end
end

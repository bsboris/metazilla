require "minitest_helper"

class MockController < Struct.new(:action_name, :controller_path)
  attr_accessor :view_assigns

  def initialize
    @view_assigns = {}
  end
end

class ActionView::TestCase
  include Metazilla::ViewHelper
end

class ViewHelperTest < ActionView::TestCase
  def setup
    super
    @controller = MockController.new
  end

  def set_path(controller = nil, action = nil)
    @controller.controller_path = controller
    @controller.action_name = action
  end

  def assign_variable(name, value)
    @controller.view_assigns[name] = value
  end

  def test_set_title
    assert_equal "Page", title("Page")
  end

  def test_get_title
    title "Page"

    assert_equal "Page", title
  end

  def test_set_app_title
    assert_equal "App", app_title("App")
  end

  def test_get_app_title
    app_title "App"

    assert_equal "App", app_title
  end

  def test_full_title
    title "Page"
    app_title "App"

    assert_equal "Page | App", full_title
  end

  def test_title_tag
    title "Page"
    app_title "App"

    assert_equal "<title>Page | App</title>", title_tag
  end

  def test_loads_translations
    set_path "posts", "index"

    assert_equal "Posts list | My app", full_title
  end

  def test_loads_translations_with_namespace
    set_path "admin/web/posts", "index"

    assert_equal "My web admin app", app_title
  end

  def test_translation_cascades
    set_path "missing/missing/posts", "index"

    assert_equal "My app", app_title
  end

  def test_overrides_loaded_translations
    set_path "posts", "index"
    title "New Title"
    app_title "New App Title"

    assert_equal "New Title | New App Title", full_title
  end

  def test_translations_with_view_assigns
    set_path "posts", "show"
    assign_variable "post", "My post"

    assert_equal "Post My post", title
  end

  def test_set_meta
    assert_equal "Test", meta(:description, "Test")
  end

  def test_get_meta
    meta :description, "Test"

    assert_equal "Test", meta(:description)
  end

  def test_meta_tag
    meta :description, "Test"

    assert_equal %{<meta name="description" content="Test" />}, meta_tag(:description)
  end

  def test_loads_translated_meta
    set_path "posts", "index"

    assert_equal "My posts list.", meta(:description)
  end

  def test_custom_title_separator_via_config
    Metazilla.configure { |c| c.separator = " > " }
    set_path "posts", "index"

    assert_equal "Posts list > My app", full_title
  end

  def test_custom_title_separator_via_argument
    set_path "posts", "index"

    assert_equal "Posts list > My app", full_title(" > ")
  end

  def test_lookup_for_mapped_actions
    set_path "posts", "create"

    assert_equal "New post", title
  end

  def test_lookup_for_custom_mapped_actions
    Metazilla.configure { |c| c.mapping[:test] = :new }
    set_path "posts", "test"

    assert_equal "New post", title
  end

  def test_fallbacks_silently
    set_path "missing", "nothere"

    assert_equal "My app", full_title
  end
end

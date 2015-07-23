require "minitest_helper"

class TranslatorTest < Minitest::Test
  def translator(*args)
    Metazilla::Translator.new(*args)
  end

  def test_initialize
    t = translator("admin/main", "index")

    assert_equal ["admin"], t.namespace
    assert_equal "main", t.controller
    assert_equal "index", t.action
  end

  def test_initialize_with_nested_namespace
    t = translator("admin/web/main", "index")

    assert_equal %w(admin web), t.namespace
  end

  def test_simple_lookup
    t = translator("posts", "index")

    assert_equal "My app", t.lookup(:app)
  end

  def test_lookup_with_namespace
    t = translator("admin/posts", "index")

    assert_equal "My admin app", t.lookup(:app)
  end

  def test_lookup_with_deep_namespace
    t = translator("admin/web/posts", "index")

    assert_equal "My web admin app", t.lookup(:app)
  end

  def test_lookup_with_namespace_fallback
    t = translator("admin2/posts", "index")

    assert_equal "My app", t.lookup(:app)
  end

  def test_lookup_with_deep_namespace_fallback
    t = translator("admin/web2/posts", "index")

    assert_equal "My admin app", t.lookup(:app)
  end

  def test_lookup_with_deep_namespace_fallback_to_the_root
    t = translator("admin2/web2/posts", "index")

    assert_equal "My app", t.lookup(:app)
  end

  def test_lookup_for_current_path
    assert_equal "Posts list", translator("posts", "index").lookup_for_current_path(:title)
  end

  def test_lookup_for_current_path_fallback
    assert_equal "Users", translator("users", "index").lookup_for_current_path(:title)
  end

  def test_lookup_for_current_path_with_namespace
    assert_equal "Admin posts list", translator("admin/posts", "index").lookup_for_current_path(:title)
  end

  def test_lookup_for_current_path_with_namespace_fallback
    assert_equal "Admin users", translator("admin/users", "index").lookup_for_current_path(:title)
  end

  def test_lookup_for_mapped_actions
    assert_equal "New post", translator("posts", "create").lookup_for_current_path(:title)
  end

  def test_lookup_for_custom_mapped_actions
    Metazilla.configure { |c| c.mapping[:test] = :new }
    assert_equal "New post", translator("posts", "test").lookup_for_current_path(:title)
  end
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "metazilla"

require "minitest/autorun"

class Minitest::Test
  def setup
    I18n.load_path = [File.join(File.dirname(__FILE__), "en.yml")]
    I18n.reload!
  end
end

ActiveSupport.test_order = :sorted

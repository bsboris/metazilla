$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "metazilla"

require "minitest/autorun"

ActiveSupport.test_order = :sorted

class Minitest::Test
  def setup
    I18n.load_path = [File.join(File.dirname(__FILE__), "en.yml")]
    I18n.reload!
    Metazilla.reset_configuration
  end
end

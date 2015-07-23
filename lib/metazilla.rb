require "action_view"
require "metazilla/version"
require "metazilla/view_helper"

module Metazilla
  def self.configure
    yield(configuration) if block_given?
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset_configuration
    @configuration = Configuration.new
  end

  class Configuration
    attr_accessor :separator, :mapping

    def initialize
      @separator = ' | '
      @mapping = { create: :new, update: :edit }
    end
  end
end

ActionView::Base.send :include, Metazilla::ViewHelper

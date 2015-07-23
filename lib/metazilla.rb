require "action_view"
require "metazilla/version"
require "metazilla/view_helper"

module Metazilla
end

ActionView::Base.send :include, Metazilla::ViewHelper

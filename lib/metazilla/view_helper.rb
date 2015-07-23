require "metazilla/translator"

module Metazilla
  module ViewHelper
    def title(value = nil)
      if value.present?
        _meta_store[:page_title] = value
      else
        _meta_store[:page_title] || _translator.lookup_for_current_path(:title)
      end
    end

    def app_title(value = nil)
      if value.present?
        _meta_store[:app_title] = value
      else
        _meta_store[:app_title] || _translator.lookup(:app)
      end
    end

    def title_tag
      content_tag :title, full_title
    end

    def full_title
      [title, app_title].flatten.compact.join(Metazilla.configuration.separator)
    end

    def meta(name, content = nil)
      if content.present?
        _meta_store[name] = content
      else
        _meta_store[name] || _translator.lookup_for_current_path(:"meta.#{name}")
      end
    end

    def meta_tag(name)
      tag :meta, name: name, content: meta(name)
    end

    private

    def _meta_store
      @_meta_store ||= {}
    end

    def _translator
      @_translator ||= Translator.new(controller_path, action_name, controller.view_assigns.symbolize_keys)
    end
  end
end

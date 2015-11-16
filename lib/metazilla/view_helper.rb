module Metazilla
  module ViewHelper
    def title(value = nil)
      if value.present?
        _meta_store[:page_title] = value
      else
        _meta_store[:page_title] || _meta_lookup("title")
      end
    end

    def app_title(value = nil)
      if value.present?
        _meta_store[:app_title] = value
      else
        _meta_store[:app_title] || _meta_lookup("application")
      end
    end

    def title_tag
      content_tag :title, full_title
    end

    def full_title
      [title, app_title].flatten.select { |i| i.present? }.join(Metazilla.configuration.separator)
    end

    def meta(name, content = nil)
      if content.present?
        _meta_store[name] = content
      else
        _meta_store[name] || _meta_lookup("meta_#{name}")
      end
    end

    def meta_tag(name)
      tag :meta, name: name, content: meta(name)
    end

    private

    def _meta_store
      @_meta_store ||= {}
    end

    def _meta_lookup(key)
      options = controller.view_assigns.symbolize_keys
      options[:cascade] = true
      options[:default] = ""
      mapped_action = (Metazilla.configuration.mapping[action_name.to_sym] || action_name)

      t [controller_path.split("/"), mapped_action, key].flatten.join("."), options
    end
  end
end

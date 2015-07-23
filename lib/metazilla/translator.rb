module Metazilla
  class Translator
    attr_reader :namespace, :controller, :action, :context

    def initialize(controller_path, action, context = {})
      @namespace, @controller = parse_namespace_and_controller(controller_path)
      @action = action.to_s.freeze
      @context = context
    end

    def lookup(key)
      lookup_recursively key, namespace
    end

    def lookup_for_current_path(key)
      lookup_recursively(key, [namespace, controller, mapped_action].flatten)
    end

    private

    def parse_namespace_and_controller(controller_path)
      parts = controller_path.to_s.split("/")
      if parts.size > 1
        [parts[0...-1], parts[-1]]
      else
        [[], parts[0]]
      end
    end

    def lookup_recursively(key, namespace)
      namespace.size.downto(0).each do |depth|
        result = lookup_in_namespace(key, namespace.first(depth))
        return result if result
      end
      nil
    end

    def mapped_action
      (Metazilla.configuration.mapping[action.to_sym] || action).to_s.freeze
    end

    def lookup_in_namespace(key, namespace = [])
      t_key = [namespace, key].flatten.compact.join('.')
      i18n_set?(t_key) ? I18n.t(t_key, context) : nil
    end

    def i18n_set?(key)
      I18n.t(key, raise: true) rescue false
    end
  end
end

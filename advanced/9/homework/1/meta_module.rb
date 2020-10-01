module MetaModule
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        @history ||= {}
        @history[name] ||= []
        @history[name] << value
      end
      define_method("#{name}_history".to_sym) { @history ? @history[name] : [] }
    end
  end

  def strong_attr_acessor(atr_name, attr_class)
    var_name = "@#{atr_name}".to_sym
    define_method(atr_name) { instance_variable_get(var_name) }
    define_method("#{atr_name}=") do |value|
      raise 'Error! Type mismatch' unless value.is_a?(attr_class)
      instance_variable_set(var_name, value)
    end
  end
end

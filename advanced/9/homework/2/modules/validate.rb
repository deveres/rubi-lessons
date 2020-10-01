module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :checks

    def validate(field, validation, option = nil)
      @checks ||= []
      @checks.push(field: field, validation: validation, option: option)
    end
  end

  module InstanceMethods
    def  validate!
      self.class.checks.each do |item|
        send item[:validation].to_sym, instance_variable_get("@#{item[:field]}".to_sym), item[:option]
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def presence(value, _options)
      raise 'Значение не может быть пустым' if value.empty?
    end

    def format(value, options)
      raise 'Неверный формат' if value !~ options
    end

    def type(value, options)
      raise 'Несоответствие класса' if value.is_a?(options)
    end
  end
end

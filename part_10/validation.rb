module Validation
  module ClassMethods
    attr_reader :validations

    def validate(attribute, validation_type, params = nil)
      @validations ||= []
      @validations << { attribute: attribute,
                        validation_type: validation_type,
                        params: params }
    end
  end

  module InstanceMethods
    NIL_VALUE = 'Пустое значение'.freeze
    NOT_VALID_TYPE = 'Неверный тип'.freeze
    NOT_VALID_FORMAT = 'Неверный формат'.freeze

    VALUE_FORMAT = /^[a-zа-яё\d]{3}\-?[a-zа-яё\d]{2}$/i.freeze

    def validate?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate_presence(value, _)
      raise NIL_VALUE if value.nil? || value == ''
    end

    def validate_format(value, format)
      raise NOT_VALID_FORMAT if value !~ format
    end

    def validate_type(value, validation_type)
      raise NOT_VALID_TYPE unless value.is_a?(validation_type)
    end

    def validate!
      self.class.validations.each do |validation|
        value = instance_variable_get("@#{validation[:attribute]}".to_sym)
        method_name = "validate_#{validation[:validation_type]}".to_sym
        send(method_name, value, validation[:params])
      end
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :prepend, InstanceMethods
  end
end

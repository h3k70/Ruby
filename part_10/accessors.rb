module Acсessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history_var = "@#{name}_history".to_sym

      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}_history".to_sym) { instance_variable_get(history_var) }

      define_method("#{name}=".to_sym) do |value|
        old_var = instance_variable_get(var_name)
        if old_var.nil?
          instance_variable_set(history_var, [])
        else
          instance_variable_get(history_var) << old_var
        end
        instance_variable_set(var_name, value)
      end
    end
  end

  def strong_attr_accessor(name, type)
    var_name = "@#{name}".to_sym

    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise TypeError unless value.is_a?(type)

      instance_variable_set(var_name, value)
    end
  end
end

# class Test
#   extend Acсessors
#
#   attr_accessor_with_history :a, :b
#   strong_attr_accessor :c, Integer
#
# end

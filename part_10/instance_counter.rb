module InstanceCounter
  module ClassMethods
    attr_accessor :instances
  end

  module InstanceMethods
    def initialize(*args)
      super
      register_instance
    end

    protected

    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :prepend, InstanceMethods
  end
end

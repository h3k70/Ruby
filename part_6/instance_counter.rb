module InstanceCounter

  module ClassMethods
    attr_accessor :instance
  end
  
  module InstanceMethods

    def initialize
      super
      self.class.send :register_instance
    end

    protected
    def register_instance
      self.class.instance ||= 0
      self.class.instance += 1
    end
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end

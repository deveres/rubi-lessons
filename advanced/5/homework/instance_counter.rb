module InstanceCounter
  def self.included(base)
    @@instances = 0
    base.extend ClassMethods  #автоподключение методов класса
    base.send :include, InstanceMethods   #автоподключение методов инстанса
  end

  module ClassMethods
    def instances
      @@instances
    end
  end

  module InstanceMethods
    def register_instance
      @@instances+=1
    end
  end
end

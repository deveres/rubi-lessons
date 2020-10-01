class Wagon
  include Vendor
  include InstanceCounter

  def initialize
    register_instance
  end
end

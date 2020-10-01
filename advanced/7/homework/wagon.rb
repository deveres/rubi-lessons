# frozen_string_literal: true

# Class wagon
class Wagon
  include Vendor
  include InstanceCounter

  def initialize
    register_instance
  end
end

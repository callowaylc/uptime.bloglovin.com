# christian@bloglovin
# Abstract representation of host

# requires #################################

require './lib/resources/resource'

# definition ###############################

class Host < Resource
  attr_accessor :address

  def add_service service, is_available:
    add_join resource: service, available: is_available
  end
end

# christian@bloglovin
# Abstract representation of host

# requires #################################

require './lib/resources/resource'

# definition ###############################

class Host < Resource
  attr_accessor :address

  def add_service service, is_available:
    add_resource resource: service,
                 available: is_available
  end
end

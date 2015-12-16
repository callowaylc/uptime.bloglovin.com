# christian@bloglovin
# Abstract representation of host

# requires #################################

require './lib/resources/resource'

# definition ###############################

class Host < Resource
  attr_accessor :address
end

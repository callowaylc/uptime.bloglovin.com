# christian@bloglovin
# Abstract representation of service

# requires #################################

require 'ostruct'
require './lib/resources/resource'


# definition ###############################

class Service < Resource
  attr_accessor :monitor, :hosts

  def add_host host, is_available: 
    add_resource resource: host,
                 available: is_available
  end
end

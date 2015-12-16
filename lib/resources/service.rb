# christian@bloglovin
# Abstract representation of service

# requires #################################

require 'ostruct'
require './lib/resources/resource'


# definition ###############################

class Service < Resource
  attr_accessor :monitor, :hosts

  def add_host host, available
    @joins << OpenStruct.new( host: host, available: available )
  end
end

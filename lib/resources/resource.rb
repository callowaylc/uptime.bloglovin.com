# christian@bloglovin
# Abstract representation of any resource that can be monitored, 
# such as hosts, services, et al

# requires #################################

# definition ###############################

class Resource
  attr_accessor :name
  attr_writer   :available

  def initialize
    @joins = [ ]
    @available = false
  end

  # question mark for boolean's sake
  def available?
    # if joins have been specified, we iterate through
    # join types and check each and everyone is available
    unless joins.empty? 
      # iterate through joins and check if all are available
      @joins.each do | join |
        return false unless join.available
      end

      true
    # otherwise, we can assume that joins have not specified; in
    # laymens, this means a host has been defined that doesnt have
    # services and vice versa. A typical use case here would be 
    # pingdom where only checks against a host are made
    else
      @available
    end
  end

  protected def add_join resource:, available:
    @joins << OpenStruct.new resource: resource, 
                             type: resource.class.downcase
                             available: available
  end
end

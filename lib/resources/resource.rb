# christian@bloglovin
# Abstract representation of any resource that can be monitored, 
# such as hosts, services, et al

# requires #################################

# definition ###############################

class Resource
  attr_accessor :name

  def initialize
    @joins = [ ]
  end

  # question mark for boolean's sake
  def available?
    # iterate through joins and check if all are available
    @joins.each do | join |
      return false unless join.available
    end

    true
  end
end

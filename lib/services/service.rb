# christian@bloglovin
# Abstract representation of service

# requires #################################

# definition ###############################

class Service
  attr_accessor :monitor, :host, :name, :status

  # Convenience method for determining status
  def up?
    status
  end
end
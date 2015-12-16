# christian@bloglovin
# Monitor abstraction of nagios service

# requires #################################

require './lib/monitors/uptime'

# definition ###############################

class Pingdom < Uptime::Monitor
  def services
    [ ]
  end
end

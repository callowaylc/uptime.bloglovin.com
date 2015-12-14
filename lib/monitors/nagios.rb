# christian@bloglovin
# Monitor abstraction of nagios service

# requires #################################

require './lib/monitors/uptime'

# definition ###############################

class Nagios < Uptime::Monitor
end
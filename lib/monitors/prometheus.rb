# christian@bloglovin
# Monitor abstraction of prometheus service

# requires #################################

require './lib/monitors/uptime'

# definition ###############################

class Prometheus < Uptime::Monitor
end
# christian@bloglovin
# Defines async rufus job for uptime application; responsible
# for query against monitor sources and sending event data to
# uptime client

# requires #################################

require './lib/common/bootstrap'
require './lib/monitors/uptime'
require 'logger'

# scheduler ################################

SCHEDULER.every '10s' do | job |
  include Uptime

  monitors.each do | monitor |
    monitor.hosts.each do | resource |
      send_event id( monitor, resource ), { 
        value: resource.available? 
      }
    end
  end
end

private def id monitor, resource
  monitor.class.to_s.downcase  + "-" +
  resource.class.to_s.downcase + "-" +
  resource.name
end

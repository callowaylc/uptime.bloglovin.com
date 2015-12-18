# christian@bloglovin
# Defines async rufus job for uptime application; responsible
# for query against monitor sources and sending event data to
# uptime client

# requires #################################

require './lib/common/bootstrap'
require './lib/monitors/uptime'
require 'logger'

# scheduler ################################

SCHEDULER.every '2s' do | job |
  include Uptime

  monitors.each do | monitor |
    if %w{ PROMETHEUS NAGIOS }.include? monitor.class
      monitor.services.each do | service |
        send_event "#{ monitor.class }-service-#{ service.name }", { 
          value: service.available? 
        }
      end
    end
  end
end

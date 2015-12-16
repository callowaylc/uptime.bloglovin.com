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
    if monitor.kind_of? Prometheus
      monitor.services.each do | service |
        puts service.name
      end
    end
  end
end

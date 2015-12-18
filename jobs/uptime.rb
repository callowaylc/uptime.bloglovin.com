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
    if %w{ Nagios }.include?( monitor.class.to_s )
      puts monitor.class
      monitor.hosts.each do | host |
        puts "#{ host.name } health is #{ host.available? }"  
      #monitor.services.each do | service |
        #send_event "#{ monitor.class }-service-#{ service.name }", { 
        #  value: service.available? 
        #}
      end
    end
  end
end

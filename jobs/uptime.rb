# christian@bloglovin
# Defines async rufus job for uptime application; responsible
# for query against monitor sources and sending event data to
# uptime client

# requires #################################

require './lib/monitors/uptime'

# scheduler ################################

SCHEDULER.every '2s' do | job |
  include Uptime

  puts monitors
end
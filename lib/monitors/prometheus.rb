# christian@bloglovin
# Monitor abstraction of prometheus service

# requires #################################

require 'RestClient'
require './lib/monitors/uptime'

# definition ###############################

class Prometheus < Uptime::Monitor

  # On demand query against prometheus api for list of 
  # services; results are memoized
  def services
    @services ||= begin

    end
  end

  private def client
    @client = 
  end
end

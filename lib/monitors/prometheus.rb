# christian@bloglovin
# Monitor abstraction of prometheus service

# requires #################################

require 'RestClient'
require './lib/monitors/uptime'
require './lib/common/client'
require './lib/common/bootstrap'

# definition ###############################

class Prometheus < Uptime::Monitor
  # perhaps move this into
  API = ENV['PROMETHEUS_GATEWAY']

  # On demand query against prometheus api for list of 
  # services; results are memoized
  def services
    @services ||= begin
      # iterate through result set from /query?query=up
      # and group by job
      # TODO: determine if there is way to perform group by
      # at query level
      services = { }
      jobs.each do | job |
        services[name = job['metric']['job']] ||= [ ]
        services[name] << service_factory( 
          host: job['metric']['instance'],
          name: job['metric']['group'],
          status: job['value'][1] == '1'
        )
      end
    end
  end

  private def client
    @client ||= begin
      Client.new gateway:  API, 
                 username: ENV['USERNAME'], 
                 password: ENV['PASSWORD']
    end
  end

  private def jobs
    everything = client.get "/query", {
      query: 'up',
      time:  Time.now.getutc.to_i
    }
    everything['data']['result']
  end
end

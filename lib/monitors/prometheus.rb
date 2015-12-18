# christian@bloglovin
# Monitor abstraction of prometheus service

# requires #################################

require 'RestClient'
require './lib/monitors/uptime'
require './lib/common/client'
require './lib/common/bootstrap'

# definition ###############################

class Prometheus < Uptime::Monitor
  # On demand query against prometheus api for list of 
  # services; results are memoized
  def services
    @__services__ ||= begin
      # iterate through result set from /query?query=up
      # and group by job
      # TODO: determine if there is way to perform group by
      # at query level
      services = [ ]
      jobs.each do | job |
        # use factory methods to create or retrieve existing
        # instance
        host    = host_factory job['metric']['instance']
        service = service_factory job['metric']['job']

        # add host to service as a 'join' and specifiy wether the
        # service is available on said host
        service.add_host host, is_available: available?( job )
        services << service unless services.include?( service )
      end

      services
    end
  end

  private def jobs
    # query against prometheus api and retrieve up status against
    # all services
    everything = client.get "/query", {
      query: 'up',
      time:  Time.now.getutc.to_i
    }
    everything['data']['result']
  end

  private def available? attributes
    # determine if resource is available/up
    attributes['value'][1].eql?( '1' )
  end
end

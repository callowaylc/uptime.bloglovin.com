# christian@bloglovin
# Monitor abstraction of nagios service

# requires #################################

require './lib/monitors/uptime'

# definition ###############################

class Pingdom < Uptime::Monitor
  def hosts
    @__hosts__ ||= begin
      hosts = [ ]
      checks.each do | resource |
        host = host_factory resource['name']
        host.available = resource['status'].eql?( 'up' )

        hosts << host unless hosts.include?( host )
      end

      hosts
    end
  end

  private def checks
    # Retrieve all pingdom checks
    response = client.get '/checks', headers: {
      "app-key": access_key
    }
    response['checks']
  end 

  private def access_key
    ENV['ACCESS_KEY_PINGDOM']
  end 
end

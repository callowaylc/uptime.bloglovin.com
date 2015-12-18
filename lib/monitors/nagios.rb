# christian@bloglovin
# Monitor abstraction of nagios service

# requires #################################

require './lib/monitors/uptime'

# definition ###############################

class Nagios < Uptime::Monitor
  # retrieves hosts against nagios api and associated services
  def hosts
    @__hosts__ ||= begin
      everything.each do | host_name, host_attributes | 
        host = host_factory host_name

        # now grab all services attached to host
        host_attributes['services'].each do | service_name, service_attributes |
          service = service_factory service_name
          host.add_service service, 
                           is_available: available?( service_attributes )
        end
      end
    end
  end

  private def everything
    # nagios api dumps everything in a single request to /state,
    # and resulting dump takes the form of hosts1..n, and each
    # host containts servcies1..n
    ( client.get "/state" )['content']
  end

  private def available? attributes
    # determine, given hash and nagios convention, if resource
    # is available
    attributes['current_state']
  end
end
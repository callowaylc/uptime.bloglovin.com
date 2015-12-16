# christian@bloglovin
# Abstraction of a monitor, or data source for monitor; for
# example, a monitor could be prometheus, nagios, etc

# requires #################################

require './lib/resources/service'
require './lib/resources/host'

# definition ###############################

module Uptime

  # Retrieves list of defined monitors
  def monitors
    @monitors ||= begin
      monitors = [ ]
      Dir[File.dirname(__FILE__) + '/*.rb'].each do | path |
        unless path =~ /uptime.rb$/
          require path

          constant = Kernel::const_get( class_name path )
          monitors << constant.new
        end
      end

      monitors
    end
  end

  private def class_name path
    # Convert file path to basename and capatalize first character
    File.basename( path, '.rb' ).ucfirst
  end

  # Abstract definition of a monitor; provides interface to concrete
  # instances
  class Monitor
    attr_reader :hosts, :services

    def initialize
      @hosts = { }
      @services = { }
    end

    def service_factory name, options = { }
      @services[name] ||= begin
        resource_factory :service, name, options
      end
    end

    def host_factory name, options = { }
      @hosts[name] ||= begin
        resource_factory :host, name, options
      end
    end

    private def resource_factory resource, name, options
      # dynamically determine resource type, instantiate and
      # bind name value, which acts as primary key
      resource = Kernel::const_get resource.to_s.ucfirst
      resource = resource.new
      resource.name = name

      options.each do | key, value |
        resource.send( "#{key}=", value )
      end

      resource
    end

  end

end

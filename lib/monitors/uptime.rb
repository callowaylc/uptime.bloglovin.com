# christian@bloglovin
# Abstraction of a monitor, or data source for monitor; for
# example, a monitor could be prometheus, nagios, etc

# requires #################################

require './lib/services/service'

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
    File.basename( path, '.rb' ) .sub( /^\w/ ) { | c | c.capitalize }
  end

  # Abstract definition of a monitor; provides interface to concrete
  # instances
  class Monitor
    attr_reader :services

    def service_factory options={ }
      service = Service.new
      service.monitor = self
      
      # the passed options must be available as 
      # accessible attributes of service or an exception
      # will be thrown here
      # TODO: this isn't very clear which means there is a 
      # better solution
      options.each do | key, value |
        service.send( "#{key}=", value )
      end 

      service
    end

  end

end

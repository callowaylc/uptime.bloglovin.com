# christian@bloglovin
# Abstraction of a monitor, or data source for monitor; for
# example, a monitor could be prometheus, nagios, etc

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

  class Monitor

  end

end
# christian@bloglovin
# Simple adapter/facade for rest client to fit explicitly
# into the domain concepts of uptime application

# requires #################################

require 'RestClient'
require 'addressable/uri'

# definition ###############################

class Client
  def initialize gateway:, user:, password:

  end

  # Sends GET request to resource with given payload
  def get path, payload = { }
    # convert hash to uriencoded parameters
    @resource["#{ path }?#{ to_params payload }"].get
  end

  private def to_params hash
    # converts hash to http params
    uri = Addressable::URI.new
    uri.query_values = hash
    uri.query   
  end

end

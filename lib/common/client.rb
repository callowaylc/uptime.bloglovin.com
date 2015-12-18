# christian@bloglovin
# Simple adapter/facade for rest client to fit explicitly
# into the domain concepts of uptime application

# requires #################################

require 'RestClient'
require 'json'
require 'addressable/uri'

# definition ###############################

class Client
  def initialize( gateway:, username:, password:, headers: )
    @resource = begin
      RestClient::Resource.new(
        gateway, user: username, password: password, headers: headers
      )
    end
  end

  # Sends GET request to resource with given payload
  def get path, headers: { }, query: { }
    # convert hash to uriencoded parameters
    begin
      JSON.parse( @resource["#{ path }?#{ to_params query }"].get headers )
    end
  end

  private def to_params hash
    # converts hash to http params
    uri = Addressable::URI.new
    uri.query_values = hash
    uri.query   
  end

end

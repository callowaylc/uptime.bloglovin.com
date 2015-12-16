# christian@bloglovin
# Responsible for bootstrapping dependencies

# requires #################################

require 'dotenv'

# main #####################################

# bootstrap .env if it exists
Dotenv.load

# add ucfirst to string instances
class String
  def ucfirst
    self.sub( /^\w/ ) { | character | character.capitalize }
  end
end
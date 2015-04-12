require_relative 'skoope/client'
require_relative 'skoope/application'


module Skoope
  def self.start
    client = Client.new
    application = Application.new(client)

    # application.start
  end
end
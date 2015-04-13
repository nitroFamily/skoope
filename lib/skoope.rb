require_relative 'skoope/client'
require_relative 'skoope/application'


module Skoope
  def self.start
    client = Client.new(ARGV[0], ARGV[1]) # src_ip and dst_ip
    application = Application.new(client)

    Signal.trap('SIGINT') do
      application.stop
      client.close
    end

    application.start
  end
end
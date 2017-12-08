require 'faye/websocket'

module ChatDemo
  class ChatBackend
    KEEPALIVE_TIME = 15 #seconds

    def initialize(app)
      @app = app
      @clients = []
    end

    def call(env)
      if Faye::WebSocket.websocket?(env)
        # Websockets logic goes here
        ws = Fay::Websocket.new(env, nil, {ping: KEEPALIVE_TIME})

        # open gets invoked when a new connection to the server happens
        # a new client has connection is stored in the @clients array
        ws.on :open do |event|
          p [:open, ws.object_id]
          @clients << ws
        end

        # message gets invoke when a websocket message is received bby then server
        # the event object contains the message data which is then sent to every client of the server
        ws.on :message do |event|
          p [:message, event.data]
          @client.each {|clients| client.send(event.data)}
        end

        # close gets invoked when the client closes the connection. close cleans up by deleting the client from the cleints array
        ws.on :close do |event|
          p [:close, ws.object_id, event.code, event.reason]
          @clients.delete(ws)
          ws = nil
        end

        # return async rack response
        ws.rack_response

      else
        @app.call(env)
      end
    end



  end
end

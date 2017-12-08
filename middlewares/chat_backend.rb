require 'faye/websocket'

module ChatDemo
  class ChatBackend
    KEEPALIVE_TIME = 15 #seconds

    def intialize(app)
      @app = app
      @clients = []
    end

    def call(env)
      if Faye::WebSocket.websocket?(env)
        # Websockets logic goes here
        ws = Fay::Websocket.new(env, nil, {ping: KEEPALIVE_TIME})

        ws.on :open do |event|
          p [:open, ws.object_id]
          @clients << ws
        end

        ws.on :close do |event|
          p [:close, ws.object_id, event.code, event.reason]
          @clients.delete(ws)
          ws = nil
        # return async rack response
        ws.rack_response
        
      else
        @app.call(env)
      end
    end



  end
end

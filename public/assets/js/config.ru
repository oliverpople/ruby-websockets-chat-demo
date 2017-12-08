require './app'
require './middlewares/chat_backend'

# tells Rack and the server how to load the application
use ChatDemo::ChatBackend

run ChatDemo::App

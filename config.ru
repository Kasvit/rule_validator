require './lib/my_app'
require './lib/myrackmiddleware'
use Rack::Reloader
use MyRackMiddleware
run MyApp.new

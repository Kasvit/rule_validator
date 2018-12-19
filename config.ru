require './lib/my_app'
require './lib/myrackmiddleware'
require './lib/white_list_checker'
require './lib/config_load'
use Rack::Reloader
use MyRackMiddleware
run MyApp.new

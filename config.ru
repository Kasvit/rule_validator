Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |file| require file }
use Rack::Reloader
use RuleValidator
run MyApp.new

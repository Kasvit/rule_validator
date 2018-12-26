Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |file| require file }

use Rack::Reloader

use RuleValidator::Validator
use JwtValidator::Validator
use WhiteListValidator::Validator

run MyApp.new

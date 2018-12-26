Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |file| require file }

use Rack::Reloader

use RuleValidator
use JwtValidator::Validator
use WhiteListValidator::Validator

run MyApp.new

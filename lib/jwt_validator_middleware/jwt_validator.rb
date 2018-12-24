require_relative 'exceptions'
require 'jwt'

Dir[File.dirname(__FILE__) + '/algorithms/**/*.rb'].each { |file| require file }

class JwtValidator

  def initialize(app)
    @app = app

    @algorithm = ENV['ALGORITHM']
    @algorithm_params = { secret: ENV['SECRET'].freeze, alg: ENV['ALG'].freeze }
  end

  def call(env)
    @env = env
    status, header, body = @app.call(env)
    jwt_response = payload
    header['X-Auth-User'] = jwt_response.to_s if jwt_response
    [status, header, body]
  end

  private

  def token
    @env["HTTP_AUTHORIZATION"]&.gsub('Bearer ', '')
  end

  def payload
    algorithm_class.call(token, @algorithm_params)
  end

  def algorithm_class
    Object.const_get("#{@algorithm.capitalize}")
  rescue NameError
    raise Exceptions::InvalidAlgorithm, "invalid algorithm #{@algorithm.capitalize}"
  end
end

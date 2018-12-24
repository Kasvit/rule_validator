require 'jwt'
require_relative '../base_service'
require_relative '../exceptions'

class Hmac < BaseService

  class BaseHmacException < Exceptions::BaseException; end
  class InvalidHmacAlgorithm < BaseHmacException; end
  class MissingRequiredKey < BaseHmacException; end

  VALID_ALGORITHMS = %w[HS256].freeze
  VALID_KEYS = %i[secret alg].freeze

  def initialize(token, params)
    @token  = token
    @params = params
  end

  def call
    raise MissingRequiredKey, "missing keys: #{@params.keys}" unless required_keys_present?
    raise InvalidHmacAlgorithm, "invalid alg: #{@params[:alg]}" unless valid_algorithm?
    decode
  end

  private

  def valid_algorithm?
    VALID_ALGORITHMS.include?(@params[:alg])
  end

  def required_keys_present?
    (VALID_KEYS - @params.keys).empty?
  end

  def decode
    JWT.decode(@token, @params[:secret], true, algorythm: @params[:alg]).first
  rescue JWT::ExpiredSignature, JWT::DecodeError
    false
  end
end

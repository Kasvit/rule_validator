require 'jwt'
require_relative '../base_service'
require_relative '../exceptions'

module JwtValidatior
  module Algorithms
  class Rs256 < BaseService
    class Exceptions
      class BaseRs256Exception < JwtValidatior::Exceptions::BaseException; end
      class InvalidRs256Algorithm < BaseRs256Exception; end
      class MissingRequiredKey < BaseRs256Exception; end
    end

    VALID_ALGORITHMS = %w[RS256].freeze
    VALID_KEYS = %i[secret alg].freeze

    def initialize(token, params)
      @token = token
      @params = params
    end

    def call
      raise Exceptions::MissingRequiredKey, "missing keys: #{@params.keys}" unless required_keys_present?
      raise Exceptions::InvalidRs256Algorithm, "invalid alg: #{@params[:alg]}" unless valid_algorithm?
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
      JWT.decode(@token, @params[:secret], true, { algorithm: @params[:alg] }).first
    rescue JWT::ExpiredSignature, JWT::DecodeError
      false
    end
  end
  end
end

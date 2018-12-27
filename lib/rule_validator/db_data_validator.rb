require_relative 'storages/base_storage'
require_relative 'parsed_request'

module RuleValidator
  class DbDataValidator
    ALL_METHODS = ["GET", "PUT", "POST", "PATCH", "DELETE"].freeze
    ANY_METHOD  = '*'.freeze
    ALLOWED_ACTION = "allow".freeze

    attr_reader :storage

    def initialize(storage)
      @storage = storage
    end

    def valid?(parsed_request)
      @rule = @storage.find_rule(parsed_request.name)
      return false unless @rule
      allowed_action? && valid_method?(parsed_request) && valid_params?(parsed_request)
    end

    private

    def valid_params?(request)
       @rule[:params] == request.params
    end

    def valid_method?(request)
      rule = @rule[:methods] == ANY_METHOD ? ALL_METHODS : @rule[:methods]
      rule.include?(request.incoming_method)
    end

    def allowed_action?
      @rule[:action] == ALLOWED_ACTION
    end
  end
end

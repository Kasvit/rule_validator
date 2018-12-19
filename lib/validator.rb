require_relative '../lib/storages/base_storage'
require_relative 'parsed_request'

class Validator
  attr_reader :storage

  def initialize(storage)
    @storage = storage
  end

  def valid?(parsed_request)
    rule = @storage.find_rule(parsed_request.name)
    return false unless rule

    parsed_request.params == rule[:params]
  end
end

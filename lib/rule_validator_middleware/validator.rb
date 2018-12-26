require_relative 'storages/base_storage'
require_relative 'parsed_request'
class Validator
  attr_reader :storage

  def initialize(storage)
    @storage = storage
  end

  def valid?(parsed_request)
    @rule = @storage.find_rule(parsed_request.name)
    return false unless @rule
    valid_params?(parsed_request) &&  valid_method?(parsed_request) && allowed_action?
  end

  private

  def valid_params?(request)
     @rule[:params] == request.params
  end

  def valid_method?(request)
    all_methods = ["GET", "PUT", "POST", "PATCH", "DELETE"]
    rule = []
    if @rule[:methods] = "*"
      rule = all_methods
    else
      rule = @rule[:methods]
    end
    rule.include?(request.incoming_method)
  end

  def allowed_action?
    @rule[:action] == "allow"
  end
end

require_relative 'storages/rules_json_file_provider'
require_relative 'storages/rules_yaml_file_provider'
require_relative 'storages/rules_db_provider'
require_relative 'parsed_request'
require_relative 'validator'

class Storage

  attr_reader :access_rules

  def initialize(access_rules)
    @access_rules = access_rules
  end

  def find_rule(rule_name)
    @access_rules[rule_name.to_sym]
  end
end
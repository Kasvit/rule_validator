require 'yaml'
require_relative 'base_storage'
class YamlFileStorage < BaseStorage
  def initialize
    @rules = YAML.load_file('lib/storages/rules.yml')
  end

  def find_rule(rule_name)
    @rules[rule_name.to_sym]
  end
end

require_relative 'base_storage'

require 'yaml'

class YamlFileStorage < BaseStorage
  def initialize(file: 'config/yaml_db.yml')
    @rules = YAML.load_file(file)
  end

  def find_rule(rule_name)
    @rules[rule_name.to_sym]
  end
end

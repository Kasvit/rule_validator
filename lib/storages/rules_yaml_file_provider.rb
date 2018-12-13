require 'json'
require 'yaml'
class RulesYamlFileProvider
  def RulesYamlFileProvider.load(filename = 'lib/storages/rules.yml')
    JSON.parse(JSON.dump(YAML.load_file(filename)), symbolize_names: true)
  end
end
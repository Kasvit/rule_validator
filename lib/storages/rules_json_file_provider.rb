require 'json'
class RulesJsonFileProvider
  def RulesJsonFileProvider.load(filename = 'lib/storages/rules.json')
    JSON.parse(File.open(filename), symbolize_names: true)
  end
end
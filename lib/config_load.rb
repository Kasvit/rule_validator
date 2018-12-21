require 'yaml'
# ConfigLoad
class ConfigLoad
  def self.load_file(file)
    YAML.load_file(File.join(__dir__, file))
  end
end

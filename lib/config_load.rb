require 'yaml'

class ConfigLoad
  def self.load_file(path)
    YAML.load_file(File.join(__dir__, path))
  end
end

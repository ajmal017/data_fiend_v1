require 'yaml'

module YamlParser
  def self.read(key)
    hsh = YAML.load_file('server_wrapper_secrets.yml')
    hsh[key]
  end
end

require 'yaml'

module YamlFile
  def self.load(file_path)
    YAML.safe_load(File.read(file_path), [Statistic], [], true)
  end

  def self.save(file_path, object)
    File.open(file_path, 'w') { |file| file.write(object.to_yaml) }
  end
end

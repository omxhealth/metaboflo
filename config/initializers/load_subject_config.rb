raw_config = File.read(::Rails.root.to_s + "/config/subject_config.yml")
SUBJECT_CONFIG = YAML.load(raw_config).symbolize_keys

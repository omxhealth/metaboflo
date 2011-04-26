raw_config = File.read(RAILS_ROOT + "/config/subject_config.yml")
SUBJECT_CONFIG = YAML.load(raw_config).symbolize_keys

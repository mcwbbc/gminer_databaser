config = YAML::load(File.open(DAEMON_ROOT+'/config/database.yml'))[DAEMON_ENV]
ActiveRecord::Base.establish_connection(config)

# load db settings

mysql_config = YAML::load(File.open(DAEMON_ROOT+'/config/database.yml'))[DAEMON_ENV]
ActiveRecord::Base.establish_connection(mysql_config)

mongo_config = YAML::load(File.open(DAEMON_ROOT+'/config/mongoid.yml'))[DAEMON_ENV]
DB = Mongo::Connection.new.db(mongo_config['database'])
DB.collection('gminer_annotations').create_index('identifier', :unique => true)
DB.collection('gminer_annotation_closures').create_index('identifier', :unique => true)
DB.collection('gminer_ontology_terms').create_index('term_id', :unique => true)

require 'active_record'
require 'annotation'
require 'annotation_closure'
require 'ontology'
require 'ontology_term'

begin
  require 'amqp'
  require 'mq'
rescue LoadError
  $stderr.puts "Missing amqp gem. Please run 'gem install amqp'."
  exit 1
end

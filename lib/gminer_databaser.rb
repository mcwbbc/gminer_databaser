class GminerDatabaser

  DATABASER_QUEUE_NAME = 'gminer-databaser'

  def process(msg)
    message = JSON.parse(msg)
    case message['command']
      when 'saveterm'
        OntologyTerm.persist(message['term_id'], message['ncbo_id'], message['term_name'])
        Mongo::OntologyTerm.persist(DB, message['term_id'], message['ncbo_id'], message['term_name'])
      when 'saveannotation'
        Annotation.persist(message['geo_accession'], message['field_name'], message['ncbo_id'], message['ontology_term_id'], message['from'], message['to'], message['description'], message['mapping'], message['synonym'])
        Mongo::Annotation.persist(DB, message['geo_accession'], message['field_name'], message['ncbo_id'], message['ontology_term_id'], message['from'], message['to'], message['description'], message['mapping'], message['synonym'])
      when 'saveclosure'
        AnnotationClosure.persist(message['geo_accession'], message['field_name'], message['term_id'], message['closure_term'])
        Mongo::AnnotationClosure.persist(DB, message['geo_accession'], message['field_name'], message['term_id'], message['closure_term'])
    end
  end

end

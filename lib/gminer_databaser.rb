class GminerDatabaser

  DATABASER_QUEUE_NAME = 'gminer-databaser'

  def process(msg)
    message = JSON.parse(msg)
    case message['command']
      when 'saveterm'
        OntologyTerm.persist(message['term_id'], message['ncbo_id'], message['term_name'])
      when 'saveannotation'
        Annotation.persist(message['geo_accession'], message['field_name'], message['ncbo_id'], message['ontology_term_id'], message['text_start'], message['text_end'], message['description'])
      when 'saveclosure'
        AnnotationClosure.persist(message['geo_accession'], message['field_name'], message['term_id'], message['closure_term'])
    end
    DaemonKit.logger.debug("saving: #{message}")
  end

end

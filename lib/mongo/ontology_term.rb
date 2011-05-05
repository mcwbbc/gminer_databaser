module Mongo
  class OntologyTerm

    class << self
      def persist(db, term_id, ncbo_id, name)
        db.collection('gminer_ontology_terms').insert({:term_id => term_id, :ncbo_id => ncbo_id, :name => name})
      end
    end

  end
end
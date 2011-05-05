module Mongo
  class AnnotationClosure

    class << self
      def persist(db, geo_accession, field_name, term_id, closure_term_id)
        db.collection('gminer_annotation_closures').insert({:identifier => [geo_accession, field_name, term_id, closure_term_id].join("-"), :geo_accession => geo_accession, :field_name => field_name, :term_id => term_id, :closure_term_id => closure_term_id})
      end
    end

  end
end
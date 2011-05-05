module Mongo
  class Annotation

    class << self
      def persist(db, geo_accession, field_name, ncbo_id, term_id, text_start, text_end, description, mapping, synonym)
        db.collection('gminer_annotations').insert({:geo_accession => geo_accession, :identifier => [geo_accession, field_name, term_id].join("-"), :field_name => field_name, :ncbo_id => ncbo_id, :term_id => term_id, :from => text_start, :to => text_end, :description => description, :mapping => mapping, :synonym => synonym})
      end
    end

  end
end
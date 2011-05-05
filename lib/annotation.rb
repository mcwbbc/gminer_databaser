class Annotation < ActiveRecord::Base

  validates_uniqueness_of :ncbo_id, :scope => [:ontology_term_id, :geo_accession, :field_name]

  belongs_to :ontology_term, :counter_cache => true
  belongs_to :ontology
  has_many :annotation_closures #, :include => :ontology_term, :order => "ontology_terms.name"

  class << self
    def persist(geo_accession, field_name, ncbo_id, ontology_term_string, text_start, text_end, description, mapping, synonym)
      ontology_term = OntologyTerm.first(:conditions => {:term_id => ontology_term_string})
      if ontology_term && !annotation = Annotation.first(:conditions => {:geo_accession => geo_accession, :field_name => field_name, :ontology_term_id => ontology_term.id})
        Annotation.create(:geo_accession => geo_accession, :identifier => [geo_accession,field_name,ontology_term_string].join("-"), :field_name => field_name, :ncbo_id => ncbo_id, :term_id => ontology_term_string, :ontology_term_id => ontology_term.id, :ontology_id => ontology_term.ontology_id, :from => text_start, :to => text_end, :description => description, :mapping => mapping, :synonym => synonym)
      end
    end
  end

end

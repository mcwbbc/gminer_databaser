class OntologyTerm < ActiveRecord::Base

  belongs_to :ontology
  has_many :annotations, :order => :geo_accession#, :dependent => :destroy
  has_many :annotation_closures, :include => :annotation, :order => "annotations.geo_accession"#, :dependent => :destroy

  class << self
    def persist(term_id, ncbo_id, term_name)
      if !ot = OntologyTerm.first(:conditions => {:term_id => term_id})
        ontology = Ontology.first(:conditions => {:ncbo_id => ncbo_id})
        ot = ontology.ontology_terms.create(:term_id => term_id, :ncbo_id => ncbo_id, :name => term_name) if ontology
      end
    end
  end

end
class Ontology < ActiveRecord::Base

  has_many :ontology_terms, :order => "annotations_count DESC, name"
  has_many :annotations

end
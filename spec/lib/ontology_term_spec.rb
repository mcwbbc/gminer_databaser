require 'spec_helper'

describe OntologyTerm do

  describe "persist" do
    describe "with existing" do
      it "should not create" do
        ot = OntologyTerm.new
        OntologyTerm.should_receive(:first).with(:conditions => {:term_id => "term_id"}).and_return(ot)
        OntologyTerm.persist("term_id", "ncbo_id", "term_name").should == nil
      end
    end

    describe "without existing" do
      before(:each) do
        @ot = OntologyTerm.new
        OntologyTerm.should_receive(:first).with(:conditions => {:term_id => "term_id"}).and_return(nil)
      end

      describe "with matching ontology" do
        it "should create a new ontology_term" do
          ontology = Ontology.new
          Ontology.should_receive(:first).with(:conditions => {:ncbo_id => "ncbo_id"}).and_return(ontology)
          ontology_terms = mock("ontology_terms")
          ontology.should_receive(:ontology_terms).and_return(ontology_terms)
          ontology_terms.should_receive(:create).with(:term_id => "term_id", :ncbo_id => "ncbo_id", :name => "term_name").and_return(@ot)
          OntologyTerm.persist("term_id", "ncbo_id", "term_name").should == @ot
        end
      end

      describe "without matching ontology" do
        it "should not save anyting" do
          Ontology.should_receive(:first).with(:conditions => {:ncbo_id => "ncbo_id"}).and_return(nil)
          OntologyTerm.persist("term_id", "ncbo_id", "term_name").should be_nil
        end
      end
    end
  end

end
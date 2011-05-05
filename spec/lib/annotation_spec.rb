require 'spec_helper'

describe Annotation do
  describe "persist" do
    describe "without valid ontology term" do
      it "should not create a new annotation" do
        OntologyTerm.should_receive(:first).with(:conditions => {:term_id => "term"}).and_return(nil)
        Annotation.persist("GPL1234", "title", "ncbo_id", "term", "0", "10", "description", true, true).should == nil
      end
    end

    describe "with valid ontology term" do
      before(:each) do
        @ontology = Ontology.new(:id => 1)
        @ontology_term = OntologyTerm.new(:ontology_id => @ontology.id)
        OntologyTerm.should_receive(:first).with(:conditions => {:term_id => "term"}).and_return(@ontology_term)
      end

      describe "with existing annotation" do
        it "should not create a new annotation" do
          annotation = Annotation.new
          Annotation.should_receive(:first).with(:conditions => {:geo_accession => "GPL1234", :field_name => "title", :ontology_term_id => @ontology_term.id}).and_return(annotation)
          Annotation.persist("GPL1234", "title", "ncbo_id", "term", "0", "10", "description", true, false).should == nil
        end
      end

      describe "without existing annotation" do
        it "should create a new annotation" do
          annotation = Annotation.new
          Annotation.should_receive(:first).with(:conditions => {:geo_accession => "GPL1234", :field_name => "title", :ontology_term_id =>  @ontology_term.id}).and_return(nil)
          Annotation.should_receive(:create).with(:geo_accession=>"GPL1234", :identifier=>"GPL1234-title-term", :field_name=>"title", :ncbo_id=>"ncbo_id", :term_id=>"term", :ontology_term_id=>@ontology_term.id, :ontology_id=>@ontology.id, :from=>"0", :to=>"10", :description=>"description", :mapping=>true, :synonym=>false).and_return(annotation)
          Annotation.persist("GPL1234", "title", "ncbo_id", "term", "0", "10", "description", true, false).should == annotation
        end
      end
    end
  end
end

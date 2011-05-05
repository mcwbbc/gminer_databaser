require 'spec_helper'

describe AnnotationClosure do

  describe "persist" do

    describe "without term" do
      it "should return false" do
        OntologyTerm.should_receive(:first).with(:conditions => {:term_id => "term"}).and_return(nil)
        AnnotationClosure.persist("GPL1234", "title", "term", "closure term").should == nil
      end
    end

    describe "with term" do
      before(:each) do
        @ot = OntologyTerm.new(:id => 1)
        OntologyTerm.should_receive(:first).with(:conditions => {:term_id => "term"}).and_return(@ot)
        @annotations = mock("annotations")
        @ot.stub!(:annotations).and_return(@annotations)
      end

      describe "without annotation" do
        it "should skip creation" do
          @annotations.should_receive(:first).with(:conditions => {:geo_accession => "GPL1234", :field_name => "title"}).and_return(nil)
          AnnotationClosure.persist("GPL1234", "title", "term", "closure term").should == nil
        end
      end

      describe "with annotation" do
        before(:each) do
          @annotation = Annotation.new
          @annotations.should_receive(:first).with(:conditions => {:geo_accession => "GPL1234", :field_name => "title"}).and_return(@annotation)
          @closure_term = OntologyTerm.new(:id => 2)
          OntologyTerm.should_receive(:first).with(:conditions => {:term_id => "closure term"}).and_return(@closure_term)
          @annotation_closures = mock("annotation_closures")
          @annotation.stub!(:annotation_closures).and_return(@annotation_closures)
        end

        describe "with existing closure" do
          it "should not create" do
            existing_closure = mock(AnnotationClosure)
            @annotation_closures.should_receive(:first).with(:conditions => {:ontology_term_id => @closure_term.id}).and_return(existing_closure)
            AnnotationClosure.persist("GPL1234", "title", "term", "closure term").should == nil
          end
        end

        describe "without existing closure" do
          it "should create a new annotation closure" do
            new_closure = AnnotationClosure.new
            @annotation_closures.should_receive(:first).with(:conditions => {:ontology_term_id => @closure_term.id}).and_return(nil)
            @annotation_closures.should_receive(:create).with({:identifier=>"GPL1234-title-term-closure term", :geo_accession=>"GPL1234", :field_name=>"title", :term_id=>"term", :closure_term_id=>"closure term", :ontology_term_id=>@ot.id}).and_return(new_closure)
            AnnotationClosure.persist("GPL1234", "title", "term", "closure term").should == new_closure
          end
        end
      end
    end
  end
end
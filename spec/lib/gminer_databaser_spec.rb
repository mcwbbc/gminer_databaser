require 'spec_helper'

describe GminerDatabaser do

  describe "process" do
    before(:each) do
      @d = GminerDatabaser.new
    end

    it "should save the term" do
      @message = {'command' => 'saveterm'}
      JSON.should_receive(:parse).with(@message).and_return(@message)
      OntologyTerm.should_receive(:persist).and_return(true)
      @d.process(@message)
    end

    it "should save the annotation" do
      @message = {'command' => 'saveannotation'}
      JSON.should_receive(:parse).with(@message).and_return(@message)
      Annotation.should_receive(:persist).and_return(true)
      @d.process(@message)
    end

    it "should save the closure" do
      @message = {'command' => 'saveclosure'}
      JSON.should_receive(:parse).with(@message).and_return(@message)
      AnnotationClosure.should_receive(:persist).and_return(true)
      @d.process(@message)
    end
  end

end

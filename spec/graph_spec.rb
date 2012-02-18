require File.dirname(__FILE__) + '/spec_helper'

describe SixDegrees::Graph do
  context 'Given a hash of uni-directional 1st-order connections' do
    let(:oneway) do
      h = {:stephen => [:bob], :bob => [:alex]}
      h.default = []
      h
    end
    let(:twoway) do
      h = {
        :stephen => [:bob, :alex],
        :bob => [:stephen],
        :alex => [:stephen, :bob],
      }
      h.default = []
      h
    end

    it 'should ignore one way connections..' do
      bi = SixDegrees::Graph.simplify_parser oneway
      bi[0][:stephen].size.should eq 0
      bi[0][:bob].size.should eq 0
    end

    it 'should give me a hash exclusively of bi-directional 1st-order connections...' do
      bi = SixDegrees::Graph.simplify_parser twoway
      bi[0][:stephen].size.should eq 2
      bi[0][:bob].size.should eq 1
      bi[0][:alex].size.should eq 1
    end

    it 'should not disturb earlier iterations...' do 
      bi = SixDegrees::Graph.simplify_parser twoway
      it = SixDegrees::Graph.iterate(bi)
      bi[0][:stephen].size.should eq 2
      bi[0][:bob].size.should eq 1
      bi[0][:alex].size.should eq 1
 
    end
    it 'should generate successive levels of connections...' do 
      bi = SixDegrees::Graph.simplify_parser twoway
      it = SixDegrees::Graph.iterate(bi)
      bi[1][:stephen].size.should eq 0
      bi[1][:bob].size.should eq 1
      bi[1][:bob].should eq [:alex]
      bi[1][:alex].size.should eq 1
      bi[1][:alex].should eq [:bob]
 
    end
  end
end

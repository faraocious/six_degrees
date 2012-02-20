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
      bi[:stephen][0].size.should eq 0
      bi[:bob][0].size.should eq 0
    end

    it 'should give me a hash exclusively of bi-directional 1st-order connections...' do
      bi = SixDegrees::Graph.simplify_parser twoway
      bi[:stephen][0].size.should eq 2
      bi[:bob][0].size.should eq 1
      bi[:alex][0].size.should eq 1
    end

    it 'should not disturb earlier iterations...' do 
      bi = SixDegrees::Graph.simplify_parser twoway
      it = SixDegrees::Graph.iterate! bi, 1
      it[:stephen][0].size.should eq 2
      it[:bob][0].size.should eq 1
      it[:alex][0].size.should eq 1
 
    end
    it 'should generate successive levels of connections...' do 
      bi = SixDegrees::Graph.simplify_parser twoway
      it = SixDegrees::Graph.iterate! bi, 1

      it[:stephen][1].size.should eq 0
      it[:bob][1].size.should eq 1
      it[:bob][1].should eq [:alex]
      it[:alex][1].size.should eq 1
      it[:alex][1].should eq [:bob]
 
    end
  end
end

require File.dirname(__FILE__) + '/spec_helper'

describe SixDegrees::Graph do
  context 'Given a hash of uni-directional 1st-order connections' do
    let(:uni) do
      h = {:stephen => [:bob], :bob => [:alex]}
      h.default = []
      h
    end
    it 'should give me a hash exclusively of bi-directional 1st-order connections' do
      bi = SixDegrees::Graph.build_bidirectional uni
      bi[:stephen].size.should eq 0
      bi[:bob].size.should eq 0
    end
  end
end

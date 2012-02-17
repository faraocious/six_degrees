require File.dirname(__FILE__) + '/spec_helper'
require 'parse'

describe SixDegrees::Parse do

  context 'initializing with existing file path...' do
    it 'loads file' do
      parser = SixDegrees::Parse.new(File.join(File.dirname(__FILE__), '../file/sample_input.txt'))
      h = parser.parse
      h.class.should == Hash
    end
  end

  context 'test regular expression matching...' do
    it 'finds authors...' do
      match = SixDegrees::Parse.author('alex: hello @stephen')
      match.should == 'alex'

    end

    it 'finds mentions...' do
      match = SixDegrees::Parse.mentions('alex: hello @stephen')
      match.class.should == Array
      match[0].should == :stephen
     
    end

    it 'finds multiple mentions...' do
      match = SixDegrees::Parse.mentions('alex: hello @stephen, @bob')
      match.class.should == Array
      match[0].should == :stephen
      match[1].should == :bob
     
    end


  end
end


require 'spec_helper'

describe Configuration do
  
  it "should be valid from factory" do
    o = Factory(:configuration)
    o.should be_valid
  end
  
  it "should have a name" do
    o = Factory.build(:configuration, :name => nil)
    o.should_not be_valid
  end
  
end
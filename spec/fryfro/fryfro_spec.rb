require File.dirname(__FILE__) + '/../spec_helper'

describe Fryfro do
  let(:access_code) { 'philip' }

  it { should be }
  it { should be_kind_of Module }
  it { should respond_to(:all_applications_info_raw).with(1).argument }
  it { should respond_to(:all_applications).with(1).argument }

  describe '.all_applications_info_raw', :vcr do
    it 'returns a Hash' do
      result = Fryfro.all_applications_info_raw(access_code: access_code)
      result.should be_kind_of Hash
    end
  end

  describe '.all_applications' do
    it 'returns an Array of Fryfro::App', :vcr do
      result = Fryfro.all_applications(access_code: access_code)

      result.should be_kind_of Array
      result.should be_all { |e| e.should be_kind_of Fryfro::App }

      nibler = result[1]
      nibler.key.should         eql '666'
      nibler.access_code.should eql access_code
      nibler.name.should        eql 'Nibler'
      nibler.platform.should    eql 'Android'
      nibler.created_at.should  eql '2013-04-05' #TODO: Implement Date class
    end
  end
end

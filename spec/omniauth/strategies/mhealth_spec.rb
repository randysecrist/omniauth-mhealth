require 'spec_helper'

describe OmniAuth::Strategies::Mhealth do
  let(:access_token) { stub('AccessToken', :options => {}) }
  let(:parsed_response) { stub('ParsedResponse') }
  let(:response) { stub('Response', :parsed => parsed_response) }

  subject do
    OmniAuth::Strategies::Mhealth.new({})
  end

  before(:each) do
    subject.stub!(:access_token).and_return(access_token)
  end

  context "client options" do
    it 'should have correct site' do
      subject.options.client_options.site.should eq("https://mhealth.att.com")
   end

    it 'should have correct authorize_url ' do
      subject.options.client_options.authorize_url.should eq("/auth")
    end

    it 'should have correct token_url  ' do
      subject.options.client_options.token_url.should eq("/access_token.json")
    end
  end

  context "access token options" do
    it 'should have correct header_format' do
      subject.options.access_token_options.header_format eq("OAuth %s")
    end

    it 'should have correct param_name ' do
      subject.options.access_token_options.param_name.should eq("oauth_token")
    end
  end

  context "api_site options" do
    it 'should have correct api_site' do
      subject.options.api_site.should eq("https://api-mhealth.att.com/")
    end
  end
end
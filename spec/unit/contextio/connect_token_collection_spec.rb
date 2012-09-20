require 'spec_helper'
require 'contextio/connect_token_collection'

describe ContextIO::ConnectTokenCollection do
  let(:api) { double('API') }

  subject { ContextIO::ConnectTokenCollection.new(api) }

  describe ".new" do
    it "takes an api handle" do
      expect(subject.api).to eq(api)
    end
  end

  describe "#create" do
    before do
      api.stub(:request).with(:post, anything, anything).and_return({ token: '1234' })
    end

    it "posts to /connect_tokens" do
      api.should_receive(:request).with(
        :post,
        'connect_tokens',
        hash_including(callback_url: 'http://callback.com')
      )

      subject.create('http://callback.com')
    end

    it "doesn't make any more API calls than it needs to" do
      api.should_not_receive(:request).with(:get, anything, anything)

      subject.create('http://callback.com')
    end

    it "returns a ConnectToken" do
      expect(subject.create('http://callback.com')).to be_a(ContextIO::ConnectToken)
    end

    it "takes an optional service level" do
      api.should_receive(:request).with(
        :post,
        'connect_tokens',
        hash_including(service_level: 'PRO')
      )

      subject.create('http://callback.com', service_level: 'PRO')
    end

    it "takes an optional email" do
      api.should_receive(:request).with(
        :post,
        'connect_tokens',
        hash_including(email: 'person@email.com')
      )

      subject.create('http://callback.com', email: 'person@email.com')
    end

    it "takes an optional first name" do
      api.should_receive(:request).with(
        :post,
        'connect_tokens',
        hash_including(first_name: 'Bruno')
      )

      subject.create('http://callback.com', first_name: 'Bruno')
    end

    it "takes an optional last name" do
      api.should_receive(:request).with(
        :post,
        'connect_tokens',
        hash_including(last_name: 'Morency')
      )

      subject.create('http://callback.com', last_name: 'Morency')
    end
  end

  describe "#each" do
    let(:response) do
      [
        {
          # ...
        }
      ]
    end
  end
end

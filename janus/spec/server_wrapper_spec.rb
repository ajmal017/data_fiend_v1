require 'spec_helper'

RSpec.describe "Wrapper" do
  context "is operational" do
    it "can create a new thread" do
      payload = { username: YamlParser.read('USERNAME'),
                  password: YamlParser.read('PASSWORD'),
                  target: YamlParser.read('ACCEPTED_THREADS')[2] 
      }
      web_token = JWT.encode payload, YamlParser.read('HMAC_SECRET'), 'HS256'
      rh = RequestHelper.new(url: 'create_thread', headers: { 'X-Token' => web_token })
      response = rh.post

      result = JSON.parse(response.body)
      expect(response).to be_success
      expect(result['message']).to eq('Thread test_queue1 created')
    end

    it "can't create a thread with invalid target" do
      payload = { username: YamlParser.read('USERNAME'),
                  password: YamlParser.read('PASSWORD'),
                  target: 'the moon' }
      web_token = JWT.encode payload, YamlParser.read('HMAC_SECRET'), 'HS256'
      rh = RequestHelper.new(url: 'create_thread', headers: { 'X-Token' => web_token })
      response = rh.post
      result = JSON.parse(response.body)

      expect(response).to_not be_success
      expect(result['message']).to eq('Invalid target')
    end

    it "can't create a thread with invalid user info" do
      payload = { username: 'blackhatmcgee',
                  password: 'wrong',
                  target: YamlParser.read('ACCEPTED_THREADS')[2]
      }
      web_token = JWT.encode payload, YamlParser.read('HMAC_SECRET'), 'HS256'
      rh = RequestHelper.new(url: 'create_thread', headers: { 'X-Token' => web_token })
      response = rh.post
      result = JSON.parse(response.body)

      expect(response).to_not be_success
      expect(result['message']).to eq('Invalid credentials')
    end
  end
end

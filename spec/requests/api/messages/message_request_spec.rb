require 'rails_helper'
require 'faker'

describe 'users API requests' do
  describe 'GET /api/messages/:id' do
    it 'returns a message with proper attributes' do
      user_1 = User.create(first_name: "Hero", last_name: "Jacobs")
      user_2 = User.create(first_name: "Lady", last_name: "Pearson")

      subj = 'Hey there'
      bod = 'It is I'

      message = Message.create(
        subject: subj,
        body: bod,
        receiver_id: user_1.id,
        sender_id: user_2.id
      )

      get "/api/messages/#{message.id}", params: {}

      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body)

      expect(json_response['id']).to eq(message[:id])
      expect(json_response['subject']).to eq(subj)
      expect(json_response['body']).to eq(bod)
      expect(json_response['sender_id']).to eq(user_2.id)
      expect(json_response['receiver_id']).to eq(user_1.id)
    end
  end

  describe 'GET /api/user/:id_1/messages-from-sender/:id_2' do
    it 'returns the appropriate messages' do
      user_1 = User.create(first_name: "Hero", last_name: "Jacobs")
      user_2 = User.create(first_name: "Lady", last_name: "Pearson")
      user_3 = User.create(first_name: "Bo", last_name: "Manns")

      sub1 = 'yo'
      sub2 = 'something'
      sub3 = 'else'

      bod1 = 'me'
      bod2 = 'you'
      bod3 = 'I'

      message_1 = Message.create(
        subject: sub1,
        body: bod1,
        receiver_id: user_1.id,
        sender_id: user_3.id
      )

      message_2 = Message.create(
        subject: sub2,
        body: bod2,
        receiver_id: user_1.id,
        sender_id: user_3.id
      )

      message_2 = Message.create(
        subject: sub3,
        body: bod3,
        receiver_id: user_2.id,
        sender_id: user_1.id
      )

      get "/api/user/#{user_1.id}/messages-from-sender/#{user_3.id}", params: {}

      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body)

      expect(json_response.length).to eq(2)
      expect(json_response[0]['subject']).to eq(sub1)
      expect(json_response[0]['body']).to eq(bod1)
      expect(json_response[0]['sender_id']).to eq(user_3.id)
      expect(json_response[0]['receiver_id']).to eq(user_1.id)
    end
  end

  describe 'GET /api/user/:id/messages-to-user' do
    it 'returns the appropriate messages' do
      user_1 = User.create(first_name: "Hero", last_name: "Jacobs")
      user_2 = User.create(first_name: "Lady", last_name: "Pearson")
      user_3 = User.create(first_name: "Bo", last_name: "Manns")

      sub1 = 'yo'
      sub2 = 'something'
      sub3 = 'else'

      bod1 = 'me'
      bod2 = 'you'
      bod3 = 'I'

      message_1 = Message.create(
        subject: sub1,
        body: bod1,
        receiver_id: user_1.id,
        sender_id: user_3.id
      )

      message_2 = Message.create(
        subject: sub2,
        body: bod2,
        receiver_id: user_1.id,
        sender_id: user_3.id
      )

      message_2 = Message.create(
        subject: sub3,
        body: bod3,
        receiver_id: user_1.id,
        sender_id: user_2.id
      )

      get "/api/user/#{user_1.id}/messages-to-user", params: {}

      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body)

      expect(json_response.length).to eq(3)
      expect(json_response[0]['subject']).to eq(sub1)
      expect(json_response[0]['body']).to eq(bod1)
      expect(json_response[0]['sender_id']).to eq(user_3.id)
      expect(json_response[0]['receiver_id']).to eq(user_1.id)
    end
  end

  describe 'GET /api/recent-messages' do
    it 'returns the appropriate messages' do
      user_1 = User.create(first_name: "Hero", last_name: "Jacobs")
      user_2 = User.create(first_name: "Lady", last_name: "Pearson")
      user_3 = User.create(first_name: "Bo", last_name: "Manns")

      sub1 = 'yo'
      sub2 = 'something'
      sub3 = 'else'

      bod1 = 'me'
      bod2 = 'you'
      bod3 = 'I'

      message_1 = Message.create(
        subject: sub1,
        body: bod1,
        receiver_id: user_1.id,
        sender_id: user_3.id
      )

      message_2 = Message.create(
        subject: sub2,
        body: bod2,
        receiver_id: user_1.id,
        sender_id: user_3.id
      )

      message_2 = Message.create(
        subject: sub3,
        body: bod3,
        receiver_id: user_1.id,
        sender_id: user_2.id
      )

      get "/api/recent-messages", params: {}

      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body)

      expect(json_response.length).to be < 100
      expect(json_response.length).to eq(3)
    end
  end

  describe 'GET /api/messages' do
    it 'should return a list of messages' do
      user_1 = User.create(first_name: "Hero", last_name: "Jacobs")
      user_2 = User.create(first_name: "Lady", last_name: "Pearson")

      sub1 = 'yo'
      sub2 = 'something'
      sub3 = 'else'

      bod1 = 'me'
      bod2 = 'you'
      bod3 = 'I'

      message_1 = Message.create(
        subject: sub1,
        body: bod1,
        receiver_id: user_1.id,
        sender_id: user_2.id
      )

      message_2 = Message.create(
        subject: sub1,
        body: bod1,
        receiver_id: user_2.id,
        sender_id: user_1.id
      )

      get "/api/messages", params: {}

      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body)

      expect(json_response.length).to eq(2)
    end
  end

  describe 'DELETE /api/messages/:id' do
    it 'should delete the message by id' do
      user_1 = User.create(first_name: "Hero", last_name: "Jacobs")
      user_2 = User.create(first_name: "Lady", last_name: "Pearson")

      sub1 = 'yo'
      sub2 = 'something'
      sub3 = 'else'

      bod1 = 'me'
      bod2 = 'you'
      bod3 = 'I'

      message_1 = Message.create(
        subject: sub1,
        body: bod1,
        receiver_id: user_1.id,
        sender_id: user_2.id
      )

      message_2 = Message.create(
        subject: sub1,
        body: bod1,
        receiver_id: user_2.id,
        sender_id: user_1.id
      )

      get "/api/messages", params: {}

      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body)

      expect(json_response.length).to eq(2)

      delete "/api/messages/#{message_1.id}", params: {}

      get "/api/messages", params: {}

      after_deleted_response = JSON.parse(response.body)

      expect(after_deleted_response.length).to eq(1)
    end
  end
end
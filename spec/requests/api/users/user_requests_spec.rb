require 'rails_helper'

describe 'users API requests' do
  describe 'GET /api/users/:id' do
    it 'returns a user with user attributes' do
      user = User.create(first_name: "Hero", last_name: "Jacobs")

      id = user.id

      get "/api/users/#{id}", params: {}

      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body)

      expect(json_response['first_name']).to eq(user[:first_name])
      expect(json_response['last_name']).to eq(user[:last_name])
    end
  end

  describe 'GET /api/users' do
    it 'returns all users with attributes' do
      User.create(first_name: "Hero", last_name: "Jacobs")
      User.create(first_name: "Paisley", last_name: "Fabric")

      get "/api/users", params: {}

      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body)

      expect(json_response.length).to eq(2)
    end
  end

  describe 'DELETE /api/users/:id' do
    it 'deletes the user from the list of users' do
      User.create(first_name: "Hero", last_name: "Jacobs")
      User.create(first_name: "Paisley", last_name: "Fabric")
      user_3 = User.create(first_name: "Prezzi", last_name: "Strudel")

      get "/api/users"

      expect(response.status).to eq(200)

      first_response = JSON.parse(response.body)

      expect(first_response.length).to eq(3)

      delete "/api/users/#{user_3.id}"

      get "/api/users/", params: {}

      expect(response.status).to eq(200)

      second_response = JSON.parse(response.body)

      expect(second_response.length).to eq(2)
    end
  end
end
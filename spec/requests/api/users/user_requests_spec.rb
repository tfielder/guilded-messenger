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
end
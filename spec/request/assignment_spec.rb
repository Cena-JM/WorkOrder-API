require 'rails_helper'

RSpec.describe 'assignments API', type: :request do
  let!(:assignments) { create_list(:assignment, 10) }
  let(:assignment_id) { assignments.first.id }

  describe 'GET api/v1/assignments' do

    before { get '/api/v1/assignments' }

    it 'returns assignments' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/assignments/:id
  describe 'GET /api/v1/assignments/:id' do
    before { get "/api/v1/assignments/#{assignment_id}" }

    context 'when the record exists' do
      it 'returns the assignment' do
        expect(json).not_to be_empty
        expect(json[0]).to eq(assignment_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:assignment_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find Assignment with 'id'=100\"}")
      end
    end
  end

  # Test suite for POST /api/v1/assignments
  describe 'POST /api/v1/assignments' do
    # valid payload
    let(:valid_attributes) { { work_order_id: '1', worker_id: '1' } }

    context 'when the request is valid' do
      before { post '/api/v1/assignments', params: valid_attributes }

      it 'creates a assignment' do
        expect(json['work_order_id']).to eq(1)
        expect(json['worker_id']).to eq(1)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/assignments', params: { worker_id: 1 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

    #   it 'returns a validation failure message' do
    #     expect(response.body)
    #       .to match("{\"message\":\"Validation failed: Content can't be blank\"}")
    #   end
    end
  end

  # Test suite for PUT /api/v1/assignments/:id
  describe 'PUT /api/v1/assignments/:id' do
    let(:valid_attributes) { { work_order_id: 1, worker_id: 3 } }

    context 'when the record exists' do
      before { put "/api/v1/assignments/#{assignment_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /api/v1/assignments/:id
  describe 'DELETE /api/v1/assignments/:id' do
    before { delete "/api/v1/assignments/#{assignment_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

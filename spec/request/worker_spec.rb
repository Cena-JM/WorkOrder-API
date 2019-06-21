require 'rails_helper'

RSpec.describe 'workers API', type: :request do
  let!(:workers) { create_list(:worker, 10) }
  let(:worker_id) { workers.first.id }

  describe 'GET api/v1/workers' do

    before { get '/api/v1/workers' }

    it 'returns workers' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/workers/:id
  describe 'GET /api/v1/workers/:id' do
    before { get "/api/v1/workers/#{worker_id}" }

    context 'when the record exists' do
      it 'returns the worker' do
        expect(json).not_to be_empty
        expect(json[0]['id']).to eq(worker_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:worker_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find Worker with 'id'=100\"}")
      end
    end
  end

  # Test suite for POST /api/v1/workers
  describe 'POST /api/v1/workers' do
    # valid payload
    let(:valid_attributes) { { name: 'test_name', company_name: 'test_company', email: 'test_email@fake.com' } }

    context 'when the request is valid' do
      before { post '/api/v1/workers', params: valid_attributes }

      it 'creates a worker' do
        expect(json['name']).to eq('test_name')
        expect(json['company_name']).to eq('test_company')
        expect(json['email']).to eq('test_email@fake.com')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/workers', params: { name: 'Foo' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

    #   it 'returns a validation failure message' do
    #     expect(response.body)
    #       .to match("{\"message\":\"Validation failed: Content can't be blank\"}")
    #   end
    end
  end

  # Test suite for PUT /api/v1/workers/:id
  describe 'PUT /api/v1/workers/:id' do
    let(:valid_attributes) { { name: 'test_name', company_name: 'test_company', email: 'test_email@fake.com' } }

    context 'when the record exists' do
      before { put "/api/v1/workers/#{worker_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /api/v1/workers/:id
  describe 'DELETE /api/v1/workers/:id' do
    before { delete "/api/v1/workers/#{worker_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

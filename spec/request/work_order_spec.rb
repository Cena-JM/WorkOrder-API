require 'rails_helper'

RSpec.describe 'work_orders API', type: :request do
  let!(:work_orders) { create_list(:work_order, 10) }
  let(:work_order_id) { work_orders.first.id }

  describe 'GET api/v1/work_orders' do

    before { get '/api/v1/work_orders' }

    it 'returns work_orders' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/work_orders/:id
  describe 'GET /api/v1/work_orders/:id' do
    before { get "/api/v1/work_orders/#{work_order_id}" }

    context 'when the record exists' do
      it 'returns the work_order' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(work_order_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:work_order_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find WorkOrder with 'id'=100\"}")
      end
    end
  end

  # Test suite for POST /api/v1/work_orders
  describe 'POST /api/v1/work_orders' do
    # valid payload
    let(:valid_attributes) { { title: 'test_title', description: 'test_description', deadline: '2019-12-12' } }

    context 'when the request is valid' do
      before { post '/api/v1/work_orders', params: valid_attributes }

      it 'creates a work_order' do
        expect(json['title']).to eq('test_title')
        expect(json['description']).to eq('test_description')
        expect(json['deadline']).to eq('2019-12-12')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/work_orders', params: { title: 'Foo' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

    #   it 'returns a validation failure message' do
    #     expect(response.body)
    #       .to match("{\"message\":\"Validation failed: Content can't be blank\"}")
    #   end
    end
  end

  # Test suite for PUT /api/v1/work_orders/:id
  describe 'PUT /api/v1/work_orders/:id' do
    let(:valid_attributes) { { name: 'test_name', company_name: 'test_company', email: 'test_email@fake.com' } }

    context 'when the record exists' do
      before { put "/api/v1/work_orders/#{work_order_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /api/v1/work_orders/:id
  describe 'DELETE /api/v1/work_orders/:id' do
    before { delete "/api/v1/work_orders/#{work_order_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

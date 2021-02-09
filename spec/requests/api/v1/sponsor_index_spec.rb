require 'rails_helper'

describe Api::V1::SponsorsController, type: :request do
  describe 'GET /api/v1/sponsors' do
    before do
      create(:cndt2020)
      create(:day1)
      create(:day2)
      create(:talk1)
      create(:talk2)
      create(:track1)
      create(:track2)
      create(:sponsor)
      create(:sponsor_attachment_logo)
    end

    it 'confirm json schema' do
      get '/api/v1/sponsors?eventId=1'
      expect(response).to have_http_status :ok
      assert_response_schema_confirm
    end

    it 'successed request' do
      get '/api/v1/sponsors?eventId=1'
      expect(response.status).to eq 200
    end
  end
end

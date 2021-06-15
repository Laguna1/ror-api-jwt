require 'rails_helper'

RSpec.describe '/items', type: :request do
  let(:user) { create :user }

  let(:valid_attributes) { { day: '20210615' } }

  let(:invalid_attributes) { { day: '' } }

  let(:valid_headers) do
    {
      Authorization: "Bearer #{user.create_access_token.token}"
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      create :item, user: user
      get items_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      item = create :item, user: user
      get item_url(item), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Item' do
        expect do
          post items_url,
               params: { data: {
                 attributes: valid_attributes
               } }, headers: valid_headers, as: :json
        end.to change(Item, :count).by(1)
      end

      it 'renders a JSON response with the new item' do
        post items_url,
             params: { data: {
               attributes: valid_attributes
             } }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Item' do
        expect do
          post items_url,
               params: { data: { attributes: invalid_attributes } },
               headers: valid_headers, as: :json
        end.to change(Item, :count).by(0)
      end

      it 'renders a JSON response with errors for the new item' do
        post items_url,
             params: { data: { attributes: invalid_attributes } },
             headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          day: '20211010'
        }
      end

      it 'updates the requested item' do
        item = create :item, user: user
        expect do
          patch item_url(item),
                params: { data: { attributes: new_attributes } },
                headers: valid_headers, as: :json
                item.reload
        end.to change(Item, :count).by(0)
      end

      it 'renders a JSON response with the item' do
        item = create :item, user: user
        patch item_url(item),
              params: { data: { attributes: new_attributes } },
              headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the item' do
        item = create :item, user: user
        patch item_url(item),
              params: { data: { attributes: invalid_attributes } },
              headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested item' do
      item = create :item, user: user
      expect do
        delete item_url(item), headers: valid_headers, as: :json
      end.to change(Item, :count).by(-1)
    end
  end
end
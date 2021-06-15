require 'rails_helper'

RSpec.describe TracksController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/items/1/tracks').to route_to('tracks#index', item_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/items/1/tracks/1').to route_to('tracks#show', item_id: '1', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/items/1/tracks').to route_to('tracks#create', item_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/items/1/tracks/1').to route_to('tracks#update', item_id: '1', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/items/1/tracks/1').to route_to('tracks#update', item_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/items/1/tracks/1').to route_to('tracks#destroy', item_id: '1', id: '1')
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

describe Api::TodoItemsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/todo_lists/1/todo_items').to route_to('api/todo_items#index', todo_list_id: '1')
    end

    it 'routes to #show' do
      expect(get: 'api/todo_items/1').to route_to('api/todo_items#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/todo_lists/1/todo_items').to route_to('api/todo_items#create', todo_list_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/todo_items/1').to route_to('api/todo_items#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/todo_items/1').to route_to('api/todo_items#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/todo_items/1').to route_to('api/todo_items#destroy', id: '1')
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

describe Api::TodoListsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/todo_lists').to route_to('api/todo_lists#index')
    end

    it 'routes to #show' do
      expect(get: '/api/todo_lists/1').to route_to('api/todo_lists#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/todo_lists').to route_to('api/todo_lists#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/todo_lists/1').to route_to('api/todo_lists#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/todo_lists/1').to route_to('api/todo_lists#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/todo_lists/1').to route_to('api/todo_lists#destroy', id: '1')
    end
  end
end

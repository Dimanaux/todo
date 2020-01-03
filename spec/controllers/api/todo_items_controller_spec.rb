# frozen_string_literal: true

require 'rails_helper'
require 'support/factory_bot'
require 'support/shared_contexts/when_authenticated'

describe Api::TodoItemsController do
  using JsonHelpers

  include_context 'when authenticated'

  let(:valid_attributes) { attributes_for(:todo_item).merge(user: current_user) }
  let(:invalid_attributes) { attributes_for(:todo_item).merge(title: '') }
  let(:my_list) { create(:todo_list, user: current_user) }
  let(:my_item) { create(:todo_item, user: current_user, todo_list: my_list) }

  describe 'GET #index' do
    context 'when viewing my todo list' do
      it 'returns a success response' do
        get :index, params: { todo_list_id: my_list.to_param }
        expect(response).to be_successful
      end

      it 'returns all todo list items' do
        get :index, params: { todo_list_id: my_list.to_param }
        expect(response_body.map { |h| h['id'].to_i }.sort).to eq(my_list.todo_item_ids.sort)
      end
    end

    context 'when accessing other user\'s todo list' do
      let(:item) { create(:todo_item) }

      it 'forbids to view' do
        get :index, params: { todo_list_id: item.todo_list.to_param }
        expect(response).not_to be_successful
      end

      it 'returns an error message' do
        get :index, params: { todo_list_id: item.todo_list.to_param }
        expect(response_body).to include('error')
      end
    end
  end

  describe 'GET #show' do
    context 'with current user\'s todo' do
      it 'returns a success response' do
        get :show, params: { id: my_item.to_param }
        expect(response).to be_successful
      end

      it 'returns a json' do
        get :show, params: { id: my_item.to_param }
        expect(response.content_type).to include('application/json')
      end

      it 'returns todo item by id' do
        get :show, params: { id: my_item.to_param }
        expect(response_body).to eq(my_item.as_json)
      end
    end

    context 'with other user\'s todo' do
      let(:item) { create(:todo_item) }

      it 'returns an error response' do
        get :show, params: { id: item.to_param }
        expect(response).not_to be_successful
      end
    end
  end

  describe 'POST #create', skip: true do
    context 'with valid params' do
      it 'creates a new TodoItem' do
        expect do
          post :create, params: { todo_item: valid_attributes }
        end.to change(TodoItem, :count).by(1)
      end

      it 'renders a JSON response with the new todo_item' do
        post :create, params: { todo_item: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(todo_item_url(TodoItem.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new todo_item' do
        post :create, params: { todo_item: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update', skip: true do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested todo_item' do
        todo_item = TodoItem.create! valid_attributes
        put :update, params: { id: todo_item.to_param, todo_item: new_attributes }
        todo_item.reload
        skip('Add assertions for updated state')
      end

      it 'renders a JSON response with the todo_item' do
        todo_item = TodoItem.create! valid_attributes

        put :update, params: { id: todo_item.to_param, todo_item: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the todo_item' do
        todo_item = TodoItem.create! valid_attributes

        put :update, params: { id: todo_item.to_param, todo_item: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy', skip: true do
    it 'destroys the requested todo_item' do
      todo_item = TodoItem.create! valid_attributes
      expect do
        delete :destroy, params: { id: todo_item.to_param }
      end.to change(TodoItem, :count).by(-1)
    end
  end
end

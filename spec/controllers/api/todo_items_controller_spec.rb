# frozen_string_literal: true

require 'rails_helper'
require 'support/factory_bot'
require 'support/shared_contexts/when_authenticated'

describe Api::TodoItemsController do
  using JsonHelpers

  include_context 'when authenticated'

  let(:some_list) { create(:todo_list) }
  let(:invalid_attributes) { attributes_for(:todo_item).merge(title: '', todo_list: some_list) }

  let(:my_list) { create(:todo_list, user: current_user) }
  let(:valid_attributes) { attributes_for(:todo_item).merge(user: current_user, todo_list: my_list) }
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

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new TodoItem' do
        expect do
          post :create, params: { todo_list_id: my_list.id }, body: valid_attributes.to_json, as: :json
        end.to change(TodoItem, :count).by(1)
      end

      it 'returns status "created"' do
        post :create, params: { todo_list_id: my_list.id }, body: valid_attributes.to_json, as: :json
        expect(response).to have_http_status(:created)
      end

      it 'renders a JSON response' do
        post :create, params: { todo_list_id: my_list.id }, body: valid_attributes.to_json, as: :json
        expect(response.content_type).to include('application/json')
      end
    end

    context 'with invalid params' do
      before { post :create, params: { todo_list_id: my_list.id }, body: invalid_attributes.to_json, as: :json }

      it 'renders a JSON response' do
        expect(response.content_type).to include('application/json')
      end

      it 'responses with status "unprocessable entity"' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'shows errors' do
        expect(response_body).to include('error')
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

  describe 'DELETE #destroy' do
    it 'destroys the requested todo_item' do
      item = TodoItem.create!(valid_attributes)
      expect { delete :destroy, params: { id: item.to_param } }
        .to change(TodoItem, :count).by(-1)
    end

    it 'forbids to destroy other user\'s todo' do
      some_item = create(:todo_item)
      delete :destroy, params: { id: some_item.to_param }
      expect(response_body).to include('error')
    end
  end
end

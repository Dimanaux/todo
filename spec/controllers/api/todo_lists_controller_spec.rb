# frozen_string_literal: true

require 'rails_helper'
require 'support/factory_bot'
require 'support/shared_contexts/when_authenticated'

describe Api::TodoListsController do
  using JsonHelpers

  include_context 'when authenticated'

  let(:valid_attributes) { attributes_for(:todo_list).merge(user: current_user) }
  let(:invalid_attributes) { attributes_for(:todo_list).merge(title: '') }
  let(:other_user) { create(:user) }

  describe 'GET #index' do
    it 'returns a success response' do
      TodoList.create!(valid_attributes)
      get :index
      expect(response).to be_successful
    end

    it 'returns all current user\'s todo lists' do
      TodoList.create!(valid_attributes)
      get :index
      current_user_todo_lists = current_user.todo_lists.map(&:as_json).sorted
      expect(response_body.sorted).to eq(current_user_todo_lists)
    end
  end

  describe 'GET #show' do
    it 'returns the json representation' do
      todo_list = TodoList.create! valid_attributes
      get :show, params: { id: todo_list.to_param }
      expect(response_body).to eq(todo_list.as_json)
    end

    it 'forbids to view other users\' lists' do
      todo_list = TodoList.create(valid_attributes.merge(user: other_user))
      get :show, params: { id: todo_list.to_param }
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new TodoList' do
        expect { post :create, params: valid_attributes }
          .to change(TodoList, :count).by(1)
      end

      it 'responses with a JSON' do
        post :create, params: valid_attributes
        expect(response.content_type).to include('application/json')
      end

      it 'responses with new todo list' do
        post :create, params: valid_attributes
        expect(response_body).to eq(TodoList.last.as_json)
      end

      it 'responses with status "created"' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'responses with errors for the new todo_list' do
        post :create, params: { todo_list: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        valid_attributes.except(:user).transform_values { |v| "#{v} changed." }
      end

      it 'updates the requested todo_list' do
        todo_list = TodoList.create! valid_attributes
        put :update, params: { id: todo_list.to_param }, body: new_attributes.to_json, as: :json
        todo_list.reload
        expect(todo_list.as_json).to include(new_attributes.transform_keys(&:to_s))
      end

      it 'renders a JSON' do
        todo_list = TodoList.create! valid_attributes
        put :update, params: { id: todo_list.to_param }, body: valid_attributes.to_json, as: :json
        expect(response.content_type).to include('application/json')
      end

      it 'renders an updated todo list' do
        todo_list = TodoList.create! valid_attributes
        put :update, params: { id: todo_list.to_param }, body: new_attributes.to_json, as: :json
        todo_list.reload
        expect(response_body).to eq(todo_list.as_json)
      end

      it 'responds with status "ok"' do
        todo_list = TodoList.create! valid_attributes
        put :update, params: { id: todo_list.to_param }, body: valid_attributes.to_json, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the todo_list' do
        todo_list = TodoList.create! valid_attributes
        put :update, params: { id: todo_list.to_param }, body: invalid_attributes.to_json, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested todo_list' do
      todo_list = TodoList.create! valid_attributes
      expect do
        delete :destroy, params: { id: todo_list.to_param }
      end.to change(TodoList, :count).by(-1)
    end
  end
end

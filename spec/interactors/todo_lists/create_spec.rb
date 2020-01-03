# frozen_string_literal: true

require 'rails_helper'

describe TodoLists::Create do
  subject(:context) { described_class.call(todo_list) }

  let(:user) { create(:user) }

  describe '.call' do
    let(:todo_list) { attributes_for(:todo_list).merge(user: user) }

    context 'when given a title and maybe a description' do
      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'provides a persisted todo list' do
        expect(context.todo_list).to be_persisted
      end

      it 'provides a todo list with given title' do
        expect(context.todo_list.title).to eq(todo_list[:title])
      end
    end

    context 'when given no title' do
      let(:todo_list) { attributes_for(:todo_list).merge(user: user, title: '') }

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'provides an error' do
        expect(context.error).to be_present
      end
    end
  end
end

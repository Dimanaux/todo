# frozen_string_literal: true

describe RepeatIntervalValidator do
  let(:user) { create(:user) }
  let(:list) { create(:todo_list, user: user) }
  let(:valid_attributes) { attributes_for(:todo_item).merge(user: user, todo_list: list) }
  let(:invalid_attributes) { valid_attributes.merge(repeat_from: 1.hour.from_now, repeat_to: 1.hour.ago) }

  context 'with todo which has repeat_to < repeat_from' do
    let(:todo_item) { TodoItem.new(invalid_attributes) }

    it 'forbids to save' do
      result = todo_item.save
      expect(result).to be_falsey
    end

    it 'gives en error' do
      todo_item.save
      expect(todo_item.errors.messages).to include(:repeat_from)
    end
  end

  context 'with todo which has valid repeat interval' do
    let(:todo_item) { TodoItem.new(valid_attributes) }

    it 'allows to save' do
      result = todo_item.save
      expect(result).to be_truthy
    end
  end
end

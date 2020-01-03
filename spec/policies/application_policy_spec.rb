# frozen_string_literal: true

describe ApplicationPolicy do
  subject(:policy) { described_class.new(user, record) }

  let(:user) { create(:user) }
  let(:record) { create(:todo_list) }

  %w[index? show? create? update? destroy?].each do |method|
    describe method do
      it 'is disabled by default' do
        expect(policy.send(method)).to be_falsey
      end
    end
  end
end

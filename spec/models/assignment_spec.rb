# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Assignment, type: :model do
  subject { create(:assignment) }

  describe 'validations' do
    context 'attributes' do
      it { expect(subject).to be_valid }
    end

    context 'presence' do
      it { should validate_presence_of :work_order_id }
      it { should validate_presence_of :worker_id }
      it { should validate_presence_of :work_order }
      it { should validate_presence_of :worker }
    end

    context 'format' do
      it { should allow_value(1).for(:work_order_id) }
      it { should allow_value(2).for(:worker_id) }
      it { should_not allow_value('ahf').for(:work_order_id) }
      it { should_not allow_value('ahf').for(:worker_id) }
      it { should_not allow_value('').for(:work_order_id) }
      it { should_not allow_value('').for(:worker_id) }
    end
  end

  describe 'associations' do
    it { should belong_to(:work_order) }
    it { should belong_to(:worker) }
  end
end

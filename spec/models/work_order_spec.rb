# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkOrder, type: :model do
  subject { create(:work_order) }

  describe 'validations' do
    context 'attributes' do
      it { expect(subject).to be_valid }
    end

    context 'presence' do
      it { should validate_presence_of :title }
      it { should validate_presence_of :description }
      it { should validate_presence_of :deadline }
    end

    context 'length' do
      it { should validate_length_of(:title) .is_at_most(50) }
      it { should validate_length_of(:description) .is_at_most(600) }
    end

    context 'format' do
      it { should allow_value('MUSA Jabbaaru').for(:title) }
      it { should allow_value('dhh nonopinionated lraem').for(:description) }
      it { should allow_value('01/01/2020').for(:deadline) }
      it { should allow_value('2020/01/01').for(:deadline) }
      it { should_not allow_value('blah').for(:deadline) }
      it { should_not allow_value('234/3/2020').for(:deadline) }
    end
  end

  describe 'associations' do
    it { should have_many(:assignments) }
    it { should have_many(:workers).through(:assignments) }
  end
end

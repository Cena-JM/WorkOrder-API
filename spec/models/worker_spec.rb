# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Worker, type: :model do
  subject { create(:worker) }

  describe 'validations' do
    context 'attributes' do
      it { expect(subject).to be_valid }
    end

    context 'presence' do
      it { should validate_presence_of :name }
      it { should validate_presence_of :company_name }
      it { should validate_presence_of :email }
    end

    context 'length' do
      it { should validate_length_of(:name) .is_at_most(50) }
      it { should validate_length_of(:company_name) .is_at_most(80) }
      it { should validate_length_of(:email) .is_at_most(255) }
    end

    context 'format' do
      it { should allow_value('MUSA Jabbaaru').for(:name) }
      it { should allow_value('dhh@nonopinionated.com').for(:email) }
      it { should_not allow_value('base@example').for(:email) }
      it { should_not allow_value('blah').for(:email) }
    end
  end

  describe 'associations' do
    it { should have_many(:assignments) }
    it { should have_many(:work_orders).through(:assignments) }
  end
end

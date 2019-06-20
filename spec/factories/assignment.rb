# frozen_string_literal: true

FactoryBot.define do
  factory :assignment do
    work_order
    worker
  end
end

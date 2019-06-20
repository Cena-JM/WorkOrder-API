# frozen_string_literal: true

FactoryBot.define do
  factory :work_order do
    title { Faker::Job.field }
    description { Faker::Lorem.sentence }
    deadline { Faker::Date.forward(30) }
  end
end

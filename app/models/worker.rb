# frozen_string_literal: true

# The worker model handles worker validations and associations
class Worker < ApplicationRecord
  has_many :assignments
  has_many :work_orders, through: :assignments

  validates :name, presence: true, length: { maximum: 50 }
  validates :company_name, presence: true, length: { maximum: 80 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end

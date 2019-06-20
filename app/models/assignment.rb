# frozen_string_literal: true

# The assignment model handles assignment validations and associations.
class Assignment < ApplicationRecord
  belongs_to :work_order
  belongs_to :worker

  validate :work_order_assignments_count_within_limit, on: :create
  validates_uniqueness_of :work_order_id, scope: :worker_id
  validates :work_order_id, presence: true, numericality: { only_integer: true }
  validates :worker_id, presence: true, numericality: { only_integer: true }
  validates :work_order, presence: true
  validates :worker, presence: true

  def work_order_assignments_count_within_limit
    if WorkOrder.ids.include?(work_order_id)
      errors.add(:base, 'Exceeded assignment limit')\
      if work_order.assignments.count >= work_order.worker_limit
    end
  end
end

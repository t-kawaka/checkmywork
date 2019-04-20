class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :detail, presence: true
  validates :deadline, presence: true
  validate :deadline_cannnot_be_in_the_past_and_today

  def deadline_cannnot_be_in_the_past_and_today
    if deadline.present? && deadline.past?
      errors.add(:deadline, "は、明日以降に設定してください！")
    end
  end
end

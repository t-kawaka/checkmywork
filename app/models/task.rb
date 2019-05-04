class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validate :validate_name_not_including_comma
  validates :detail, presence: true
  validates :deadline, presence: true
  validate :deadline_cannnot_be_in_the_past_and_today
  scope :recent, -> { order(created_at: :desc) }
  scope :expired, -> { order(deadline: :desc) }
  enum situation: { 未着手: "未着手", 着手中: "着手中", 完了: "完了" }
  enum priority: { 低: 0, 中: 1, 高: 2}
  scope :search_name, -> (name) { where('name LIKE ?',  "%#{name}%") }
  scope :search_situation, -> (situation) { where(situation: situation) }
  scope :priority, -> { order(priority: :desc)}
  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels, source: :label
  accepts_nested_attributes_for :task_labels, allow_destroy: true

  def validate_name_not_including_comma
    errors.add(:name, "にカンマを含めることはできません") if name&.include?(',')
  end

  def deadline_cannnot_be_in_the_past_and_today
    if deadline.present? && deadline.past?
      errors.add(:deadline, "は、明日以降に設定してください！")
    end
  end
end

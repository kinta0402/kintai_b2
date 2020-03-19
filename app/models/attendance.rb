class Attendance < ApplicationRecord
  belongs_to :user

  validates :worked_on, presence: true
  validates :note, length: { maximum: 50 }
  
  # 出勤時間が存在しない場合、退勤時間は無効 10.1.3
  validate :finished_at_is_invalid_without_a_started_at

  # 10.1.3 ﾊﾞﾘﾃﾞｰｼｮﾝの条件を自分で定義出来る
  def finished_at_is_invalid_without_a_started_at
    errors.add(:started_at, "が必要です") if started_at.blank? && finished_at.present?
  end
end

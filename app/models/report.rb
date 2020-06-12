class Report < ApplicationRecord
	belongs_to :user
	validates :user_id, presence: true
	default_scope -> { order(created_at: :desc) }

	def send_report_email
      UserMailer.sent_report(self).deliver_now
    end
end

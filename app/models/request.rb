class Request < ApplicationRecord
	belongs_to :user
	validates :user_id, presence: true
	default_scope -> { order(created_at: :desc) }
	enum status: {
    waiting: 0,
    agree: 1,
    disagree: 2
  }
    def status_name
        status ? "agree" : "disagree"
    end
	
end
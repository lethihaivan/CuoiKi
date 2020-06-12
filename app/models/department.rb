class Department < ApplicationRecord
 	has_many :users, dependent: :destroy
	def feed
		User.where "department_id = ?", id
	end

	#may casi no dungs rooi do cho show ra bi sai dos anh
end

class User < ApplicationRecord
   belongs_to :department
   has_many :reports , dependent: :destroy
  validates :department_id, presence: true, inclusion: {in: Department.all.map(&:id)}
  attr_accessor :remember_token, :activation_token , :reset_token
  before_save :downcase_email
  before_create :create_activation_digest
  attr_accessor :remember_token
  validates :name,  presence: true,
                    length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
   validates :password, length: { minimum: 6 }
  # validates :check_length_name, if: -> { name.present? }
   has_secure_password
      def check_length_name
      	if name.sizee > 150
      		errors.add :name , " Length maximun 150"
      	end
      end
      def remember
        self.remember_token = SecureRandom.urlsafe_base64
        update_attributes remember_digest: User.digest(remember_token)
      end
     def User.new_token
        SecureRandom.urlsafe_base64
      end

      def authenticated? attribute, token
        digest = send "#{attribute}_digest"
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password? token
      end
  # Forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end
      def self.digest token
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(token, cost: cost)
        
      end
     def send_activation_email
      UserMailer.account_activation(self).deliver_now
    end
    def create_reset_digest
      self.reset_token = User.new_token
      update_columns reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now
    end
    def send_password_reset_email
      UserMailer.password_reset(self).deliver_now

    end
    # Activates an account.
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

       def department_name=(name)
     self.department = Department.find_or_create_by(department_name: department_name)
   end

   def department_name
      self.department ? self.department.department_name : nil
   end

      def password_reset_expired?
        reset_sent_at < 2.hours.ago
      end
      def feed
        Peports.where "user_id = ?", id
      end
      private
      def downcase_email
        self.email = email.downcase
      end
      def create_activation_digest
        self.activation_token = User.new_token
        self.activation_digest = User.digest(activation_token)
      end

end

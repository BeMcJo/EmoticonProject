class User < ActiveRecord::Base
	attr_accessor :remember_token
	before_save { self.email = email.downcase }
  	validates :name,  presence: true, length: { maximum: 50 }
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	has_many :emotions
  belongs_to :event
  has_many :posts, dependent: :destroy

	def self.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
 	 end

  # Returns a random token.
  	def self.new_token
    	SecureRandom.urlsafe_base64
 	end


	def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end

  	def User.new_token
    	SecureRandom.urlsafe_base64
  	end

  	def remember
    	self.remember_token = User.new_token
   		update_attribute(:remember_digest, User.digest(remember_token))
  	end
  
  def feed
    Post.where("user_id = ?", id)
  end

end

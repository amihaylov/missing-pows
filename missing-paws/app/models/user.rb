class User < ActiveRecord::Base
	has_many :lost_animals, dependent: :destroy
  has_many :found_animals, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :adoptions, dependent: :destroy
  has_many :vet_centers, dependent: :destroy
  has_many :animal_shelters, dependent: :destroy
  has_many :pet_shops, dependent: :destroy
  has_many :pet_academies, dependent: :destroy
  has_many :pet_hotels, dependent: :destroy
<<<<<<< HEAD

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
=======
  has_many :forums, dependent: :destroy
  has_many :forum_comments, dependent: :destroy
>>>>>>> 7ab85137fb72ba590b1b188a27a38ae98d650ca8
  
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
  	return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
end
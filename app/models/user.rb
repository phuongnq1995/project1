class User < ActiveRecord::Base
  # has_many :lessons, dependent: :destroy
  # has_many :activities, dependent: :destroy
  # has_many :active_relationships, class_name: Relationship.name,
  #   foreign_key: :follower_id, dependent: :destroy
  # has_many :passive_relationships, class_name: Relationship.name,
  #   foreign_key: :followed_id, dependent: :destroy
  # has_many :following, through: :active_relationships, source: :followed
  # has_many :followers, through: :passive_relationships, source: :follower
  before_save {email.downcase!}
  enum role: {user: 0, admin: 1}
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end

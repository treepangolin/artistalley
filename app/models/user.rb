class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Roles
  enum role: %i[default admin]

  include ImageUploader::Attachment(:avatar)

  has_many :posts
  has_many :active_follows, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_follows, class_name: 'Follow', foreign_key: 'followed_id', dependent: :destroy
  has_many :followed_users, through: :active_follows, source: :followed_user
  has_many :follower_users, through: :passive_follows, source: :follower_user
  acts_as_voter

  # Allow user to sign in with either email or username
  attr_writer :login

  # Shoutout to Django for allowing users with the same username as long as they're different cases
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  # Only allow username to contain alphanumeric, periods & underscores
  validates_format_of :username, with: /^[a-zA-Z0-9_.]*$/, multiline: true

  # Set role to default on account creation
  after_initialize do
    self.role ||= :default if new_record?
  end

  def following?(user)
    followed_users.exists?(user.id)
  end

  def unfollow(user)
    active_follows.find_by(followed_id: user.id).destroy
  end

  # /user/[username] instead of /user/[id]
  def to_param
    username
  end

  # Allow login through both email or username
  def login
    @login || username || email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions[:username].nil?
      where(conditions).first
    else
      where(username: conditions[:username]).first
    end
  end
end

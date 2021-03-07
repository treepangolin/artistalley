class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Roles
  enum role: %i[default admin]

  # If someone wants to look a username up by URL, make the find method case insensitive at least
  def self.find_by_username(username)
    User.where('lower(username) = ?', username.downcase).limit(1).first
  end

  def unread_messages?
    messages.where(read: false).count.positive?
  end

  def all_activity
    PublicActivity::Activity.where(owner: self)
                            .or(PublicActivity::Activity.where(owner: followed_users))
                            .order(created_at: :desc)
  end

  include ImageUploader::Attachment(:avatar)
  include Followable

  has_many :posts
  has_many :active_follows, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_follows, class_name: 'Follow', foreign_key: 'followed_id', dependent: :destroy
  has_many :followed_users, through: :active_follows, source: :followed_user
  has_many :followers, through: :passive_follows, source: :following_user
  has_many :conversations, ->(user) { unscope(:where).where(sender: user).or(where(recipient: user)) }
  has_many :messages, through: :conversations
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

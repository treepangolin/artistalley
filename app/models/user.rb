class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Roles; app/models/ability.rb holds permissions for these
  enum role: [:default, :admin]

  has_one_attached :avatar
  
  has_many :posts

  attr_writer :login

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  # Set role to default on account creation
  after_initialize do
    if self.new_record?
      self.role ||= :default
    end
  end

  # /user/[username] instead of /user/[id]
  def to_param
    username
  end

  # Allow login through both email or username
  def login
    @login || self.username || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end
end

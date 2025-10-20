class User < ApplicationRecord
  rolify
  has_many :questionnaires, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_roles
  has_many :roles, through: :user_roles

  def add_role(role_name)
    role = Role.find_or_create_by(title: role_name)
    roles << role unless roles.include?(role)
  end

  def has_role?(role_name)
    roles.exists?(title: role_name)
  end
end

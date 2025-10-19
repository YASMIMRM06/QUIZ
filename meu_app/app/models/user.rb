class User < ApplicationRecord
  # Devise modules (escolha conforme necessidade)
  # :confirmable, :lockable, :timeoutable, :trackable e :omniauthable são opcionais
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_roles
  has_many :roles, through: :user_roles

  has_many :user_results
  has_many :user_answer_histories

  validates :name, presence: true
  validates :suap_id, presence: true
end

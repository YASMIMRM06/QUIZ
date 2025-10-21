class User < ApplicationRecord
  belongs_to :role
  has_many :user_answer_histories, dependent: :destroy
  has_many :user_results, dependent: :destroy
  has_many :questionnaires, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def admin?
    role.title == 'admin'
  end

  def moderator?
    role.title == 'moderator'
  end

  def student?
    role.title == 'student'
  end
end

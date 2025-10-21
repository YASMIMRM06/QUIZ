class Role < ApplicationRecord
    has_many :users, dependent: :destroy
    validates :title, uniqueness: true
end

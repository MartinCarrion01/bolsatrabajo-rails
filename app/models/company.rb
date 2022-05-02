class Company < ApplicationRecord
    validates :name, presence: true, length: {maximum: 64}

    has_many :jobs, dependent: :destroy
end

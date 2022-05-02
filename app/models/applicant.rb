class Applicant < ApplicationRecord
    validates :first_name, presence: true, length: {maximum: 64}
    validates :last_name, presence: true, length: {maximum: 64}

    has_many :applicant_jobs, dependent: :destroy
    has_many :jobs, through: :applicant_jobs
end

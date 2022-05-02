class Job < ApplicationRecord
    validates :name, presence: true, length: {maximum: 64}
    validates :description, presence: true

    has_many :applicant_jobs, dependent: :destroy
    has_many :applicants, through: :applicant_jobs
end

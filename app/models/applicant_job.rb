class ApplicantJob < ApplicationRecord
    enum status: [:pendiente, :interesado, :contratado, :rechazado]

    belongs_to :applicant
    belongs_to :job
end

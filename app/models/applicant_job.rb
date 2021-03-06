class ApplicantJob < ApplicationRecord
    enum status: [:pendiente, :interesa, :contratado, :rechazado]

    belongs_to :applicant
    belongs_to :job
end

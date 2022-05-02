class CreateApplicantJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :applicant_jobs do |t|
      t.belongs_to :job
      t.belongs_to :applicant
      t.integer :status, default: 0
      
      t.timestamps
    end
  end
end

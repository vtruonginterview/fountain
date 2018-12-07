class CreateJobPostings < ActiveRecord::Migration[5.1]
  def change
    create_table :job_postings do |t|
      t.integer :employer_id, null: false
      t.string :title, null: false
      t.string :description, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end

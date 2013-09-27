class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :student_id_card_no
      t.string :student_name
      t.integer :semester_no
      t.string :subject_no_1
      t.string :subject_no_2
      t.string :subject_no_3
      t.string :subject_no_4

      t.timestamps
    end
  end
end

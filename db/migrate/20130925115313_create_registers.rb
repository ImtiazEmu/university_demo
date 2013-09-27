class CreateRegisters < ActiveRecord::Migration
  def change
    create_table :registers do |t|
      t.integer :semester_no
      t.string :subject_name
      t.string :student_id_card

      t.timestamps
    end
  end
end

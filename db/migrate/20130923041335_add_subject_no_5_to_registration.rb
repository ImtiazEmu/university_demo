class AddSubjectNo5ToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :subject_no_5, :string
  end
end

class Register < ActiveRecord::Base
  SEMESTER_TYPES = ["1","2","3","4","5","6","7","8"]
  validates :student_id_card, presence: true
  validates_uniqueness_of :semester_no, :scope => [:student_id_card, :subject_name]

  before_save :eligibility_test

  private
  def eligibility_test
  end

end

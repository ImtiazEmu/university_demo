class Register < ActiveRecord::Base
  SEMESTER_TYPES = ["1","2","3","4","5","6","7","8"]
  validates :student_id_card, presence: true
  validates_uniqueness_of :semester_no, :scope => [:student_id_card, :subject_name], :message => "/ subject name already taken"
  belongs_to :semester
  has_many :subjects
  accepts_nested_attributes_for :subjects
  #validates_uniqueness_of :subject_name, :scope => [:student_id_card, :semester_no], :message => "Already Taken"

  before_save :eligibility_test

  private
  def eligibility_test
    @register = Register.all
    @register.each do |i|
      if i.subject_name == subject_name
        if i.semester_no != semester_no
          if i.student_id_card == student_id_card
            errors[:base] << "subject already taken to semester #{i.semester_no}"
            return false
          end
        end
      end
    end
  end

end

class Registration < ActiveRecord::Base

  validates_presence_of :semester_no, :if => "semester_no.nil?"
  validates_presence_of :subject_no_1, :if => "subject_no_1.nil?"
  validates_presence_of :subject_no_2, :if => "subject_no_2.nil?"
  validates_presence_of :subject_no_3, :if => "subject_no_3.nil?"
  validates_presence_of :subject_no_4, :if => "subject_no_4.nil?"
  validates :student_name, presence: true
  validates :student_id_card_no, presence: true, :uniqueness => true

  #validates :semester_no, presence: true, :inclusion => { :in => %w(1 2 3 4 5 6 7 8),
  #                                 :message => "%{value} is not a valid Field" }
  before_save :eligibility_test


  SEMESTER_TYPES = ["1","2","3","4","5","6","7","8"]

    @subjects = Subject.all
    S_Type = []
    @subjects.each do |s|
      unless S_Type.include?(s.subject_name.to_s)
      S_Type.push(s.subject_name.to_s)
      end
    end

  private
  def eligibility_test
    if semester_no == 1
      if testing_method(semester_no)
        return true
      else
        errors[:base] << 'select correct subjects for semester ' + "#{semester_no}"
        @subjec = Subject.where('semester_no == ?',semester_no)
        errors[:base] << 'subjects in semester ' + "#{semester_no}" + ' are:'
        @subjec.each do |s|
          errors[:base] <<  "#{s.subject_name.to_s}"
        end
        return false
      end

      elsif semester_no == 2
        if testing_method(semester_no)
          return true
        else
        errors[:base] << 'select correct subjects for semester ' + "#{semester_no}"
        @subjec = Subject.where('semester_no == ?',semester_no)
        errors[:base] << 'subjects in semester ' + "#{semester_no}" + ' are:'
        @subjec.each do |s|
          errors[:base] <<  "#{s.subject_name.to_s}"
        end
        return false
      end


      elsif semester_no == 3
        if testing_method(semester_no)
          return true
        else
          errors[:base] << 'select correct subjects for semester ' + "#{semester_no}"
          @subjec = Subject.where('semester_no == ?',semester_no)
          errors[:base] << 'subjects in semester ' + "#{semester_no}" + ' are:'
          @subjec.each do |s|
            errors[:base] <<  "#{s.subject_name.to_s}"
            end
          return false
        end

      elsif semester_no == 4
        if testing_method(semester_no)
          return true
        else
          errors[:base] << 'select correct subjects for semester ' + "#{semester_no}"
          @subjec = Subject.where('semester_no == ?',semester_no)
          errors[:base] << 'subjects in semester ' + "#{semester_no}" + ' are:'
          @subjec.each do |s|
            errors[:base] <<  "#{s.subject_name.to_s}"
            end
          return false
        end

      elsif semester_no == 5
        if testing_method(semester_no)
          return true
        else
          errors[:base] << 'select correct subjects for semester ' + "#{semester_no}"
          @subjec = Subject.where('semester_no == ?',semester_no)
          errors[:base] << 'subjects in semester ' + "#{semester_no}" + ' are:'
          @subjec.each do |s|
            errors[:base] <<  "#{s.subject_name.to_s}"
            end
          return false
        end

      elsif semester_no == 6
        if testing_method(semester_no)
          return true
        else
          errors[:base] << 'select correct subjects for semester ' + "#{semester_no}"
          @subjec = Subject.where('semester_no == ?',semester_no)
          errors[:base] << 'subjects in semester ' + "#{semester_no}" + ' are:'
          @subjec.each do |s|
            errors[:base] <<  "#{s.subject_name.to_s}"
            end
          return false
        end

      elsif semester_no == 7
        if testing_method(semester_no)
          return true
        else
          errors[:base] << 'select correct subjects for semester ' + "#{semester_no}"
          @subjec = Subject.where('semester_no == ?',semester_no)
          errors[:base] << 'subjects in semester ' + "#{semester_no}" + ' are:'
          @subjec.each do |s|
            errors[:base] <<  "#{s.subject_name.to_s}"
            end
          return false
        end

      else
        if testing_method(semester_no)
          return true
        else
          errors[:base] << 'select correct subjects for semester ' + "#{semester_no}"
          @subjec = Subject.where('semester_no == ?',semester_no)
          errors[:base] << 'subjects in semester ' + "#{semester_no}" + ' are:'
          @subjec.each do |s|
            errors[:base] <<  "#{s.subject_name.to_s}"
            end
          return false
        end
      end
  end

  def testing_method (semester_no)
    @subj = Subject.where('semester_no == ?', semester_no)
    sub = []
    @subj.each do |p|
      sub.push(p.subject_name.to_s)
    end
    if sub.include?(subject_no_1) and sub.include?(subject_no_2) and sub.include?(subject_no_3) and sub.include?(subject_no_4) and (subject_no_1!=subject_no_2) and (subject_no_1!=subject_no_3) and (subject_no_1!=subject_no_4) and (subject_no_1!=subject_no_5) and (subject_no_2!=subject_no_3) and (subject_no_2!=subject_no_4) and (subject_no_2!=subject_no_5) and (subject_no_3!=subject_no_4) and (subject_no_3!=subject_no_5) and (subject_no_5!=subject_no_4)
      return true
    end
  end
end

class Subject < ActiveRecord::Base
  has_and_belongs_to_many :semester
  accepts_nested_attributes_for :semester
  belongs_to :register

  validates_uniqueness_of :subject_name, :scope => :semester_no
end

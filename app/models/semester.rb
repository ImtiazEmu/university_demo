class Semester < ActiveRecord::Base
  has_and_belongs_to_many :subject
  has_many :register
end

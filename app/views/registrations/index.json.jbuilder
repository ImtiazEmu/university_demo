json.array!(@registrations) do |registration|
  json.extract! registration, :student_id_card_no, :student_name, :semester_no, :subject_no_1, :subject_no_2, :subject_no_3, :subject_no_4
  json.url registration_url(registration, format: :json)
end

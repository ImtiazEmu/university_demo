json.array!(@registers) do |register|
  json.extract! register, :semester_no, :subject_name, :student_id_card
  json.url register_url(register, format: :json)
end

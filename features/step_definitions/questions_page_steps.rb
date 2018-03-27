Given /the following questions exist/ do |question_table|
  question_table.hashes.each do |question|
    Question.create question
  end
    
end



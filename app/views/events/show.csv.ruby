require 'csv'

CSV.generate do |csv|
  length = JSON.parse(@results.last.data1).length - 1
  
  csv_column_names = ["ID", "user_id", "created_at"]
  
  for no in 0..length do
    csv_column_names.push("No#{no}")
  end
  
  csv << csv_column_names
  
  @results.each do |r|
    
    csv_column_values = [
      r.id,
      r.user_id,
      r.created_at
    ]
    
    for num in 0..length do
      data = JSON.parse(r.data1)["#{num}"] + JSON.parse(r.data2)["#{num}"]
      csv_column_values.push(data)
    end
    
    csv << csv_column_values
  end
end
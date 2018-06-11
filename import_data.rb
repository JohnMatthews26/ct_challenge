require 'open-uri'
# to retrieve the data from the API endpoint
require 'json'
# to parse the JSON
require 'date'
# access to Ruby's DateTime class
require 'active_support/core_ext/hash'
# to access the slice method for the data hash

def data
  inp = open('https://bitbucket.org/clicktime/clicktime-public/raw/b17ff44ae338c7a7fc4ecd47e56a6974f49a62a8/Sample_ClickTime_Data.json')
  data_json = inp.read
  data_hash = JSON.parse(data_json)
  data_hash['data']
end


def part1
  filename = DateTime.now.strftime('%y%m%d%H%M')
  File.open("#{filename}.txt", "w") do |f|
    headers = data[0].keys
    f.puts(headers.join("|"))
    data.each do |entry|
      entry['Comment'] = "\"" + entry['Comment'] + "\""
      f.puts entry.values.join("|")
    end
  end
end

def part2(selected_fields)

  filename = DateTime.now.strftime('%y%m%d%H%M')
  File.open("dailyexport_#{filename}.txt", "w") do |f|
    data.each do |entry|
      revised_dataset = entry.select {|i| selected_fields.include?(i)}
      ordered_dataset = revised_dataset.slice(*selected_fields)

      #Modify Comment to include quotation marks
      ordered_dataset['Comment'] = "\"" + ordered_dataset['Comment'] + "\""

      #Modify Date format to YYMMDD
      ordered_dataset['Date'] = Date.parse(ordered_dataset['Date']).strftime('%y%m%d')

      #Modify Hours format to two decimal places
      ordered_dataset['Hours'] = '%.2f' % [ordered_dataset['Hours'].round(2)]

      #Modify BillingRate to two decimal places
      ordered_dataset['BillingRate'] = '%.2f' % [ordered_dataset['BillingRate'].round(2)]

      f.puts ordered_dataset.values.join("|")

    end
  end

end
part1
part2(['Date', 'UserID', 'JobID', 'TaskID', 'Hours', 'Comment', 'BillingRate'])
class EventImport
  # switch to ActiveModel::Model in Rails 4
  extend ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :file

  def initialize(attributes={})
    
    unless attributes.nil?
      attributes.each { |name, value| send("#{name}=", value) }
    end
  end

  def persisted?
    false
  end

  def save
    
    if imported_events.map(&:valid?).all?
      imported_events.each(&:save!)
      true
    else
      imported_events.each_with_index do |event, index|
        event.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_events
    @imported_events ||= load_imported_events
  end

  def load_imported_events
    events = Array.new
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      cur_row = Hash[[header, spreadsheet.row(i)].transpose]
      db = Hash.new

      unless cur_row['the_date'].nil?
        db["the_date"] = Date.parse(cur_row["the_date"])
      end
      unless cur_row['end_date'].nil?
      db["end_date"] = Date.parse(cur_row["end_date"])        
      end
      
      #Convert the time to proper value
      unless cur_row['the_time'].nil?
      time = EventImport.xls_format_time(cur_row["the_time"])
        db["the_time"] = time
      end

      unless cur_row['end_time'].nil?
        time = EventImport.xls_format_time(cur_row["end_time"])
        db["end_time"] = time
      end

      #Get the eventtype_id from the string provided in the file
      unless cur_row['eventtype'].nil?
        db["eventtype_name"] = cur_row['eventtype']
      end

      #Get the location from the string name provided in file
      unless cur_row['location'].nil?
        db["location_name"] = cur_row['location']
      end

      #Get the court number
      db["court"] = cur_row["court"]

      #Get a description
      db["description"] = cur_row["description"]

      #Get the team by the string provided
      unless cur_row['team'].nil?
        db["team_name"] = cur_row['team']
      end
      puts db

      event = Event.new db
      
      events <<event
    end
    events
  end



  def open_spreadsheet
    case File.extname(file.original_filename)
    when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
    when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.xls_format_time(time)
      #Convert the time to proper value
      time = time.split(":")
      hour = 0
      if time[-1][-2 .. -1].upcase == "PM"
        hour = time[0].to_i % 12 + 12
      else
        hour = time[0].to_i
      end
       Time.utc(2000,"jan",1,hour,time[1].to_i,0)
  end

end
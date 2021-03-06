namespace :old_data do
  desc ""
  task :makevars => :environment do
    include ActionView::Helpers::DateHelper
    overall_start_time = Time.now
    puts "--> importing data via rake at #{overall_start_time}.\n"

    require 'faster_csv'

    vars=[]
    open(File.join('export.sql')) do |file| #{ |f| f.each('\n\n') { |record| p record } }
      puts "--> parsing raw data..."
      n=1
      file.each do |record|
        match = /^`([^`]+)` (VARCHAR|INT|DATETIME|TINYINT|TINYBLOB|DECIMAL|BLOB|).*$/.match(record)
        if match
          type = case match[2]
          when "VARCHAR"  then 'string'
          when "INT"      then 'integer'
          when "DATETIME" then 'datetime'
          when "TINYINT"  then 'integer'
          when "TINYBLOB" then 'binary'
          when "DECIMAL"  then 'decimal'
          when "BLOB"     then 'binary'
          end
          vars << [match[1], type]
        end
      end
    end
    
    vars.uniq!
    
    File.open("vars.csv", 'w') do |file|
      vars.each do |var|
        line = []
        file.puts(var.join(','))
      end
    end
  end
end

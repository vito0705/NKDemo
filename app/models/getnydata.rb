require 'influxdb'
class Getnydata < ApplicationRecord
  class << self
    DATABASE = 'mydb'
    #HOST=ENV['NY_DB_HOST']
    #PORT=ENV['NY_DB_PORT']
    #DATABASE=ENV['NY_DB_DBNAME']
    #MEASUREMENT=ENV['NY_DB_MEASUREMENT']
    #USER=ENV['NY_DB_USER']
    #PASSWORD=ENV['NY_DB_PASSWORD']
    #SER=ENV['NY_DB_USER']
    INFLUXDB = InfluxDB::Client.new DATABASE,host:"140.207.115.70",port:'18086'
    def get_current_speed_by_locate(city,time=1)
      stime=time.to_s
      query='select sum(value) from test2 where locate=\''+city+'\'and time > now()-('+stime+'s)'
      begin
        arr=INFLUXDB.query(query)
      rescue
        puts "-----Failed to contact?----"
        return 0
      end
      return arr.empty? ? 0 : arr[0]["values"][0]["sum"]
    end

    def get_history_speed_by_locate(city,time)
      stime=time.to_s
      etime=(time-1).to_s
      query='select sum(value) from test2 where locate=\''+city+'\'and time < now()-('+stime+'s) and
            time > now()-('+etime+'s)'
      begin
        arr=INFLUXDB.query(query)
      rescue
        puts "-----Failed to contact?----"
        return 0
      end
      return arr.empty? ? 0 : arr[0]["values"][0]["sum"]

    end


    def get_current_speed
      query='select sum(value) from test2 where time > now()-(1s)'
      begin
        arr=INFLUXDB.query(query)
      rescue
        puts "-----Failed to contact?2----"
        return 0
      end
      return arr.empty? ? 0 : arr[0]["values"][0]["sum"]
    end

  end
end

require 'influxdb'

username       = 'root'
password       = 'root'
database       = 'mydb'
time_precision = 'ns'
@map_json=[
    {name: "旺亨工业园", value: 9,},
    {name: "第一食堂", value: 12},
    {name: "第一教学楼", value: 12},
    {name: "南山智园", value: 12},
    {name: "宝能城花园", value: 14}
]
# either in the client initialization:
INFLUXDB = InfluxDB::Client.new database, username: username, password: password, time_precision: time_precision,host:'140.207.115.70',port:'18086'
#puts Time.now.to_f
while 1
    data =Array.new(rand(8)) do
      {
          series: 'test2',
          values: { value:5,ip:"0.0.0.0",status:"on" },
          tags:{locate:@map_json[rand(5)][:name]},
       }

    end
    INFLUXDB.write_points(data)
end


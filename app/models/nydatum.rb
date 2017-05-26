class Nydatum < ApplicationRecord
  class << self
    def get_data

      map_location_all = Array.new
      2000.times do |x|
        name = "location"
        s = x.to_s
        name_now = name + s
        num = rand(999)
        map_location = Hash.new
        map_location[:location] = name_now
        map_location[:number] = num
        map_location_all[x] = map_location

      end
      return map_location_all
    end

    def map_initialize_location
      map_location_gps = {
          "旺亨工业园": [114.007133, 22.610463],
          "第一食堂": [114.003504, 22.602569],
          "第一教学楼":  [114.005831, 22.602239],
          "南山智园": [114.01122, 22.600239],
          "宝能城花园": [114.00495, 22.597703],
      }
      p map_location_gps.is_a?(Hash)
      return map_location_gps
    end

    def return_json_array
      map_json=[
          {name: "旺亨工业园", value: 9,},
          {name: "第一食堂", value: 12},
          {name: "第一教学楼", value: 12},
          {name: "南山智园", value: 12},
          {name: "宝能城花园", value: 14}
      ]

      map_json.each do |data|
        data[:value] = Getnydata.get_current_speed_by_locate(data[:name])
      end

      return map_json
    end

    def map_point_history_data(point_data)
      value = Array.new
      200.times do |i|
        value_hash = Hash.new
        his_time = Time.now - (5 * 60) * (199 - i)
        his_time = his_time.strftime("%Y-%m-%d %H:%M:%S")
        #his_value = 2000 - rand(500)
        city=point_data[:name]
        time=(5 * 60) * (199 - i)
        value_hash[:time] = his_time
        value_hash[:value] = Getnydata.get_history_speed_by_locate(city,time)
        value[i] = value_hash
      end
      point_data[:data] = value
      return point_data

    end

    def map_point_current_data(point_data)
      #写的比较简陋，目前只负责生成随机数据+当前时间
      value = Array.new
      #real_value = 2000 - rand(500)
      city = point_data[:name]
      real_value=Getnydata.get_current_speed_by_locate(city)
      real_time = Time.now.strftime("%Y-%m-%d %H:%M:%S")

      value = [real_time, real_value]
      point_data[:real_time] = value
      return point_data
    end

    def get_gps_from_url_params(params)
      data = Hash.new
      name = params[:name]

      data[:name] = name
      data[:gps1] = params[:gps1]
      data[:gps2] = params[:gps2]
      if nil != params[:value]
        data[:current_value] = params[:value]
      end

      return data
    end

  end
end

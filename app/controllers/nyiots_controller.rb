class NyiotsController < ApplicationController
  def nymap
    #ny_map_global
  end


  def nyspeed
    #ny_speed_one_point
    data = Nydatum.get_gps_from_url_params(params)
    @name_speed = data[:name]

    @gps1 = data[:gps1]
    @gps2 = data[:gps2]
    @value = data[:current_value]
    p @name_speed

  end

  def map_gps_init
    gps = Nydatum.map_initialize_location
    render json: gps
  end

  def map_gps_data
    data = Nydatum.return_json_array
    render json: data
  end

  def get_history_speed
    data = Nydatum.get_gps_from_url_params(params)
    value = Nydatum.map_point_history_data(data)
    render json: value
  end

  def get_current_speed
    data = Nydatum.get_gps_from_url_params(params)
    value = Nydatum.map_point_current_data(data)
    p value
    render json: value
  end
end

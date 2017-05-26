Rails.application.routes.draw do
  get '/', to: 'nyiots#nymap'

  get '/speed', to:'nyiots#nyspeed'
  get 'nyiots/map_gps_init'
  get 'nyiots/map_gps_data'
  get 'nyiots/get_history_speed'
  get 'nyiots/get_current_speed'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

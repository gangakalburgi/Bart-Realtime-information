Rails.application.routes.draw do
  get 'home/index'
  get 'bart/schedules'
  get 'bart/stations'
  get 'bart/trips'
  get 'bart/station'


  root 'bart#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

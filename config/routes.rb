# frozen_string_literal: true
Rails.application.routes.draw do
  get '/view' => 'ad_api#get_ads'
  get '/click' => 'ad_api#update_clicks'
  resources :ad
end

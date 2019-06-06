# frozen_string_literal: true
class AdApiController < ApplicationController
  def view
    array = []

    target_ids = Ad.pluck(:id).sample(params[:count].to_i) # ランダムに広告idを取得
    ads = Ad.find(target_ids)
    ads.each do |ad|
      if ad.imp.nil?
        ad.imp = 1
      else
        ad.imp += 1
      end
      ad.save

      array.push(
        img_url: ad.image,
        body: ad.text,
        ad_id: ad.id
      )
    end
    render json: array
  end

  def click
    if ad == Ad.find_by(id: params[:ad_id])

      if ad.click.nil?
        ad.click = 1
      else
        ad.click += 1
      end

      # ad.price = params[:price] 時価を記録
      ad.save

    else
      ad = Ad.new(id: 500, adspot_id: 500)
      if ad.click.nil?
        ad.click = 1
      else
        ad.click += 1
      end
      ad.save

      render status: 500, json: { status: 500, message: 'Ad was not existed! ' }
    end
  end

end

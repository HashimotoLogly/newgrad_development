# frozen_string_literal: true
class AdApiController < ApplicationController
  def get_ads
    array = []
    reports = []

    target_ids = Ad.pluck(:id).sample(params[:count].to_i)
    ads = Ad.find(target_ids)
    ads.each do |ad|
      report =  Report.find_by(ad_id: ad.id, adspot_id: params[:adspot_id],date: Date.today)
      unless report
        report = Report.new(ad_id: ad.id, adspot_id: params[:adspot_id], date: Date.today)
      end

      report.imp += 1
      reports.push(report)

      array.push(
        img_url: ad.image.url,
        body: ad.text,
        ad_id: ad.id
      )
    end
    Report.import reports, on_duplicate_key_update: [:imp]
    render json: array
  end

  def update_clicks
    report =  Report.find_by(ad_id: params[:ad_id], adspot_id: params[:adspot_id],date: Date.today)
    unless report
      report = Report.new(ad_id: params[:ad_id], adspot_id: params[:adspot_id], date: Date.today)
    end
    report.click += 1
    report.price += Ad.find(params[:ad_id]).price
    report.save
  end

end


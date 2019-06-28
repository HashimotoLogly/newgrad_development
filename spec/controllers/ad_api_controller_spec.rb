# frozen_string_literal: true
require 'rails_helper'

RSpec.describe AdApiController, type: :controller do
  before do
    @ad1 = FactoryBot.create(:ad)
  end

  describe 'GET #get_ads' do
    it 'returns http success with valid params' do
      get :get_ads, params: { adspot_id: 1, count: 1 }
      expect(response).to have_http_status(:success)
    end

    describe 'Report' do
      it 'an ad should be recorded' do
        expect { get :get_ads, params: { adspot_id: 1, count: 1 } }.to change(Report, :count).by(1)
      end

      it "record 'imp' should be increased" do
        get :get_ads, params: { adspot_id: 1, count: 1 }
        report = Report.find_by(ad_id: @ad1.id, adspot_id: 1, date: Date.today)
        expect(report.imp).to eq 1
      end

      it "an ad shouldn't be recorded twice from the same adspot_id  on the same day" do
        get :get_ads, params: { adspot_id: 100, count: 1 }
        expect { get :get_ads, params: { adspot_id: 100, count: 1 } }.to change(Report, :count).by(0)
      end

      it 'an ad should be recorded from other adspots' do
        get :get_ads, params: { adspot_id: 100, count: 1 }
        expect { get :get_ads, params: { adspot_id: 101, count: 1 } }.to change(Report, :count).from(1).to(2)
      end

      it 'ads should be recorded at the same time' do
        ad2 = FactoryBot.create(:ad)
        expect { get :get_ads, params: { adspot_id: 101, count: 2 } }.to change(Report, :count).from(0).to(2)
      end

      it 'an ad should be recorded on the other day' do
        get :get_ads, params: { adspot_id: 101, count: 1 }
        travel 1.day do
          expect { get :get_ads, params: { adspot_id: 101, count: 1 } }.to change(Report, :count).from(1).to(2)
        end
      end

      context 'when many ads are requested' do
        it 'all ads should be visible ' do
          @ad2 = FactoryBot.create(:ad)
          @ad3 = FactoryBot.create(:ad)
          get :get_ads, params: { adspot_id: 1, count: 3 }
          jsons = JSON.parse(response.body)

          ad1_ispresent = false
          ad2_ispresent = false
          ad3_ispresent = false

          jsons.each do |json|
            if json['ad_id'] == @ad1.id
              ad1_ispresent = true
            elsif json['ad_id'] == @ad2.id
              ad2_ispresent = true
            elsif json['ad_id'] == @ad3.id
              ad3_ispresent = true
            end
          end
          expect(ad1_ispresent).to be_truthy
          expect(ad2_ispresent).to be_truthy
          expect(ad3_ispresent).to be_truthy
        end
      end
    end
  end

  describe 'GET #update_clicks' do
    before do
      @ad = FactoryBot.create(:ad)
      get :get_ads, params: { adspot_id: 1, count: 1 }
    end

    it 'returns http success' do
      get :update_clicks, params: { ad_id: @ad.id, adspot_id: 1 }
      expect(response).to have_http_status(:success)
    end

    describe 'Report' do
      it 'an ad should be recorded ' do
        expect { get :update_clicks, params: { ad_id: @ad.id, adspot_id: 1 } }.to change(Report, :count).by(0)
      end
    end
  end
end

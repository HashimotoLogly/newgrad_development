# frozen_string_literal: true
require 'rails_helper'

RSpec.describe AdController, type: :controller do
  describe 'POST #create' do
    it 'with all should plus Ad_record' do
      expect do
        post :create, params: { ad: { 'text' => 'Updated!',
                                      'price' => 1010101,
                                      'advertiser_id' => 1010101,
                                      'image' => Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixture/image.jpg')) } }
      end.to change(Ad, :count).by(1)
      expect(response).to redirect_to(ad_index_path)
    end

    it "without text should render 'new'" do
      post :create, params: { ad: { 'text' => nil,
                                    'price' => 1010101,
                                    'advertiser_id' => 1010101,
                                    'image' => Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixture/image.jpg')) } }
      expect(response).to render_template :new
    end

    it "without price should render 'new'" do
      post :create, params: { ad: { 'text' => 'Updated!',
                                    'price' => nil,
                                    'advertiser_id' => 1010101,
                                    'image' => Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixture/image.jpg')) } }
      expect(response).to render_template :new
    end

    it "without advertiser_id should render 'new'" do
      post :create, params: { ad: { 'text' => 'Updated!',
                                    'price' => 1010101,
                                    'advertiser_id' => nil,
                                    'image' => Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixture/image.jpg')) } }
      expect(response).to render_template :new
    end

    it "without image should render 'new'" do
      post :create, params: { ad: { 'text' => 'Updated!',
                                    'price' => 1010101,
                                    'advertiser_id' => 1010101,
                                    'image' => nil } }
      expect(response).to render_template :new
    end
  end

  describe 'PATCH #update' do
    before do
      @ad = FactoryBot.create(:ad)
    end

    context 'when something changed' do
      it 'with nothing should be redirected' do
        patch :update, params: { ad: {
          'text' => nil,
          'price' => nil,
          'advertiser_id' => nil,
          'image' => nil
        }, id: @ad.id }
        expect(response).to render_template :edit
      end

      it 'with text should be redirected' do
        patch :update, params: { ad: { 'text' => 'Updated!' }, id: @ad.id }
        expect(response).to redirect_to(ad_index_path)
      end

      it 'with price should be redirected' do
        patch :update, params: { ad: { 'price' => 1010101 }, id: @ad.id }
        expect(response).to redirect_to(ad_index_path)
      end

      it 'with advertiser_id should be redirected' do
        patch :update, params: { ad: { 'advertiser_id' => 1010101 }, id: @ad.id }
        expect(response).to redirect_to(ad_index_path)
      end

      it 'with image should be redirected' do
        patch :update, params: { ad: { 'image' => Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixture/image.jpg')) }, id: @ad.id }
        expect(response).to redirect_to(ad_index_path)
      end

      it 'with all should be redirected' do
        patch :update, params: { ad: {
          'text' => 'Updated!',
          'price' => 1010101,
          'advertiser_id' => 1010101,
          'image' => Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixture/image.jpg'))
        }, id: @ad.id }
        expect(response).to redirect_to(ad_index_path)
      end
    end

    context 'when something empty' do
      it 'without text should be rendered' do
        patch :update, params: { ad: { 'text' => nil }, id: @ad.id }
        expect(response).to render_template :edit
      end

      it 'without price should be rendered' do
        patch :update, params: { ad: { 'price' => nil }, id: @ad.id }
        expect(response).to render_template :edit
      end

      it 'without advertiser_id should be rendered' do
        patch :update, params: { ad: { 'advertiser_id' => nil }, id: @ad.id }
        expect(response).to render_template :edit
      end

      it 'without image should be rendered' do
        patch :update, params: { ad: { 'image' => nil }, id: @ad.id }
        expect(response).to render_template :edit
      end

      it 'without image should be rendered' do
        patch :update, params: { ad: {
          'text' => nil,
          'price' => nil,
          'advertiser_id' => nil,
          'image' => nil
        }, id: @ad.id }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @ad = FactoryBot.create(:ad)
    end

    it 'should be deleted' do
      expect { delete :destroy, params: { id: @ad.id } }.to change(Ad, :count).by(-1)
      expect(response).to redirect_to(ad_index_path)
    end
  end
end

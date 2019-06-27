# frozen_string_literal: true
require 'rails_helper'

describe 'Index Page Path' do
  it 'visit index' do
    visit ad_index_path
    expect(current_path).to eq ad_index_path
  end
end

describe 'Creation of  New Ad' do
  before do
    visit new_ad_path
  end

  it 'is Forms valid?' do
    fill_in 'ad_text', with: 'TextForm'
    fill_in 'ad_price', with: '1000'
    fill_in 'ad_advertiser_id', with: '1'
    fill_in 'ad_text', with: 'TextForm'
    page.attach_file('ad_image', '/Users/hashimototakuma/Downloads/PNG_transparency_demonstration_1.png')
  end

  it 'is create action valid?' do
    fill_in 'ad_text', with: 'TextForm'
    fill_in 'ad_price', with: '1000'
    fill_in 'ad_advertiser_id', with: '1'
    fill_in 'ad_text', with: 'TextForm'
    page.attach_file('ad_image', '/Users/hashimototakuma/Downloads/PNG_transparency_demonstration_1.png')

    expect { click_button '入稿' }.to change { Ad.count }.by(1)
  end
end

describe 'Index Links' do
  before do
    visit ad_index_path
  end

  it 'now on index?' do
    expect(current_path).to eq ad_index_path
  end

  it 'new valid?' do
    click_link('新規作成')
    expect(current_path).to eq new_ad_path
  end
end

describe 'Buttons' do
  context 'after new ad created' do
    before do
      visit new_ad_path
      fill_in 'ad_text', with: 'TextForm'
      fill_in 'ad_price', with: '1000'
      fill_in 'ad_advertiser_id', with: '1'
      fill_in 'ad_text', with: 'TextForm'
      page.attach_file('ad_image', '/Users/hashimototakuma/Downloads/PNG_transparency_demonstration_1.png')
      click_button '入稿'
    end
    it 'should be on index page' do
      expect(current_path).to eq ad_index_path
    end

    context 'on Index Page' do
      it 'edit clickable' do
        click_link('変更')
      end

      it 'Delete clickable and its action workable' do
        expect { click_link '削除' }.to change { Ad.count }.by(-1)
      end
    end
  end
end

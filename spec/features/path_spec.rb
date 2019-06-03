require 'rails_helper'


describe 'Index Page Path' do

  it "visit index" do
    visit '/ad'
    expect(current_path).to eq '/ad'
  end

  it "visit edit" do
    visit '/ad/edit'
    expect(current_path).to eq '/ad/edit'
  end

end



describe "Creation of  New Ad" do
  before do
    visit '/ad/new'
  end


  it "is Forms Valid?" do
    fill_in "ad_text", with: "TextForm"
    fill_in "ad_price", with: "1000"
    fill_in "ad_advertiser_id", with: "1"
    fill_in "ad_text", with: "TextForm"
    page.attach_file('ad_image', '/Users/hashimototakuma/Downloads/PNG_transparency_demonstration_1.png')
  end

  it "is create action valid?" do
    fill_in "ad_text", with: "TextForm"
    fill_in "ad_price", with: "1000"
    fill_in "ad_advertiser_id", with: "1"
    fill_in "ad_text", with: "TextForm"
    page.attach_file('ad_image', '/Users/hashimototakuma/Downloads/PNG_transparency_demonstration_1.png')

    expect{click_button '入稿'}.to change{Ad.count}.by(1)
  end
end


describe 'Index Links' do
  before do
    visit '/ad'
  end

  it "now on index?" do
    expect(current_path).to eq '/ad'
  end

  it "new valid?" do
    click_link("New")
    expect(current_path).to eq '/ad/new'
    #expect(page).to have_link 'New'
  end
end

describe "Edit,Delete button" do
  context "after new ad created" do
    before do
      visit 'ad/new'
      fill_in "ad_text", with: "TextForm"
      fill_in "ad_price", with: "1000"
      fill_in "ad_advertiser_id", with: "1"
      fill_in "ad_text", with: "TextForm"
      page.attach_file('ad_image', '/Users/hashimototakuma/Downloads/PNG_transparency_demonstration_1.png')
      click_button '入稿'
    end
    it "should be on index page" do
      expect(current_path).to eq '/ad'
    end

    it "edit clickable" do
      click_link('Edit')
    end

    it "Delete clickable and its action workable" do
     expect{click_link 'Delete'}.to change{Ad.count}.by(-1)
    end

  end
end

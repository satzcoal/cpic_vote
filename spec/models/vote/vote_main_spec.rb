require 'rails_helper'

describe Vote::VoteMain do
  describe "#items" do

    before :each do
      @vote = Vote::VoteMain.new
    end

    it "should import from a .xls file" do
      file = fixture_file_upload('vote_main_item.xls')
      @vote.import(file, true)
      expect(@vote.vote_items.size).to eq(2)
    end

    it "should import from a .xlsx file" do
      file = fixture_file_upload('vote_main_item.xlsx')
      @vote.import(file, true)
      expect(@vote.vote_items.size).to eq(2)
    end

    it "should import without headers" do
      file = fixture_file_upload('vote_main_item.xlsx')
      @vote.import(file, false)
      expect(@vote.vote_items.size).to eq(3)
    end
  end

  describe "#status" do

    it "should be 0 when init" do
      vote = Vote::VoteMain.new
      expect(vote.status).to eq(0)
    end

    it "should be 1 when enable"

    it "should be 2 when process"

    it "should be 3 when finish"

    it "should be 4 when publish"

    it "should be 5 when close"

    it "should be 100+ when disable"
  end
end
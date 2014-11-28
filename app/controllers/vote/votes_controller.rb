class Vote::VotesController < ApplicationController
  before_action :set_vote_vote, only: [:show, :edit, :update, :destroy]

  # GET /vote/votes
  # GET /vote/votes.json
  def index
    @vote_votes = Vote::Vote.all
  end

  # GET /vote/votes/1
  # GET /vote/votes/1.json
  def show
  end

  # GET /vote/votes/new
  def new
    @vote_vote = Vote::Vote.new
  end

  # GET /vote/votes/1/edit
  def edit
  end

  # POST /vote/votes
  # POST /vote/votes.json
  def create
    @vote_vote = Vote::Vote.new(vote_vote_params)

    respond_to do |format|
      if @vote_vote.save
        format.html { redirect_to @vote_vote, notice: 'Vote was successfully created.' }
        format.json { render :show, status: :created, location: @vote_vote }
      else
        format.html { render :new }
        format.json { render json: @vote_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vote/votes/1
  # PATCH/PUT /vote/votes/1.json
  def update
    respond_to do |format|
      if @vote_vote.update(vote_vote_params)
        format.html { redirect_to @vote_vote, notice: 'Vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @vote_vote }
      else
        format.html { render :edit }
        format.json { render json: @vote_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vote/votes/1
  # DELETE /vote/votes/1.json
  def destroy
    @vote_vote.destroy
    respond_to do |format|
      format.html { redirect_to vote_votes_url, notice: 'Vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote_vote
      @vote_vote = Vote::Vote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_vote_params
      params.require(:vote_vote).permit(:name, :start_time, :stop_time, :url)
    end
end

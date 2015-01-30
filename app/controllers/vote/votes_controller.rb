#encoding: utf-8
class Vote::VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy, :prepare, :begin, :finish, :publish]

  # GET /vote/votes
  # GET /vote/votes.json
  def index
    @votes = Vote::Vote.all
  end

  # GET /vote/votes/1
  # GET /vote/votes/1.json
  def show
  end

  # GET /vote/votes/new
  def new
    @vote = Vote::Vote.new
  end

  # GET /vote/votes/1/edit
  def edit
  end

  # POST /vote/votes
  # POST /vote/votes.json
  def create
    @vote = Vote::Vote.new(vote_params)

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
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @vote_vote }
      else
        format.html { render :edit }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # STATUS: new -> prepare
  def prepare
    @vote.prepare
    redirect_to :back, notice: "投票[#{@vote.name}]已启用！"
  end

  # STATUS: prepare -> begin
  def begin
    @vote.begin
    redirect_to :back, notice: "投票[#{@vote.name}]已经开始！"
  end

  # STATUS: begin -> finish
  def finish
    @vote.finish
    redirect_to :back, notice: "投票[#{@vote.name}]已经截止！"
  end

  # STATUS: finish -> publish
  def publish
    @vote.publish
    redirect_to :back, notice: "投票[#{@vote.name}]的结果已经公布！"
  end

  # STATUS: * -> over
  def over
    @vote.over
    redirect_to :back, notice: "投票[#{@vote.name}]已经归档！"
  end

  # STATUS: * -> destroy
  def destroy
    @vote.destroy
    redirect_to :back, notice: "投票[#{@vote.name}]已禁用！"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_vot
    @vote = Vote::Vote.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def vote_params
    params.require(:vote).permit(:name, :start_time, :stop_time, :url, :en_name, :max_num, :min_num, :vote_item)
  end
end

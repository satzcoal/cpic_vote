#encoding: utf-8
class Vote::VoteMainsController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy, :enable, :begin, :finish, :publish, :close, :disable]

  # GET /vote/votes
  # GET /vote/votes.json
  def index
    @votes = Vote::VoteMain.order(:id)
  end

  # GET /vote/votes/1
  # GET /vote/votes/1.json
  def show
    @info_provider = TmpModel.new
  end

  # GET /vote/votes/new
  def new
    @vote = Vote::VoteMain.new
  end

  # GET /vote/votes/1/edit
  def edit
  end

  # POST /vote/votes
  # POST /vote/votes.json
  def create
    @vote = Vote::VoteMain.new(vote_params)
    @vote.import(params[:vote_vote_main][:data_file], params[:data_file_has_title]) if params[:vote_vote_main][:data_file]

    respond_to do |format|
      if @vote.save
        format.html { redirect_to @vote, notice: 'Vote was successfully created.' }
        format.json { render :show, status: :created, location: @vote }
      else
        format.html { render :new }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vote/votes/1
  # PATCH/PUT /vote/votes/1.json
  def update
    @vote.import(params[:vote_vote_main][:data_file], params[:data_file_has_title]) if params[:vote_vote_main][:data_file]
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vote/votes/1
  # DELETE /vote/votes/1.json
  def destroy
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to vote_vote_mains_url, notice: 'Vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # STATUS: new -> enable
  def enable
    @vote.enable
    redirect_to :back, notice: "投票[#{@vote.name}]已启用！"
  end

  # STATUS: enable -> begin
  def begin
    @vote.process
    redirect_to :back, notice: "投票[#{@vote.name}]已经开始！"
  end

  # STATUS: process -> finish
  def finish
    @vote.finish
    redirect_to :back, notice: "投票[#{@vote.name}]已经截止！"
  end

  # STATUS: finish -> publish
  def publish
    @vote.publish
    redirect_to :back, notice: "投票[#{@vote.name}]的结果已经公布！"
  end

  # STATUS: [finish||publish] -> close
  def close
    @vote.close
    redirect_to :back, notice: "投票[#{@vote.name}]已经归档！"
  end

  # STATUS: * -> disable
  def disable
    @vote.disable
    redirect_to :back, notice: "投票[#{@vote.name}]已禁用！"
  end

  private
  def set_vote
    @vote = Vote::VoteMain.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def vote_params
    params.require(:vote_vote_main).permit(:name, :start_time, :stop_time, :url, :en_name, :max_num, :min_num, :vote_item, :bingo_num)
  end
end

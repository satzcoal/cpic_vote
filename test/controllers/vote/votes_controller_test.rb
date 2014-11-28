require 'test_helper'

class Vote::VotesControllerTest < ActionController::TestCase
  setup do
    @vote_vote = vote_votes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vote_votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vote_vote" do
    assert_difference('Vote::Vote.count') do
      post :create, vote_vote: { name: @vote_vote.name, start_time: @vote_vote.start_time, stop_time: @vote_vote.stop_time, url: @vote_vote.url }
    end

    assert_redirected_to vote_vote_path(assigns(:vote_vote))
  end

  test "should show vote_vote" do
    get :show, id: @vote_vote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vote_vote
    assert_response :success
  end

  test "should update vote_vote" do
    patch :update, id: @vote_vote, vote_vote: { name: @vote_vote.name, start_time: @vote_vote.start_time, stop_time: @vote_vote.stop_time, url: @vote_vote.url }
    assert_redirected_to vote_vote_path(assigns(:vote_vote))
  end

  test "should destroy vote_vote" do
    assert_difference('Vote::Vote.count', -1) do
      delete :destroy, id: @vote_vote
    end

    assert_redirected_to vote_votes_path
  end
end

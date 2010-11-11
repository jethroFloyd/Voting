class PollsController < ApplicationController
  load_and_authorize_resource
  
  # Catch :mobile format requests and serve :html templates instead.
  before_filter :override_format
  
  # GET /polls
  def index
  end

  # GET /polls/1
  def show
  end

  # GET /polls/new
  def new
  end

  # GET /polls/1/edit
  def edit
  end
  
  # POST: ...
  def sort
    params[:weight].each do |id, weight|
      @pollquestion = @poll.pollquestions.find(id)
      @pollquestion.update_attributes :weight => weight
    end
    
    respond_to do |format|
      format.html { redirect_to @poll, :notice => 'Poll was successfully ordered.' }
      format.js
    end
  end

  # POST /polls
  def create
    if @poll.save
      redirect_to(@poll, :notice => 'Poll was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /polls/1
  def update
    if @poll.update_attributes(params[:poll])
      redirect_to(@poll, :notice => 'Poll was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /polls/1
  def destroy
    @poll.destroy

    redirect_to(polls_url)
  end
  
  # GET polls/1/present
  # TODO fix failing on not having any questions
  def present
    @active_poll = ActivePoll.new do |a|
      a.poll_id = @poll.id
      a.question_id = @poll.questions.first.id
    end
    
    if @active_poll.save
      #redirect to the screen to manage the poll from, right now goes to the wrong ActivePoll(pollID)
      redirect_to(view_active_poll_path(@active_poll), :notice => 'Poll is now active for polling.')
    else
      render :action => "show"
    end
  end
end

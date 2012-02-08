class ClipsController < ApplicationController
  INTERVAL = {
    0 => 1.hour,
    1 => 1.day,
    2 => 3.days,
    3 => 1.week,
    4 => 2.weeks,
    5 => 1.month,
    6 => 2.months,
    7 => 4.months
  }

  # 1 /clips
  # GET /clips.json
  def index
    @clips = Clip.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clips }
    end
  end

  # GET /clips/1
  # GET /clips/1.json
  def show
    @clip = Clip.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @clip }
    end
  end

  def nextup
    @clips = Clip.all.find_all do |clip|
      Time.now - clip.updated_at > INTERVAL[clip.status]
    end
    render 'index'
  end

  def next
    @clip = Clip.all.find do |clip|
      Time.now - clip.updated_at > INTERVAL[clip.status]
    end
    @word = @clip.word
    render template: 'words/show'
  end

  # GET /clips/new
  # GET /clips/new.json
  def new
    @clip = Clip.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @clip }
    end
  end

  # GET /clips/1/edit
  def edit
    @clip = Clip.find(params[:id])
  end

  # POST /clips
  # POST /clips.json
  def create
    @clip = Clip.new(params[:clip])

    if @clip.save
      redirect_to word_path(@clip.word) , flash: {notice: "added #{@clip.word.entry}"}
    else
      redirect_to word_path(@clip.word), flash: {error: "Error"}
    end
  end

  # PUT /clips/1
  # PUT /clips/1.json
  def update
    @clip = Clip.find(params[:id])

    respond_to do |format|
      if @clip.update_attributes(params[:clip])
        format.html { redirect_to @clip, notice: 'Clip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @clip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clips/1
  # DELETE /clips/1.json
  def destroy
    @clip = Clip.find(params[:id])
    @clip.destroy

    respond_to do |format|
      format.html { redirect_to clips_url }
      format.json { head :no_content }
    end
  end
end

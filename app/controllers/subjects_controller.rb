class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with name: "emu", password: "123"
  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.all
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
  end




  # POST /subjects
  # POST /subjects.json
  def create
  @subject = Subject.new(subject_params)

  subject_nam = params[:subject][:subject_name]
  semester_no = params[:subject][:semester_no]

  #semester_nos = params[:subject][:subject_name]

    err = false
    unless semester_nos.blank?
    semester_no.each do |semester|
      @subjects = Subject.new({semester_no: semester, subject_name: subject_nam})
      unless @subjects.save
        err = true
      end
    end
      else err = true
    end


    respond_to do |format|

      if !err
        format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
        format.json { render action: 'show', status: :created, location: @subject }
      else
        format.html { render action: 'new' }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update

    @subject = Subject.find(params[:id])
    semester_no = params[:subject][:semester_no]
    subject_name = @subject.subject_name

    err = false
    semester_no.each do |semester|
      unless Subject.exists?({semester_no: semester, subject_name: subject_name})
        @subject = Subject.new({semester_no: semester, subject_name: subject_name})
        unless @subject.save
          err = true
        end
      end
    end

    respond_to do |format|
      if !err
        format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:subject_name,{:semester_no => []})
    end
end



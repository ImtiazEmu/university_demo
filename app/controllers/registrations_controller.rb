class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]

  # GET /registrations
  # GET /registrations.json
  def index
    @registrations = Registration.all
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show
  end

  # GET /registrations/new
  def new
    @registration = Registration.new
    #subject = Subject.all
    #Use val to find records

    #@options = subject.collect{|x| "#{x.subject_name}" }

    @options = []
  end

  # GET /registrations/1/edit
  def edit
    @registration = Registration.find(params[:id])
  end

  # POST /registrations
  # POST /registrations.json
  def create
    #@registration = Registration.new(registration_params)

    subject = Subject.all
    #Use val to find records

    @options = subject.collect{|x| "#{x.subject_name}" }

    subs = ["subject_no_1","subject_no_2","subject_no_3","subject_no_4","subject_no_5"]
    student_id_no = params[:registration][:student_id_card_no]
    student_nam = params[:registration][:student_name]
    semester_no = params[:registration][:semester_no]
    subject_nam = params[:registration][:subject_name]

    err = false
      @registration = Registration.new({semester_no: semester_no, student_name: student_nam, student_id_card_no: student_id_no, subject_no_1: subject_nam[0], subject_no_2: subject_nam[1], subject_no_3: subject_nam[2], subject_no_4: subject_nam[3], subject_no_5: subject_nam[4] })
      unless @registration.save
        err = true
      end

    respond_to do |format|
      if @registration.save
        format.html { redirect_to @registration, notice: 'Registration was successfully created.' }
        format.json { render action: 'show', status: :created, location: @registration }
      else
        format.html { render action: 'new' }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registrations/1
  # PATCH/PUT /registrations/1.json
  def update

    student_id_no = params[:registration][:student_id_card_no]
    student_nam = params[:registration][:student_name]
    semester_no = params[:registration][:semester_no]
    subject_nam = params[:registration][:subject_name]

    err = false
    Registration.where(:student_id_card_no => student_id_no).destroy_all
    @registration = Registration.new({semester_no: semester_no, student_name: student_nam, student_id_card_no: student_id_no, subject_no_1: subject_nam[0], subject_no_2: subject_nam[1], subject_no_3: subject_nam[2], subject_no_4: subject_nam[3], subject_no_5: subject_nam[4] })
      unless @registration.save
      err = true
      end

    respond_to do |format|
      if !err
        format.html { redirect_to @registration, notice: 'Registration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1
  # DELETE /registrations/1.json
  def destroy
    @registration.destroy
    respond_to do |format|
      format.html { redirect_to registrations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registration
      @registration = Registration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registration_params
      params.require(:registration).permit(:student_id_card_no, :student_name, :semester_no, :subject_no_1, :subject_no_2, :subject_no_3, :subject_no_4, :subject_no_5)
    end
end

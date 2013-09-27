class RegistersController < ApplicationController
  before_action :set_register, only: [:show, :edit, :update, :destroy]

  # GET /registers
  # GET /registers.json
  def index
    @registers = Register.all
  end

  # GET /registers/1
  # GET /registers/1.json
  def show
  end

  # GET /registers/new
  def new
    @register = Register.new
    @options = []
  end

  # GET /registers/1/edit
  def edit
    @register = Register.find(params[:id])
    subject = Subject.find_all_by_semester_no(@register.semester_no)
    #Use val to find records
    @options = subject.collect{|x| "#{x.subject_name}"}
  end

  # POST /registers
  # POST /registers.json
  def create
    @register = Register.new(register_params)
    #@register = Register.find(params[:id])
    subject = Subject.find_all_by_semester_no(@register.semester_no)
    #Use val to find records

    @options = subject.collect{|x| "#{x.subject_name}" }

    student_id_no = params[:register][:student_id_card]
    semester_no = params[:register][:semester_no]
    subject_nam = params[:register][:subject_name]

    err = false
    if subject_nam.blank?
      err = true
    else
      subject_nam.each do |i|
        @register = Register.new({semester_no: semester_no, student_id_card: student_id_no, subject_name: i})
        unless @register.save
          err = true
        end
      end
    end

    respond_to do |format|
      if !err
        format.html { redirect_to @register, notice: 'Register was successfully created.' }
        format.json { render action: 'show', status: :created, location: @register }
      else
        format.html { render action: 'new' }
        format.json { render json: @register.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registers/1
  # PATCH/PUT /registers/1.json
  def update

    student_id_no = params[:register][:student_id_card]
    semester_no = params[:register][:semester_no]
    subject_nam = params[:register][:subject_name]

    #err = false
    #Register.where(:semester_no => semester_no).destroy
    err = false
    subject_nam.each do |i|
      @register = Register.new({semester_no: semester_no, student_id_card: student_id_no, subject_name: i})
      unless @register.save
        err = true
      end
    end


    respond_to do |format|
      if !err
        format.html { redirect_to @register, notice: 'Register was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @register.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registers/1
  # DELETE /registers/1.json
  def destroy
    @register.destroy
    respond_to do |format|
      format.html { redirect_to registers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_register
      @register = Register.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def register_params
      params.require(:register).permit(:semester_no, :subject_name, :student_id_card)
    end
end

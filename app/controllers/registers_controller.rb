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
    @subject_options = []
  end

  # GET /registers/1/edit
  def edit
    @register = Register.find(params[:id])

    subject = Subject.find_all_by_semester_no(@register.semester_no)
    @subject_options = subject.collect { |x| "#{x.subject_name}" }
    @previous_subjects = []
    @registration = Register.all
    @registration.each do |element|
      if element.student_id_card == @register.student_id_card
        if element.semester_no == @register.semester_no
          @subject_options.delete(element.subject_name)
          @previous_subjects.push(element.subject_name)
        end
      end
    end

  end

  # POST /registers
  # POST /registers.json
  def create
    @register = Register.new(register_params)
    #@register = Register.find(params[:id])
    subject = Subject.find_all_by_semester_no(@register.semester_no)          #find subjects from SUBJECT table based on semester_no
    #Use val to find records
    @previous_subjects = []                                                   #subjects that are already taken to this semester
    @subject_options = subject.collect { |x| "#{x.subject_name}" }            #subjects available to take in this semester
    @registration = Register.all
    @registration.each do |element|                                           #listing the available & editable subjects
      if element.student_id_card == @register.student_id_card
        if element.semester_no == @register.semester_no
          @subject_options.delete(element.subject_name)
          @previous_subjects.push(element.subject_name)
        end
      end
    end

    previous_subjects = @previous_subjects

    # finding the subjects belongs to the unique ID card holder student & for a specific semester
    student_id_no = @register.student_id_card
    semester_no = @register.semester_no
    subject_nam = @register.subject_name

    unless (subject_nam.blank?)                            # check which subjects to add/destroy in/from the DB
      subjects_to_add = subject_nam - previous_subjects
      subjects_to_destroy = previous_subjects - subject_nam
    else
      subjects_to_destroy = previous_subjects
      subjects_to_add = nil
    end

    # adding the subjects
    err = false
    unless subjects_to_add.blank?
      temp_subject = []
      subjects_to_add.each do |subject|
        @register = Register.new({semester_no: semester_no, student_id_card: student_id_no, subject_name: subject})
        if @register.save
          temp_subject.push (subject)
        else err = true
        end
      end
      temp_subject.each do |subject|
        @subject_options.delete(subject)
        @previous_subjects.push(subject)
      end
    end

    # deleting the subjects
    unless subjects_to_destroy.blank?
      temp_subject = []
      subjects_to_destroy.each do |subject|
        Register.destroy_all(:student_id_card => student_id_no, :semester_no => semester_no, :subject_name => subject)
        temp_subject.push(subject);
      end
      temp_subject.each do |subject|
        @previous_subjects.delete(subject)
        @subject_options.push(subject)
      end
    end

    respond_to do |format|
      if !err
        if subject_nam.blank?
          format.html { redirect_to action: 'index', notice: 'Register was successfully updated.' }
        else
          format.html { redirect_to action: 'index', notice: 'Register was successfully updated.' }
        end

        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @register.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registers/1
  # PATCH/PUT /registers/1.json
  def update

    @register = Register.find(params[:id])

    subject = Subject.find_all_by_semester_no(@register.semester_no)
    #Use val to find records
    @previous_subjects = []
    @subject_options = subject.collect { |x| "#{x.subject_name}" }
    @registration = Register.all
    @registration.each do |element|
      if element.student_id_card == @register.student_id_card
        if element.semester_no == @register.semester_no
          @subject_options.delete(element.subject_name)
          @previous_subjects.push(element.subject_name)
        end
      end
    end

    previous_subjects = @previous_subjects

    # finding the subjects belongs to the unique ID card holder student & for a specific semester
    student_id_no = @register.student_id_card
    semester_no = params[:register][:semester_no]
    subject_nam = params[:register][:subject_name]

    unless (subject_nam.blank?)
      subjects_to_add = subject_nam - previous_subjects
      subjects_to_destroy = previous_subjects - subject_nam
    else
      subjects_to_destroy = previous_subjects
      subjects_to_add = nil
    end

    # adding the subjects
    err = false
    unless subjects_to_add.blank?
      temp_subjects = []
      subjects_to_add.each do |subject|
          @register = Register.new({semester_no: semester_no, student_id_card: student_id_no, subject_name: subject})
          if @register.save
            temp_subjects.push (subject)
          else err = true
          end
      end
      temp_subjects.each do |subject|
        @subject_options.delete(subject)
        @previous_subjects.push(subject)
      end
    end

    # deleting the subjects
    unless subjects_to_destroy.blank?
      temp_subjects = []
      subjects_to_destroy.each do |subject|
        Register.destroy_all(:student_id_card => student_id_no, :semester_no => semester_no, :subject_name => subject)
        temp_subjects.push(subject);
      end
      temp_subjects.each do |subject|
        @previous_subjects.delete(subject)
        @subject_options.push(subject)
      end
    end

      respond_to do |format|
        if !err
          if subject_nam.blank?
            format.html { redirect_to action: 'index', notice: 'Register was successfully updated.' }
          else
            format.html { redirect_to action: 'index', notice: 'Register was successfully updated.' }
          end

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
      format.html { redirect_to @register }
      format.json { head :no_content }
    end
  end


  private
  # Use callbacks to share common
  # setup or constraints between actions.
  def set_register
    @register = Register.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def register_params
    params.require(:register).permit(:semester_no, {:subject_name => []}, :student_id_card)
  end
end

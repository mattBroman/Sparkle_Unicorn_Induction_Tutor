class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :edit, :update, :destroy]

  # GET /sections
  # GET /sections.json
  def index
    if params[:enroll]
      session[:page] = 'Enroll'
      session[:back] = view_enroll_path(true)
      @sections = Section.all
      @enroll = true
    else
      session[:page] = 'Sections'
      session[:back] = sections_path
      @sections = admin? ? Section.all : User.find(session[:user_id]).sections
    end
  end

  # GET /sections/1
  # GET /sections/1.json
  def show
    session[:back] = section_path(@section)
    @users = (teacher?) ? @section.users : nil
    @tags = @section.tags
    @unenroll = true
    
    @questions = []
    @tags.each do |t|
      @questions += t.questions
    end
  end

  # GET /sections/new
  def new
    @section = Section.new
    @tags = Tag.where(user_id: session[:user_id])
    @new = true
  end

  # GET /sections/1/edit
  def edit
    @tags = Tag.where(user_id: session[:user_id])
  end

  # POST /sections
  # POST /sections.json
  def create
    @section = Section.new(section_params)
    @users = User.where(id: params[:users])
    @section.users << @users
    if params[:tags]
      @tags = Tag.where(id: params[:tags].keys)
      @section.tags << @tags
    end

    respond_to do |format|
      if @section.save
        format.html { redirect_to session[:back], notice: 'Section was successfully created.' }
        format.json { render :show, status: :created, location: @section }
      else
        format.html { render :new }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sections/1
  # PATCH/PUT /sections/1.json
  def update
    respond_to do |format|
      if @section.update(section_params)
        @section.tags.destroy_all
        if params[:tags]
          @tags = Tag.where(id: params[:tags].keys)
          @section.tags << @tags
        end
        format.html { redirect_to session[:back], notice: 'Section was successfully updated.' }
        format.json { render :show, status: :ok, location: @section }
      else
        format.html { render :edit }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    @section.destroy
    respond_to do |format|
      format.html { redirect_to session[:back], notice: 'Section was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def enroll
    @user = User.where(id: params[:user_id])
    @section = Section.find(params[:section_id])
    @section.users << @user
    flash[:notice] = "Successfully enrolled in #{@section.name}"
    redirect_to session[:back]
  end
  
  def unenroll
    @user = User.where(id: params[:user_id])
    name = @user.name
    @section = Section.find(params[:section_id])
    @section.users.delete(@user)
    flash[:notice] = "Removed #{name} from #{@section.name}"
    redirect_to session[:back]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def section_params
      params.require(:section).permit(:name, :description, :users => [], :tags => [])
    end
end


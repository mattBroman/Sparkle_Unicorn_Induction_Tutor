class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    session[:page] = 'Users'
    session[:back] = users_path
    @users = admin? ? User.all : nil
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if @user.id == session[:user_id]
      session[:page] = 'User'
      session[:back] = user_path(session[:user_id])
    end
    @sections = @user.sections
    @sections = @sections.empty? ? nil : @sections
  end

  # GET /users/new
  def new
    session[:page] = "Sign Up"
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @sections = Section.where(id: params[:sections])
    @user.sections << @sections

    respond_to do |format|
      if @user.save
        log_in @user
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        @sections = Section.where(id: params[:sections])
        @user.sections.destroy_all
        @user.sections << @sections
        format.html { redirect_to session[:back], notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    user = User.find(params[:id])
    user.destroy!
    respond_to do |format|
      format.html { redirect_to session[:back], notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :role, :sections => [])
    end
end

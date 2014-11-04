class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy ]
  before_action :authenticate_user!

  # GET /tags
  # GET /tags.json
  def index
    @users = User.all.order("provider","uid")

  end

  # GET /tags/1
  # GET /tags/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /tags/new
  def new
    @user = User.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  # POST /tags.json
  def create
    @user = User.new(tag_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @tag, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    respond_to do |format|
      if @user.update(tag_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to "/users#index" }
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
    params.require(:user).permit(:id, :provider, :uid, :name)
  end
end

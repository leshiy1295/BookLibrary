class UsersController < ApplicationController
  skip_before_filter :require_login, :only=> [:index, :show, :new, :create]
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
	@flag=true
	if params[:user][:login]=="" || params[:user][:password]=="" 
	   kol=0
	   error_list=""
	   if params[:user][:login]==""
		 kol+=1
		 error_list+=kol.to_s+t(:") Field 'login' is not filled\n")
	   end
	   if params[:user][:password]==""
		 kol+=1
		 error_list+=kol.to_s+t(:") Field 'password' is not filled\n") 
	   end 
	   puts kol.to_s+t(:" error(s) prohibited this user from being saved:")+ error_list
	   @user=User.new
	   respond_to do |format|
          format.html {flash[:notice]= kol.to_s+t(:" error(s) prohibited this user from being saved:")+"\n"+ error_list; render action: "new"}
          format.json { render json: kol.to_s+t(:" error(s) prohibited this user from being saved:")+ error_list}
        end
    else	 
	    @user = User.new(params[:user])
    	respond_to do |format|
		  if @user.save
			format.html { flash[:notice]= t(:"User was successfully created"); redirect_to @user}
			format.json { render json: @user, status: :created, location: @user }
		  else
			format.html { render action: "new"}
			format.json { render json: @user.errors, status: :unprocessable_entity }
		  end
		end
	end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    if params[:user][:login]=="" || params[:user][:password]=="" 
	   kol=0
	   error_list=""
	   if params[:user][:login]==""
		 kol+=1
		 error_list+=kol.to_s+t(:") Field 'login' is not filled\n")
	   end
	   if params[:user][:password]==""
		 kol+=1
		 error_list+=kol.to_s+t(:") Field 'password' is not filled\n") 
	   end 
	   puts kol.to_s+t(:" error(s) prohibited this user from being saved:")+ error_list
	   @user = User.find(params[:id])
	   respond_to do |format|
          format.html { flash[:notice]= kol.to_s+t(:" error(s) prohibited this user from being saved:")+"\n"+ error_list; render action: "show"; }
          format.json { render json: kol.to_s+t(:" error(s) prohibited this user from being saved:")+ error_list}
        end
    else
		@user = User.find(params[:id])

		respond_to do |format|
		  if @user.update_attributes(params[:user])
			format.html { flash[:notice]= t(:"User was successfully updated"); redirect_to @user }
			format.json { head :no_content }
		  else
			format.html { render action: "edit" }
			format.json { render json: @user.errors, status: :unprocessable_entity }
		  end
		end
	end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end

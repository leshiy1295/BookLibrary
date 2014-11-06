class SessionsController < ApplicationController
	skip_before_filter :require_login, :only=> [:new, :create]
  def new 
  end

  def create
	cur=current_user
	puts params[:session]
    user = User.authenticate(params[:session][:login], params[:session][:password])
	if user.nil?
	  flash[:notice]=t(:"Wrong data!!!")
	else
	  if cur
		session[cur]=nil
	  end
	  session[:current_user_id]=user.id
      user.save
    end
	render :action=> "new"
  end

  def destroy
	@_current_user=session[:current_user_id]=nil
    render :action=>"new"
  end
end


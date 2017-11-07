class SessionsController < ApplicationController
    def new
    end

    def create

        user = User.find_by(email: session_params[:email])

         if user && user.authenticate(session_params[:password])
             session[:user_id] = user.id
             flash[:notice] = "Thank you for signing in."
             redirect_to root_path
          else
            render :new, alert: "wrong username"
          end


    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Signed Out"
    end

    private

    def session_params
        params.require(:session).permit(:email, :password)
    end

end

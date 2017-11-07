class Admin::ApplicationController < ApplicationController
    before_action :authenticate_admin
    before_action :authorize_admin!

    private
    def :authorize_admin!
        redirect_to_root_path alert: "Access denied!" unless current_user.is_admin?
    end
end

class ContactController < ApplicationController
    def contact_us
    end

    def thank_you
        @name = params[:name]
    end
end

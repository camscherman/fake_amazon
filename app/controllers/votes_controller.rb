class VotesController < ApplicationController
    before_action :find_vote,only:[:update, :destroy]
    def create
        review = Review.find params[:review_id]
        vote = Vote.new( is_up: params[:is_up],
                        user: current_user,
                        review: review )
        if vote.save
            redirect_to review.product, notice: 'Thank you'
        else
            redirect_to review.product, notice: "Cannot vote"
        end                    
    end

    def update
        @vote.update( is_up: params[:is_up] )
        redirect_to @vote.review.product

    end

    def destroy
        @vote.destroy
        redirect_to @vote.review.product
    end

    private
    def find_vote
        @vote = Vote.find( params[:id] )
    end
end

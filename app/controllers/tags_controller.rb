class TagsController < ApplicationController
    before_action :find_tag, only:[:show]
    def index
        @tags = Tag.all
    end

    def show
        @products = @tag.products
    end

    def find_tag
        @tag = Tag.find(params[:id])
    end

end

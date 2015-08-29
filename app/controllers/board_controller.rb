class BoardController < ApplicationController
    
    before_action :authenticate_user!, only: [:main]
    
    def main
        
        @post_all = Post.order("id desc").all
        
    end
    
    def write
        
        Post.create(user_id: current_user.id,
                    context: params[:context],
                    color: 0,
                    like_count: 0,
                    );
                    
        
        render :text => ""
    end
    
    
end


class BoardController < ApplicationController
    
    before_action :authenticate_user!, only: [:main]
    
    def main
        
        @post_first = Post.last
        
        @post_all = Post.where("id != #{@post_first.id}").order("id desc").all             
       
        
    end
    
    def write
        
        post = Post.create(user_id: current_user.id,
                    context: params[:context],
                    color: 0,
                    like_count: 0,
                    );
                    
        
        render :json => {
                         context: post.context,
                         color: post.color,
                         like_count: post.like_count,
                         reply_count: post.reply.size}
        
        # render :object => @post
        
    end
    
    
end


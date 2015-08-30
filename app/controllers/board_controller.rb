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
                    like_count: 0)
        
        render :json => {
                         p_id: post.id,
                         context: post.context,
                         color: post.color,
                         like_count: post.like_count,
                         reply_count: post.reply.size}
        # render :object => @post
    end
    
    def detail
        
        @selected_post = Post.find(params[:id])
        @reply_all = @selected_post.reply.order('id desc').all
        
    end
    
    def reply
        
        post = Reply.create(user_id: current_user.id,
                             post_id: params[:id],
                             context: params[:context],
                             like_count: 0)

        render :json => {
                         context: post.context,                         
                         like_count: post.like_count,
                         reply_count: Post.find(params[:id]).reply.count 
                         }
                         
                         #user_id: post.id,                
                         
    end
    
    def like        
        
        user = current_user
        post = Post.find(params[:post_id]);       
        
        like_post = LikePost.where(:user_id => user , :post_id => post).take
        
        if like_post.nil?
            
            LikePost.create( user_id: user.id,
                         post_id: post.id)
            post.like_count += 1
            post.save
        else
            like_post.delete
            post.like_count -= 1
            post.save
        end
        
        render :text => post.like_count
    end
    
end


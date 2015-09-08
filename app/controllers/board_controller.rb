class BoardController < ApplicationController
    
    before_action :authenticate_user!, only: [:main]
    
    $COLOR_ARRAY = ["#EE3C39",
                    "#50266B",
                    "#094A78",
                    "#F16624",
                    "#006040",
                    "#552B0F",
                    "#2D2D2D"]
    # $COLOR_HASH = {"#EE3C39" => 0,
    #                 "#50266B" => 1,
    #                 "#094A78" => 2,
    #                 "#F16624" => 3,
    #                 "#006040" => 4,
    #                 "#552B0F" => 5,
    #                 "#2D2D2D" => 6}
    
    def main
        @board = Board.where(:description => params[:id]).take
        if @board.nil?
            @board = Board.find(1)
        end
        @post_all = @board.posts
        
        if @post_all.count != 0
            @post_first = @post_all.last
            @post_reminder = @post_all.where("id != #{@post_first.id}").order("id desc")
        end
        
        # @post_first = Post.last 
        # if !@post_first.nil?
        #     @post_all = Post.where("id != #{@post_first.id}").order("id desc").all            
        # else
        #     @post_all = Post.all
        # end
    end
    
    def write
        p = Post.create(user_id: current_user.id,
                    board_id: params[:board],
                    context: params[:context],
                    color: $COLOR_ARRAY.index(params[:color]),
                    like_count: 0)
        render :json => {:post => p,
                         :reply_count => p.replies.count}
    end
    
    def detail
        @selected_post = Post.find(params[:id])
        @reply_all = @selected_post.replies.order('id desc').all
    end
    
    def reply
        r = Reply.create(user_id: current_user.id,
                         post_id: params[:id],
                         context: params[:context],
                         like_count: 0)

        render :json => {
                         :reply => r,
                         :reply_count => Post.find(params[:id]).replies.count 
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


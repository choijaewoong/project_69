class BoardController < ApplicationController
    before_action :authenticate_user!, only: [:main]
    
    $CATEGORY_NAME = ["78", "18", "4", "100"]
    $COLOR_ARRAY = ["#EE3C39",
                    "#50266B",
                    "#094A78",
                    "#F16624", 
                    "#006040",
                    "#552B0F",
                    "#2D2D2D"]
    $board_show_count = 10
    
    def main
        @board = Board.where(:description => params[:id]).take
        if @board.nil?
            @board = Board.where(:description => $CATEGORY_NAME[0]).take
        end
        
        @post_all = @board.posts
        @post_part = @board.posts.order("id desc").limit($board_show_count)        
        
        if @post_all.empty?
           @last_post_id = 0
        else 
           @last_post_id = @post_part.last.id
        end        
        
        # @last_post_id = @post_all.first.id
        # if @post_all.count != 0
        #     @post_first = @post_all.last
        #     @post_reminder = @post_all.where("id != #{@post_first.id}").order("id desc")
        # end
        
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
    
    def more_post
        
        post_array = Board.find(params[:board_id]).posts.where("id < #{params[:last_id]}").order("id desc").limit(params[:count])
        
        color_array = Array.new
        reply_count_array = Array.new
        
        post_array.each do |post|
            
            color_array.append($COLOR_ARRAY[post.color])
            reply_count_array.append(post.replies.count)
            
        end
        
        next_check = true
        next_id = params[:last_id].to_i - $board_show_count
        if Board.find(params[:board_id]).posts.where("id < #{next_id}").empty?
            next_check = false        
        end
        render :json => { :post_array => post_array,
                          :color_array => color_array,
                          :reply_count_array => reply_count_array,
                          :next_check => next_check}
    end
end


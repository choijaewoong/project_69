class BoardController < ApplicationController
    
    before_action :authenticate_user!, only: [:main]
    
    def main
        
        # 정렬 방법 설정 변수
        if params[:sorting].nil?
            @sorting = "id"
        else 
            @sorting = params[:sorting]
        end
        
        @board = Board.where(:description => params[:id]).take ||
        @board = Board.where(:description => @CATEGORY_NAME[0]).take

        @post_all = @board.posts
        if @post_all.empty?
            @last_post_index = 0
            @sorted_posts = Array.new
            @showed_posts = Array.new
        else 
            # 정렬 방법
            case @sorting
            when "id"
                @sorted_posts = @board.posts.order("id desc")
                @showed_posts = @sorted_posts.limit(@board_show_count)                
            when "like"
                @sorted_posts = @board.posts.order("like_count desc, id desc")
                @showed_posts = @sorted_posts.limit(@board_show_count)
            when "color"
                @sorted_posts = @board.posts.order("color, id desc")
                @showed_posts = @sorted_posts.limit(@board_show_count)
            else
                @sorted_posts = @board.posts.order("id desc")
                @showed_posts = @sorted_posts.limit(@board_show_count)
            end            
            @last_post_index = @showed_posts.count
        end 
    end
    
    def write
        p = Post.create(user_id: current_user.id,
                    board_id: params[:board],
                    context: params[:context],
                    color: @COLOR_ARRAY.index(params[:color]),
                    like_count: 0)
        render :json => {:post => p,
                         :reply_count => p.replies.count}
    end
    
    def detail
        @selected_post = Post.find(params[:id])
        @reply_all = @selected_post.replies.order('id desc').all
        
        @post_color = @COLOR_ARRAY[@selected_post.color]
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
        
        index = params[:last_index].to_i
        
        case params[:sorting]
        when "id"
            sorted_posts = Board.find(params[:board_id]).posts.order("id desc")
        when "like"
            sorted_posts = Board.find(params[:board_id]).posts.order("like_count desc, id desc")
        when "color"
            sorted_posts = Board.find(params[:board_id]).posts.order("color, id desc")
        else
            sorted_posts = Board.find(params[:board_id]).posts.order("id desc")
        end 
        post_array = sorted_posts[index...(index+@board_show_count)]
        # post_array = Board.find(params[:board_id]).posts.where("id < #{params[:last_id]}").order("id desc").limit(@board_show_count)
        
        color_array = Array.new
        reply_count_array = Array.new

        post_array.each do |post|
            color_array.append(@COLOR_ARRAY[post.color])
            reply_count_array.append(post.replies.count)
        end
        
        index += post_array.count
        next_check = true
        if sorted_posts[index].nil?
            next_check = false        
        end
        render :json => { :post_array => post_array,
                          :color_array => color_array,
                          :reply_count_array => reply_count_array,
                          :next_check => next_check,
                          :last_index => index}
    end
    
end


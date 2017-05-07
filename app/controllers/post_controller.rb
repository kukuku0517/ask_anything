class PostController < ApplicationController
  before_filter :authenticate_user!, :except =>[:index]
 
  def index
    @posts = Post.all
    @hashtags = Hashtag.all
  end 
  
  def write
  
  end
  
  def update
  post = Post.new
  post.title = params[:title]
  post.content = params[:content]
  post.visit = 0
  post.save
  
  hashtags = params[:hashtags].split(",")
  hashtags.each do |hashtag|  
    hash = Hashtag.find_or_create_by(name: hashtag)
    if post.hashtags.where(name: hashtag).empty?
       post.hashtags << hash
    end
  end
  
  
  user = current_user
  user.posts << post
  redirect_to '/'
  end
  
  def content
    @post = Post.find(params[:id])
    @post.visit+=1
    @post.save
    @replys = @post.replys.where(re_reply: nil)
    @re_replys = @post.replys.where.not(re_reply: nil)
    #@user = User.find(post.user_id)
  end
  
  def reply
    reply = Reply.new
    reply.text = params[:content]
    reply.user_id = current_user.id
    reply.post_id = params[:id]
    reply.save
    
    redirect_to :back
  end
  
  def re_reply
    reply = Reply.new
    reply.text = params[:content]
    reply.user_id = current_user.id
    reply.post_id = params[:post_id]
    reply.re_reply = params[:reply_id]
    reply.save
    
    redirect_to :back
  end
  
  def search
    if params[:id].to_i!= 0 
      @posts = Hashtag.find(params[:id]).posts
    else
      hashtag = Hashtag.where(name: params[:text])
      if hashtag.exists?
        @posts = hashtag.first.posts
        puts @posts
      else
        @posts = nil
        puts 2
      end
    end
    @hashtags = Hashtag.all
  end
  
  def edit
    @post = Post.find(params[:id])
    
    
    @hashtags=""
    @post.hashtags.each do |hash|
      @hashtags << hash.name+" "
    end
    
      
    
  end
  
  def edit_update
    post = Post.find(params[:id])
    post.title = params[:title]
    post.content = params[:content]
    post.visit = 0
    post.save
    
    hashtags = params[:hashtags].split(",")
    post.hashtags.delete_all
    hashtags.each do |hashtag|  
      hash = Hashtag.find_or_create_by(name: hashtag)
      #if post.hashtags.where(name: hashtag).empty?
        post.hashtags << hash
      #end
    end
    redirect_to :root
  end
  
  def delete
    post = Post.find(params[:id])
    post.destroy
    redirect_to :root
  end
  
end

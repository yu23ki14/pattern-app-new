class Presentation::PostsController < ApplicationController
  #before_action :set_subdomain
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  def show
    @comment = Presentation::PostComment.new
    if @post.publish?
      @comments = @post.presentation_post_comments.includes(:user).order(id: "DESC")
      @related_patterns = @post.patterns
      @related_posts = @post.related_posts.page(params[:page]).per(4)
      if user_signed_in?
        @stock = Presentation::Stock.where(presentation_post_id: @post.id, user_id: current_user.id)
      end
    elsif current_user.id != @post.user_id || !user_signed_in? && @post.state == 0
      redirect_back(fallback_location: root_path, notice: "記事は存在しません。")
    end
  end
  
  def new
    @post = Presentation::Post.new
    @patterns = Pattern.where(language_id: 3).order(:pattern_no)
  end
  
  def  create
    @post = Presentation::Post.new(presentation_post_params)
    if @post.state == "publish"
      if params[:related_patterns].blank?
        redirect_to new_presentation_post_path(@post), notice: "関連パターンは一つ以上登録してください。" and return
      end
      if @post.save
        patterns = JSON.parse(params[:related_patterns])
        patterns.each do |pattern|
          @related_pattern = Presentation::PostPatternRelate.new(presentation_post_id: @post.id, pattern_id: pattern)
          if @related_pattern.save
          else
            @post.destroy
            redirect_to new_presentation_post_path and return
          end
        end
        redirect_to @post and return
      else
        redirect_to new_presentation_post_path and return
      end
    elsif @post.state == "draft"
      if @post.save
        redirect_to @post and return
      else
        redirect_to new_presentation_post_path and return
      end
    end
  end
  
  def edit
    gon.post_content = @post.content
    @patterns = Pattern.where(language_id: 3).order(:pattern_no)
    @related_patterns = @post.patterns
  end
  
  def update
    if @post.update(presentation_post_params)
      @post.presentation_post_pattern_relates.each do |related_pattern|
        related_pattern.destroy
      end
      patterns = JSON.parse(params[:related_patterns])
      patterns.each do |pattern|
        @related_pattern = Presentation::PostPatternRelate.new(presentation_post_id: @post.id, pattern_id: pattern)
        if @related_pattern.save
        else
          @post.destroy
          redirect_to new_presentation_post_path and return
        end
      end
      redirect_to @post and return
    else
      redirect_to new_presentation_post_path and return
    end
  end
  
  def destroy
    if @post.destroy
      redirect_to presentation_root_path, notice: "削除しました。"
    else
      redirect_to @post, notice: "削除できませんでした。もう一度試してください。"
    end
  end
  
  def get_web_reference
    link = params[:url]
    
    if Rails.env.production?
      data = `python3.6 /home/manabu/pytest/test1.py #{link}`
      data = data.gsub(/\\u([\da-fA-F]{4})/) { [$1].pack('H*').unpack('n*').pack('U*') }
    else
      data = `python /home/ubuntu/pytest/test1.py`
    end
    
    data = JSON.parse(data)
    title = data["title"]
    thumb = data["thumb"]
    author = data["author"]
    
    respond_to do |format|
      format.json {
        render json: {reference: author, title: title, link: link, thumb: thumb}, status: 200
      }
    end
  end
  
  private
    def presentation_post_params
      params.require(:presentation_post).permit(:user_id, :title, :reference, :link, :content, :thumb_image, :state, :post_type, :option)
    end
    
    def set_post
      @post = Presentation::Post.find(params[:id])
    end
end

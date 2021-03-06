class Presentation::WelcomeController < ApplicationController
  #before_action :set_subdomain
  
  def index
    if cookies["visited"] == "t"
      @patterns = Pattern.where(language_id: 3)
      @visited = true
      if user_signed_in?
        following_post_ids = []
        recommended_post_ids = []
        last_post_id = Presentation::Post.last.id
        last_post_id.times do |i|
          recommended_post_ids.push(i + 1)
        end
        recommended_post_ids = recommended_post_ids.reverse!
        
        @following_patterns = @user.presentation_following_patterns
        if @following_patterns.present?
          @following_patterns.each do |pattern|
            following_post_ids += pattern.presentation_related_posts.pluck(:id)
          end
          following_post_ids = following_post_ids.sort.last(10).sort {|a, b| b <=> a }
          recommended_post_ids = (recommended_post_ids - following_post_ids)
          
          post_ids = following_post_ids + recommended_post_ids
          @result= Presentation::Post.publish.where(id: post_ids).with_attached_thumb_image.includes(:patterns).sort_by{ |o| post_ids.index(o.id)}
          @posts = Kaminari.paginate_array(@result).page(params[:page]).per(15)
        else
          post_ids = recommended_post_ids
          @result= Presentation::Post.publish.where(id: post_ids).with_attached_thumb_image.includes(:patterns).sort_by{ |o| post_ids.index(o.id)}
          @posts = Kaminari.paginate_array(@result).page(params[:page]).per(15)
        end
        
        if current_user.presentation == false
          current_user.update_attribute(:presentation, true)
        end
        
      else
        @posts = Presentation::Post.publish.with_attached_thumb_image.includes(:patterns).order('created_at DESC').page(params[:page]).per(15)
      end
    else
      cookies.permanent["visited"] = "t"
    end
  end
end
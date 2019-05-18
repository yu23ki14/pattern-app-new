module ApplicationHelper
  def default_meta_tags
    {
      #site: Settings.site.name,
      #reverse: true,    # タイトルタグ内の表記順をページタイトル|サイトタイトルの順にする
      title: "Pattern App",    #デフォルトページタイトル
      # description: ,    デフォルトページディスクリプション
      # keywords:         デフォルトページキーワード
      #canonical: request.original_url,
      #og: default_og
    }
  end
  
  def meta_page_title
    if controller_name == "posts" && action_name == "show"
      @post.title
    else
      "PresenBox"
    end
  end
  
  def meta_description
    if controller_name == "posts" && action_name == "show"
      strip_tags(@post.content.gsub("<br>", " "))
    else
      "PresenBoxは「説得的・発見的・共感的」なプレゼンテーションをつくるための具体的なコツがまとめられているキュレーションメディアです。魅力的なプレゼンはコンセプト、資料、発表への姿勢などさまざまな要素によって成り立っています。あなたのプレゼンをより魅力的にしたいときや、新しいアイディアを取り込みたいときにぜひ覗いてみてください、きっと良いアイディアに出会えます。"
    end
  end
  
  def og_image
    if controller_name == "posts" && action_name == "show"
      if @post.thumb_image.attached?
        rails_representation_url(@post.thumb_image.variant(resize: "400x400>"), only_path: true)
      elsif @post.option.present?
        JSON.parse(@post.option)["thumb"]
      else
        asset_path "pattern_img/pp/#{primary_pattern@post.patterns.first.pattern_no}.png"
      end
    else
      asset_path "logo-sq.png"
    end
  end
  
  #def default_og
  #  return if noindex?
  #  {
  #    title: :title,
  #    description: :description,
  #    type: Settings.site.meta.ogp.type,
  #    url: request.original_url,
  #    image: page_og_image,
  #    site_name: Settings.site.name,
  #    locale: 'ja_JP'
  #  }
  #end

  #def page_og_image
  #  @page_image||image_url(Settings.site.meta.ogp.image_path)
  #end
end

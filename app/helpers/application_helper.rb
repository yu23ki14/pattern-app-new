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

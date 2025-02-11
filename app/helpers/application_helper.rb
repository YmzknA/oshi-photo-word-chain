module ApplicationHelper
  def default_meta_tags
    {
      site: '推し photo word chain',
      title: '推し photo word chain',
      reverse: true,
      charset: 'utf-8',
      description: '推しPhoto Word Chainは、推しの写真をテーマにした写真共有サービスです。',
      keywords: '写真,推し',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('/assets/images/ogp.png'), # 配置するパスやファイル名によって変更すること
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
        site: '@', # アプリの公式Twitterアカウントがあれば、アカウント名を書く
        image: image_url('/assets/images/ogp.png') # 配置するパスやファイル名によって変更すること
      }
    }
  end
end

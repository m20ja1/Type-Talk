# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Seedの実行を開始します..."

# 1. ユーザーの作成 (20名)
user_data = [
  { name: "山田太郎", email: "yamada@example.com", type: "ENFP", intro: "旅行と美味しいものが大好き！" },
  { name: "佐々木次郎", email: "sasaki@example.com", type: "ISTJ", intro: "プログラミング学習中。日々の記録を投稿します。" },
  { name: "青木杏奈", email: "aoki@example.com", type: "INFJ", intro: "映画や読書が趣味。静かな場所が好きです。" },
  { name: "中村健太", email: "nakamura@example.com", type: "ENTP", intro: "新しい技術や議論が大好き！" },
  { name: "伊藤匠", email: "ito@example.com", type: "ISFP", intro: "絵を描くことと植物を育てることが日課。" },
  { name: "渡辺陸", email: "watanabe@example.com", type: "ESTJ", intro: "効率的な仕事術と筋トレにハマっています。" },
  { name: "小林悠斗", email: "kobayashi@example.com", type: "INFP", intro: "世界の不思議について考えるのが好き。" },
  { name: "加藤陽太", email: "kato@example.com", type: "INTJ", intro: "長期的な戦略を立てるのが得意。チェスが好き。" },
  { name: "石川樹", email: "ishikawa@example.com", type: "ENFJ", intro: "みんなで協力して何かを作るのが幸せ。" },
  { name: "田中結衣", email: "tanaka@example.com", type: "ISTP", intro: "バイクの修理とキャンプが趣味。道具を愛しています。" },
  { name: "木村美咲", email: "kimura@example.com", type: "ESFJ", intro: "おもてなしの心を大切にしています。料理が得意。" },
  { name: "山本あおい", email: "yamamoto@example.com", type: "ESTP", intro: "考えるより先に動くタイプ！刺激的な毎日を。" },
  { name: "斎藤凛", email: "saito@example.com", type: "INTP", intro: "論理的な矛盾を見つけるとワクワクします。" },
  { name: "吉田陽菜", email: "yoshida@example.com", type: "ENTJ", intro: "プロジェクトの指揮を執るのが得意です。" },
  { name: "長谷川理央", email: "hasegawa@example.com", type: "ISFJ", intro: "周りの人のサポートに徹するのが私のスタイル。" },
  { name: "山口つむぎ", email: "yamaguchi@example.com", type: "ESFP", intro: "人生はパーティー！楽しいことが一番。" },
  { name: "松本ほのか", email: "matumoto@example.com", type: "ENFP", intro: "自由な発想を大切にしたいです。" },
  { name: "井上愛佳", email: "inoue@example.com", type: "INFJ", intro: "人の心の機微を理解しようと努めています。" },
  { name: "藤野佑奈", email: "fujino@example.com", type: "ISTJ", intro: "コツコツと努力することが成功への近道。" },
  { name: "テスト", email: "test@example.com", type: "ENFJ", intro: "理想のコミュニティ作りを目指しています。" }
]

users = user_data.map do |data|
  User.find_or_create_by!(email_address: data[:email]) do |u|
    u.name = data[:name]
    u.password = "password"
    u.mbti_type = data[:type]
    u.introduction = data[:intro]
  end
end
puts "✅ ユーザーの作成完了 (計: #{User.count}名)"

# 2. 投稿とタグの作成 (20件)
# 各タイトルに対して、MBTIに関連しそうなタグをセットにします
post_templates = [
  { title: "初めての投稿", tags: "挨拶,初心者" },
  { title: "Railsの学習について", tags: "プログラミング,Rails,学習" },
  { title: "おすすめのカフェ", tags: "日常,カフェ,リラックス" },
  { title: "週末の創作活動", tags: "趣味,アート,週末" },
  { title: "朝活のススメ", tags: "自己啓発,朝活,健康" },
  { title: "戦略的な思考とは", tags: "ビジネス,思考法,INTJ" },
  { title: "チームワークの秘訣", tags: "仕事,組織,ENFJ" },
  { title: "メンテナンスの楽しみ", tags: "バイク,道具,こだわり" },
  { title: "手作りケーキ", tags: "料理,スイーツ,おもてなし" },
  { title: "スリルを求めて", tags: "アウトドア,挑戦,ESTP" },
  { title: "最新の科学ニュース", tags: "科学,ニュース,知的好奇心" },
  { title: "リーダーシップ論", tags: "マネジメント,ENTJ,キャリア" },
  { title: "お花の植え替え", tags: "ガーデニング,癒やし,植物" },
  { title: "フェスの思い出", tags: "音楽,イベント,最高" },
  { title: "アイデアの源泉", tags: "クリエイティブ,発想,ENFP" },
  { title: "共感の力", tags: "心理学,対人関係,INFJ" },
  { title: "習慣化のコツ", tags: "効率化,継続,ルーティン" },
  { title: "夢のコミュニティ", tags: "理想,未来,社会" },
  { title: "お気に入りのガジェット", tags: "ガジェット,テクノロジー,ISTP" },
  { title: "散歩で見つけた空", tags: "写真,風景,日常" }
]

posts = []
post_templates.each_with_index do |template, i|
  post = Post.find_or_create_by!(title: template[:title]) do |p|
    p.body = "#{template[:title]}に関するエピソードです。MBTIタイプ「#{users[i].mbti_type}」らしい視点で書いてみました。"
    p.user = users[i]
  end
  # 自作したタグ保存メソッドを呼び出し（カンマ区切りの文字列を渡す）
  post.save_tags(template[:tags])
  posts << post
end
puts "✅ 投稿とタグの紐付け完了 (投稿数: #{Post.count}件 / タグ数: #{Tag.count}種)"

# 3. コメントの作成 (60件に増量)
comment_messages = [
  "面白いですね！", "その視点はありませんでした。", "参考になります！", "私も同じタイプです。",
  "共感しました。", "続きが気になります！", "素敵ですね。", "勉強になります。",
  "今度試してみます。", "写真も見てみたいです！", "質問してもいいですか？", "応援しています。",
  "素晴らしい活動です。", "私も混ぜてください（笑）", "深いですね…", "納得の考え方です。",
  "明日の投稿も楽しみです。", "いい刺激になりました！", "カフェ情報、ありがとうございます。", "癒されました。",
  "まさにMBTIあるあるですね！", "これ、私の友達（ENTP）も同じこと言ってました。", "論理的で分かりやすいです。",
  "勇気をもらいました。", "今の私に刺さる言葉です…", "意外な一面ですね！", "整理されていて読みやすいです。",
  "これは保存版！", "やってみた感想も教えてください。", "ちょっと議論したいポイントがあります！",
  "そのバッグ、どこのですか？", "センスがいいですね。", "週末やってみます！", "効率化、大事ですよね。",
  "見てるだけでワクワクします。", "さすがリーダー！", "私もその本読みました。", "共感の嵐です。",
  "独自の哲学を感じます。", "癒やしをありがとうございます。", "まさに職人芸！", "挑戦する姿がかっこいい。",
  "思考が深まります。", "明日から意識してみますね。", "最高です！", "思わず笑っちゃいました。",
  "心に余裕が持てそうです。", "お疲れ様です！", "勉強不足を実感しました、頑張ります！", "素敵な日曜日ですね。"
]

# 1つの投稿に複数人がコメントするようにランダムに生成
60.times do |i|
  commenter = users.sample # ランダムなユーザー
  target_post = posts.sample # ランダムな投稿

  # 自分の投稿にはコメントしないルール（任意）
  next if commenter == target_post.user

  Comment.create!(
    body: comment_messages.sample,
    user: commenter,
    post: target_post
  )
end
puts "✅ コメントの作成完了 (計: #{Comment.count}件)"

# 4. 管理者の作成
Admin.find_or_create_by!(email_address: "admin@example.com") do |admin|
  admin.password = "password"
  admin.password_confirmation = "password"
end

puts "🎉 すべてのSeedの実行が正常に完了しました！"

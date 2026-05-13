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

# --- ユーザーの作成 (20名) ---
# 性格タイプ(MBTI)をバラけさせつつ、ユニークな自己紹介を設定しています
user_data = [
  { name: "アリス", email: "alice@example.com", type: "ENFP", intro: "旅行と美味しいものが大好き！" },
  { name: "ボブ", email: "bob@example.com", type: "ISTJ", intro: "プログラミング学習中。日々の記録を投稿します。" },
  { name: "チャーリー", email: "charlie@example.com", type: "INFJ", intro: "映画や読書が趣味。静かな場所が好きです。" },
  { name: "デイブ", email: "dave@example.com", type: "ENTP", intro: "新しい技術や議論が大好き！" },
  { name: "イヴ", email: "eve@example.com", type: "ISFP", intro: "絵を描くことと植物を育てることが日課。" },
  { name: "フランク", email: "frank@example.com", type: "ESTJ", intro: "効率的な仕事術と筋トレにハマっています。" },
  { name: "グレース", email: "grace@example.com", type: "INFP", intro: "世界の不思議について考えるのが好き。" },
  { name: "ハンス", email: "hans@example.com", type: "INTJ", intro: "長期的な戦略を立てるのが得意。チェスが好き。" },
  { name: "アイビー", email: "ivy@example.com", type: "ENFJ", intro: "みんなで協力して何かを作るのが幸せ。" },
  { name: "ジャック", email: "jack@example.com", type: "ISTP", intro: "バイクの修理とキャンプが趣味。道具を愛しています。" },
  { name: "ケイト", email: "kate@example.com", type: "ESFJ", intro: "おもてなしの心を大切にしています。料理が得意。" },
  { name: "レオ", email: "leo@example.com", type: "ESTP", intro: "考えるより先に動くタイプ！刺激的な毎日を。" },
  { name: "ミア", email: "mia@example.com", type: "INTP", intro: "論理的な矛盾を見つけるとワクワクします。" },
  { name: "ノア", email: "noah@example.com", type: "ENTJ", intro: "プロジェクトの指揮を執るのが得意です。" },
  { name: "オリビア", email: "olivia@example.com", type: "ISFJ", intro: "周りの人のサポートに徹するのが私のスタイル。" },
  { name: "ポール", email: "paul@example.com", type: "ESFP", intro: "人生はパーティー！楽しいことが一番。" },
  { name: "クイン", email: "quinn@example.com", type: "ENFP", intro: "自由な発想を大切にしたいです。" },
  { name: "ローズ", email: "rose@example.com", type: "INFJ", intro: "人の心の機微を理解しようと努めています。" },
  { name: "サム", email: "sam@example.com", type: "ISTJ", intro: "コツコツと努力することが成功への近道。" },
  { name: "タラ", email: "tara@example.com", type: "ENFJ", intro: "理想のコミュニティ作りを目指しています。" }
]

users = []
user_data.each do |data|
  users << User.find_or_create_by!(email_address: data[:email]) do |user|
    user.name = data[:name]
    user.password = "password"
    user.mbti_type = data[:type]
    user.introduction = data[:intro]
  end
end
puts "ユーザーの作成が完了しました (計: #{User.count}名)"

# --- 投稿 (posts) の作成 (20件) ---
post_titles = [
  "初めての投稿", "Railsの学習について", "おすすめのカフェ", "週末の創作活動",
  "朝活のススメ", "戦略的な思考とは", "チームワークの秘訣", "メンテナンスの楽しみ",
  "手作りケーキ", "スリルを求めて", "最新の科学ニュース", "リーダーシップ論",
  "お花の植え替え", "フェスの思い出", "アイデアの源泉", "共感の力",
  "習慣化のコツ", "夢のコミュニティ", "お気に入りのガジェット", "散歩で見つけた空"
]

posts = []
post_titles.each_with_index do |title, i|
  posts << Post.find_or_create_by!(title: title) do |post|
    post.body = "#{title}に関するエピソードです。MBTIタイプ「#{users[i].mbti_type}」らしい視点で書いてみました。"
    post.user = users[i]
  end
end
puts "投稿の作成が完了しました (計: #{Post.count}件)"

# --- コメント (comments) の作成 (20件) ---
comment_messages = [
  "面白いですね！", "その視点はありませんでした。", "参考になります！", "私も同じタイプです。",
  "共感しました。", "続きが気になります！", "素敵ですね。", "勉強になります。",
  "今度試してみます。", "写真も見てみたいです！", "質問してもいいですか？", "応援しています。",
  "素晴らしい活動です。", "私も混ぜてください（笑）", "深いですね…", "納得の考え方です。",
  "明日の投稿も楽しみです。", "いい刺激になりました！", "カフェ情報、ありがとうございます。", "癒されました。"
]

comment_messages.each_with_index do |msg, i|
  Comment.find_or_create_by!(body: msg) do |c|
    c.user = users[(i + 1) % users.size] # 書き手とは別のユーザーを割り当て
    c.post = posts[i % posts.size]
  end
end

puts "コメントの作成が完了しました (計: #{Comment.count}件)"
puts "すべてのSeedの実行が正常に完了しました！"

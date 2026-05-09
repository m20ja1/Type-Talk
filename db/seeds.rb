# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 実行時の進捗を見やすくするためのメッセージ
puts "Seedの実行を開始します..."

# --- ユーザーの作成 ---
# find_or_create_by! を使うことで、メールアドレスの重複を防ぎつつ何度でも実行可能にしています

alice = User.find_or_create_by!(email_address: "alice@example.com") do |user|
  user.name = "アリス"
  user.password = "password" # BCryptなどを使っている場合は自動でdigest化されます
  user.mbti_type = "ENFP"
  user.introduction = "こんにちは！旅行と美味しいものが大好きです。よろしくお願いします。"
end

bob = User.find_or_create_by!(email_address: "bob@example.com") do |user|
  user.name = "ボブ"
  user.password = "password"
  user.mbti_type = "ISTJ"
  user.introduction = "プログラミング学習中のボブです。日々の記録を投稿していきます。"
end

charlie = User.find_or_create_by!(email_address: "charlie@example.com") do |user|
  user.name = "チャーリー"
  user.password = "password"
  user.mbti_type = "INFJ"
  user.introduction = "映画や読書が趣味です。静かな場所が好きです。"
end

puts "ユーザーの作成が完了しました (計: #{User.count}名)"

# --- 投稿 (posts) の作成 ---

Post.find_or_create_by!(title: "初めての投稿") do |post|
  post.body = "今日からこのアプリを使い始めました！これから楽しみです。"
  post.user_id = alice.id
  post.genre_id = 1
end

Post.find_or_create_by!(title: "Railsの学習について") do |post|
  post.body = "seedsの作成方法を学びました。データベースの管理がとても楽になりますね。"
  post.user_id = bob.id
  post.genre_id = 2
end

Post.find_or_create_by!(title: "おすすめのカフェ") do |post|
  post.body = "駅前の新しいカフェのコーヒーがとても美味しかったです。静かで集中できました。"
  post.user_id = charlie.id
  post.genre_id = 1
end

Post.find_or_create_by!(title: "週末の予定") do |post|
  post.body = "今週末は山登りに行く予定です。天気がいいといいな。"
  post.user_id = alice.id
  post.genre_id = 3
end

puts "投稿の作成が完了しました (計: #{Post.count}件)"
puts "すべてのSeedの実行が正常に完了しました！"

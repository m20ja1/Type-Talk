class ChangeColumnToBigInt < ActiveRecord::Migration[7.0]
 def change
   # 第一引数: テーブル名, 第二引数: カラム名, 第三引数: 変更後の型
   change_column :notifications , :user_id, :bigint
 end
end

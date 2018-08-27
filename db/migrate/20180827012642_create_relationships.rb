class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      
      t.references :user, foreign_key: true
      # t.references :follow, foreign_key: true
      
      # { to_table: :users } によって、外部キーとして参照すべきテーブルを指定
      # 指定しない場合、Rails のデフォルトの命名規則により、 follows テーブルを参照
      # 外部キーは follow でありながら、参照先のテーブルは users とすることが可能
      t.references :follow, foreign_key: { to_table: :users }

      # user_id と follow_id のペアで重複するものが保存されないようにするDBの設定
      # ユーザがあるユーザをフォローしたとき、
      # フォローを解除せずに、重複して何度もフォローできてしまうような事態を防ぐ
      t.index [:user_id, :follow_id], unique: true

      t.timestamps
    end
  end
end

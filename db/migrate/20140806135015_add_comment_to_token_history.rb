class AddCommentToTokenHistory < ActiveRecord::Migration
  def change
    add_column :token_histories, :comment, :text
  end
end

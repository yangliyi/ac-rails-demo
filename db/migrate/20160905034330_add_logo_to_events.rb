class AddLogoToEvents < ActiveRecord::Migration[5.0]
  def change
    add_attachment :events, :logo
  end
end

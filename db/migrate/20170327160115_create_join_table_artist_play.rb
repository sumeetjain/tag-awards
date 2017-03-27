class CreateJoinTableArtistPlay < ActiveRecord::Migration
  def change
    create_join_table :artists, :plays do |t|
      # t.index [:artist_id, :play_id]
      # t.index [:play_id, :artist_id]
    end
  end
end

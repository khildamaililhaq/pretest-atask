class CreateTeamDetails < ActiveRecord::Migration[7.2]
  def change
    create_table :team_details do |t|
      t.string :code
      t.string :email
      t.belongs_to :team

      t.timestamps
    end
  end
end

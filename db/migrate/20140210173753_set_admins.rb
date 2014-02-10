class SetAdmins < ActiveRecord::Migration
  def change
    ActiveRecord::Base.connection.execute("UPDATE users SET type_id = 1 WHERE email = 'elduarte@gmail.com'")
  end
end

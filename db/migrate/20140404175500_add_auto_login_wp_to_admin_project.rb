class AddAutoLoginWpToAdminProject < ActiveRecord::Migration
  def self.up
    add_column :admin_projects, :auto_login_wp, :boolean, default: true
  end

  def self.down
    remove_column :admin_projects, :auto_login_wp
  end
end

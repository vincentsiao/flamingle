# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

user_role = Role.create(:name => 'user')
mod_role = Role.create(:name => 'moderator')
admin_role = Role.create(:name => 'administrator')

vincent = User.create!(:email => 'vsiao@andrew.cmu.edu',
                       :username => 'konnetikut',
                       :password => 'j2h3nkj',
                       :role_id => admin_role.id)
              .confirm!

victor = User.create!(:email => 'victor@mit.edu',
                      :username => 'poofytoo',
                      :password => 'pencilpencil',
                      :role_id => user_role.id)
              .confirm!

Priority.create(:name => 'Low',
                :cost => 0, :value => 100)

Priority.create(:name => 'High',
                :cost => 200, :value => 400)

Mission.create(:user_id => 1, :priority_id => 1,
               :title => "Buy Me That Textbook")

Mission.create(:user_id => 2, :priority_id => 2,
               :title => "Obtain Three Elf Tears")

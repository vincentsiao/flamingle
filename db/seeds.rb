# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

user_role = Role.create(:name => 'user')
mod_role = Role.create(:name => 'moderator')
admin_role = Role.create(:name => 'administrator')

vincent = User.create!(:email => 'vsiao@andrew.cmu.edu',
                       :username => 'konnetikut',
                       :password => 'j2h3nkj',
                       :role_id => admin_role.id)
victor = User.create!(:email => 'victor@mit.edu',
                      :username => 'poofytoo',
                      :password => 'pencilpencil',
                      :role_id => user_role.id)
vincent.confirm!
victor.confirm!

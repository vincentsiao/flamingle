# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

user_role = Role.create(:name => 'user')
mod_role = Role.create(:name => 'moderator')
admin_role = Role.create(:name => 'administrator')

vincent = User.create!(:email => 'vsiao@andrew.cmu.edu',
                       :username => 'konnetikut',
                       :password => 'j2h3nkj',
                       :role_id => admin_role.id)
             vincent.confirm!

victor = User.create!(:email => 'victor@mit.edu',
                      :username => 'poofytoo',
                      :password => 'pencilpencil',
                      :role_id => user_role.id)
              victor.confirm!
              
bob = User.create!(:email => 'bob@berkeley.edu',
                      :username => 'bob',
                      :password => 'pencil',
                      :role_id => user_role.id)
              bob.confirm!

MissionPriority.create(:name => 'Regular',
                :cost => 0, :value => 25)
MissionPriority.create(:name => 'High',
                :cost => 75, :value => 100)

Mission.create([{:user_id => 1, :title => "Buy Me That Textbook",
                 :description => "I really need Matter & Interactions I for my Physics course. I really do.",
                 :mission_priority_id => 1},
                {:user_id => 2, :title => "Obtain Three Elf Tears",
                 :description => "Summoning the Weasel King requires 6 Elf Tears. I only have 3 - please aid me.",
                 :mission_priority_id => 2},
                {:user_id => 3, :title => "Fetch Printouts from Tree-Eater",
                 :description => "Go to the Tree-Eater printer and get everything printed under 'kario'",
                 :mission_priority_id => 1}])

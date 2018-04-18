# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rails db:seed command (or created
# alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings'
# }])
#   Character.create(name: 'Luke', movie: movies.first)
# admin=User.new({ name: "veer", email: 'veeraryan92@gmail.com',
#               password: '111111', password_confirmation: '111111'})
#
#    admin.toggle!(:admin)
#
# if admin.valid?
#  admin.save()
# elsif admin.errors.any?
#  admin.errors.full_messages.each do |msg|
#  puts msg
#  end
#  else
#  puts "****NOT VALID****"
#  end
['normal_user', 'admin'].each do |role|
  Role.find_or_create_by({name: role})
end

# admin = User.create(name: 'veer',
# 								    email: 'veeraryan92@gmail.com',
# 								    password: '111111',
# 								    password_confirmation: '111111',
#                     role_id: '2')
# admin.add_role(:admin)
User.create(:name => 'veer',
            :role => Role.find_by_name('veer'),
            :email => 'veeraryan92@gmail.com',
            :password => '111111',
            :password_confirmation => '111111',
            :role_id => '2',
            :avatar => File.open(File.join(Rails.root, "/app/assets/images/admin.jpeg"))

         )
# 1.upto(5) do |i|
# 	Product.create(name: "monitor #{i}",
# 								 price: 600 * i,
# 								 user: user1)
# end
# 1.upto(5) do |i|
# 	Product.create(name: "keyboard #{i}",
# 								 price: 200 * i,
# 								 user: user2)
# end

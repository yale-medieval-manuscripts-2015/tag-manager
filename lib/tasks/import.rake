namespace :import do
  desc "imports user data from a csv file"
  task :data => :environment do
    require 'csv'
    CSV.foreach('importData/users.csv') do |row|
      provider = row[0]
      uid = row[1]
      name = row[2]
      password = "password"
      puts row.inspect
      puts "Provider: ", provider,"uid: ",uid,"Name: ",name
      @user = User.create(provider: provider, uid: uid, name: name, encrypted_password: password)
      @user.save!(options={validate: false})
      puts "user.provider = ", @user.provider
    end
  end
end
admin = Admin.new(email: 'admin@gmail.com', password: 'qwerty', password_confirmation: 'qwerty')
admin.skip_confirmation!
admin.save!

Article.__elasticsearch__.create_index!(force: true)

Tag.create(name: 'cooking', tsv_name: 'cooking')
Tag.create(name: 'programming', tsv_name: 'programming')
Tag.create(name: 'driving', tsv_name: 'driving')
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


bandung_juara = Article.create(title: 'Gedung Sate', content: 'Gedung Putihnya Bandung', status: 'active')
jogja_pintar = Article.create(title: 'Keraton', content: 'Tempat ngumpul para selir', status: 'active')
['Pertamax bandung', 'mantap euy'].each do |bj|
  bandung_juara.comments.create(content: bj)
end
['Pertamax jogja', 'cah lanang was here', 'ojolali'].each do |jp|
  jogja_pintar.comments.create(content: jp)
end

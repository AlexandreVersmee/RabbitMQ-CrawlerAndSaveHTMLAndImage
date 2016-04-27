require './db/models/url.rb'

# Fill Url tables

urls_tab = %w(http://www.theuselessweb.com/
http://hooooooooo.com/
http://ducksarethebest.com/
http://www.rrrgggbbb.com/
http://www.staggeringbeauty.com/
http://thatsthefinger.com/
http://www.koalastothemax.com/
http://www.e2cgrandhainaut.fr)

8.times do |n|
  Url.create!(url:  urls_tab[n])
end

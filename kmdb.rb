# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!

# Rubric
# 
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)

# Submission
# 
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the 
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======

# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========

# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.
# TODO!
Movie.destroy_all
Studio.destroy_all
Actor.destroy_all
Role.destroy_all

# Generate models and tables, according to the domain model.
# DONE

# Insert data into the database that reflects the sample data shown above.
# Do not use hard-coded foreign key IDs.
studio_warner_bros = Studio.new
studio["name"] = "Warner Bros."
studio_warner_bros.save

#movie data below
studio_warner_bros = Studio.find_by({"name" => "Warner Bros."})

batman_begins = Movie.new
batman_begins["title"] = "Batman Begins"
batman_begins["year_released"] = 2005
batman_begins["rated"] = "PG-13"
batman_begins["studio_id"] = studio["id"]
batman_begins.save

dark_knight = Movie.new
dark_knight["title"] = "The Dark Knight"
dark_knight["year_released"] = 2008
dark_knight["rated"] = "PG-13"
dark_knight["studio_id"] = studio["id"]
dark_knight.save

dark_knight_rises = Movie.new
dark_knight_rises["title"] = "The Dark Knight Rises"
dark_knight_rises["year_released"] = 2012
dark_knight_rises["rated"] = "PG-13"
dark_knight_rises["studio_id"] = studio["id"]
dark_knight_rises.save

#Actor data below
c_bale = Actor.new
c_bale["name"] = "Christian Bale"
c_bale.save

m_caine = Actor.new
m_caine["name"] = "Michael Caine"
m_caine.save

l_neeson = Actor.new
l_neeson["name"] = "Liam Neeson"
l_neeson.save

k_holmes = Actor.new
k_holmes["name"] = "Katie Holmes"
k_holmes.save

g_oldman = Actor.new
g_oldman["name"] = "Gary Oldman"
g_oldman.save

h_ledger = Actor.new
h_ledger["name"] = "Heath Ledger"
h_ledger.save

a_eckhart = Actor.new
a_eckhart["name"] = "Aaron Eckhart"
a_eckhart.save

m_gyllenhaal = Actor.new
m_gyllenhaal["name"] = "Maggie Gyllenhaal"
m_gyllenhaal.save

t_hardy = Actor.new
t_hardy["name"] = "Tom Hardy"
t_hardy.save

j_gordon_levitt = Actor.new
j_gordon_levitt["name"] = "Joseph Gordon-Levitt"
j_gordon_levitt.save

a_hathaway = Actor.new
a_hathaway["name"] = "Anne Hathaway"
a_hathaway.save

#add roles
#batmanbegins
role = Role.new
role["movie_id"] = batman_begins["id"]
role["actor_id"] = c_bale["id"]
role["character_name"] = "Bruce Wayne"
role.save

role = Role.new
role["movie_id"] = batman_begins["id"]
role["actor_id"] = m_caine["id"]
role["character_name"] = "Alfred"
role.save

role = Role.new
role["movie_id"] = batman_begins["id"]
role["actor_id"] = l_neeson["id"]
role["character_name"] = "Ra's Al Ghul"
role.save

role = Role.new
role["movie_id"] = batman_begins["id"]
role["actor_id"] = k_holmes["id"]
role["character_name"] = "Rachel Dawes"
role.save

role = Role.new
role["movie_id"] = batman_begins["id"]
role["actor_id"] = g_oldman["id"]
role["character_name"] = "Commissioner Gordon"
role.save

# Prints a header for the movies output
puts "Movies"
puts "======"
puts ""

# Query the movies data and loop through the results to display the movies output.
all_3_movies = Movie.all
for movie in all_3_movies
  title_of_movie = movie["movie_title"]
  year_released = movie["year_released"]
  rated = movie["rated"]
  puts "#{title_of_movie}      #{year_released}      #{rated}      #{studio["name"]}"
end

# Prints a header for the cast output
puts ""
puts "Top Cast"
puts "========"
puts ""

# Query the cast data and loop through the results to display the cast output for each movie.
# TODO!
top_cast = Role.all

for role in top_cast
  movie = Movie.find_by({"id" => role["movie_id"]})
  actor = Actor.find_by({"id" => role["actor_id"]})
  character_name = role["character_name"]

  puts "#{movie["movie_title"]} - #{name_of_actor["actor_name"]} - #{character_name}"
end

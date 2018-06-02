$view ||= 'shutdownscreen'
# $selected
# $game
$player ||= {
    slot: 1,
    strengh: 5,
    position: [0, 0],
    life: 20,
    moviedex: [],
    index: 0,
    movies: []
}

class MoviemonController < ApplicationController
  def titlescreen
    $view = 'titlescreen'
  end

  def worldmap
    $view = 'worldmap'
    @map = Array.new(10) {Array.new(10)}
  end

  def moviedex
    $view = 'moviedex'
  end


  def moviedex2
  end

  def battle
    $view = 'battle'
  end

  def save
  end

  def power
    if $view == 'shutdownscreen'
      $view = 'titlescreen'
      redirect_to :"#{$view}"
    else
      $view = 'shutdownscreen'
      $player = {
          slot: 1,
          position: [0, 0],
          life: 20,
          strength: 5,
          moviedex: [],
          index: 0,
          movies: []
      }
      redirect_to :"#{$view}"
    end
  end

  def start
    case $view
      when "titlescreen"
        game = Game.new
        $player = {
            slot: 1,
            strengh: 5,
            position: [0, 0],
            life: 20,
            movies: game.load_movies,
            moviedex: [],
            index: 0
        }
        puts $player[:movies]
        $view = 'worldmap'
        redirect_to :"#{$view}"
      when "worldmap"
        $view = 'moviedex'
        redirect_to :"#{$view}"
      when "moviedex"
        $view = 'worldmap'
        redirect_to :"#{$view}"
      when "moviedex2"
        $view = 'worldmap'
        redirect_to :"#{$view}"
      else
        redirect_to :"#{$view}"
    end
  end

  def select
    if $view == 'titlescreen'
      $view = 'loadgame'
      redirect_to :"#{$view}"
    else
      $view = 'save'
      redirect_to :"#{$view}"
    end
  end

  def buttona
    case $view
      when "save"
        # DO SAVE
        $view = 'worldmap'
        redirect_to :"#{$view}"
      when "loadgame"
        #DO LOAD
        $view = 'worldmap'
        redirect_to :"#{$view}"
      else
        redirect_to :"#{$view}"
    end
  end

  def buttonb
    case $view
      when "loadgame"
        $view = 'titlescreen'
        redirect_to :"#{$view}"
      when "save"
        $view = 'worldmap'
        redirect_to :"#{$view}"
      when "battle"
        $view = 'worldmap'
        redirect_to :"#{$view}"
      else
        redirect_to :"#{$view}"
    end
  end

  def up
    case $view
      when "worldmap"
        $player[:position][1] = $player[:position][1] < 10 ? $player[:position][1] : $player[:position][1] -= 10
        find_monster
        redirect_to :"#{$view}"
      when "save", "loadgame"
        $player[:slot] = $player[:slot] > 1 ? $player[:slot] - 1 : 3
        redirect_to :"#{$view}"
      else
        redirect_to :"#{$view}"
    end
  end

  def down
    case $view
      when "worldmap"
        $player[:position][1] = $player[:position][1] > 80 ? $player[:position][1] : $player[:position][1] += 10
        find_monster
        redirect_to :"#{$view}"
      when "save", "loadgame"
        $player[:slot] = $player[:slot] < 3 ? $player[:slot] + 1 : 1
        redirect_to :"#{$view}"
      else
        redirect_to :"#{$view}"
    end
  end

  def right
    case $view
      when "worldmap"
        $player[:position][0] = $player[:position][0] > 80 ? $player[:position][0] : $player[:position][0] += 10
        find_monster
        redirect_to :"#{$view}"
      when "moviedex"
        # $player[:moviedex][0] += 1
        $view = "moviedex2"
        redirect_to :"#{$view}"
      else
        redirect_to :"#{$view}"
    end
  end

  def left
    case $view
      when "worldmap"
        $player[:position][0] = $player[:position][0] < 10 ? $player[:position][0] : $player[:position][0] -= 10
        find_monster
        redirect_to :"#{$view}"
      when "moviedex"
        # $player[:moviedex][0] -= 1
        $view = "moviedex2"
        redirect_to :"#{$view}"
      else
        redirect_to :"#{$view}"
    end
  end

  def find_monster
    puts "SAVAGE"
    if rand(5) == 1
      $view = "battle"
      $selected = $player[:movies].pop
    end
  end

end

# the apikey i got:
# http://www.omdbapi.com/?i=tt3896198&apikey=fe540c06
#
# http://www.omdbapi.com/?i=tt0368226

# omdbapikey = fe540c06

# movie_list = [
#   'tt0368226',
#   'tt1663662',
#   'tt0088763',
#   'tt1371111',
#   'tt0120611',
#   'tt1136608',
#   'tt0486640',
#   'tt1855325',
#   'tt0113855',
#   'tt0811080',
# ]
#
# movies = []
# movie_list.each do |movie|
#   data = http://www.omdbapi.com/?i=movie
#   movies << {
#     name: data['title'],
#     strength: int(float(data['imdb_rating'])),
#     rating: data['imdb_rating'],
#     actors: data['actors'],
#     year: data['released'].split(' ')[2],
#     image: data['poster'],
#     director: data['director'],
#     catched: False,
#   }
# end

# class Moviemon
#   strengh = 40
#   director =
# end


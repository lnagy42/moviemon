$view ||= 'shutdownscreen'
$selected
$game ||= Game.new
$player ||= {
    slot: 1,
    strength: 5,
    position: [0, 0],
    life: 30,
    moviedex: [],
    index: 0,
    movies: [],
    won_games: 0,
    lost_games: 0
}

class MoviemonController < ApplicationController
  def titlescreen
    $view = 'titlescreen'
  end

  def worldmap
    $view = 'worldmap'
    @map = Array.new($game.map_size) {Array.new($game.map_size)}
  end

  def moviedex
    $view = 'moviedex'
  end

  def moviedex2
    $view = 'moviedex2'
  end

  def battle
    $view = 'battle'
  end

  def victory; end

  def defeat; end

  def coward; end

  def save; end

  def endofgame; end

  def nodata; end

  def power
    if $view == 'shutdownscreen'
      $view = 'titlescreen'
      redirect_to :"#{$view}"
    else
      $view = 'shutdownscreen'
      $player = {
          slot: 1,
          position: [0, 0],
          life: 30,
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
      when 'titlescreen', 'endofgame', 'nodata'
        $game = Game.new
        $player = {
            slot: 1,
            strength: 5,
            position: [0, 0],
            life: 30,
            movies: $game.load_movies,
            moviedex: [],
            index: 0
        }
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
    case $view
    when 'titlescreen', 'endofgame', 'nodata'
        $view = 'loadgame'
        redirect_to :"#{$view}"
      # when 'shutdownscreen'
      #   redirect_to :"#{$view}"
      when 'worldmap'
        $view = 'save'
        redirect_to :"#{$view}"
      else
        redirect_to :"#{$view}"
    end
  end

  def buttona
    case $view
      when "save"
        $game.save
        $view = 'worldmap'
      when "loadgame"
        res = $game.load
        if res == false
          $view = 'nodata'
          $player ||= {slot: 1}
        else
          $view = 'worldmap'
        end       
      when "battle"
        $selected[:life] = $selected[:life] - ($player[:strength] * 2) + 2
        if $selected[:life] <= 0
          $view = "victory"
          $player[:life] = 30
          $player[:moviedex].push($selected)
          $player[:strength] += 1
          $player[:won_games] ||= 0
          $player[:won_games] += 1
          $selected[:catched] = true
          $selected = ""
        else
          $player[:life] = $player[:life] - $selected[:strength]
          if $player[:life] <= 0
            $view = "defeat"
            $selected = ""
            $player[:life] = 30
            $player[:lost_games] ||= 0
            $player[:lost_games] += 1
          end
        end
      when "coward","defeat","victory"
        if $player[:movies].empty?
          $view = 'endofgame'
        else
          $view = 'worldmap'
        end
    end
    redirect_to :"#{$view}"    
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
        $selected = ""
        $player[:life] = 30
        $view = "coward"
        redirect_to :"#{$view}"
      else
        redirect_to :"#{$view}"
    end
  end

  def up
    case $view
      when "worldmap"
        $player[:position][1] = $player[:position][1] < 1 ? $player[:position][1] : $player[:position][1] -= 1
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
        $player[:position][1] = $player[:position][1] > $game.map_size - 2 ? $player[:position][1] : $player[:position][1] += 1
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
        $player[:position][0] = $player[:position][0] > $game.map_size - 2 ? $player[:position][0] : $player[:position][0] += 1
        find_monster
        redirect_to :"#{$view}"
      when "moviedex"
        $view = "moviedex2"
        redirect_to :"#{$view}"
      when "moviedex2"
        $player[:moviedex].push($player[:moviedex].shift)
        redirect_to :"#{$view}"
      else
        redirect_to :"#{$view}"
    end
  end

  def left
    case $view
      when "worldmap"
        $player[:position][0] = $player[:position][0] < 1 ? $player[:position][0] : $player[:position][0] -= 1
        find_monster
        redirect_to :"#{$view}"
      when "moviedex"
        $view = "moviedex2"
        redirect_to :"#{$view}"
      when "moviedex2"
        $player[:moviedex].unshift($player[:moviedex].pop)
        redirect_to :"#{$view}"
      else
        redirect_to :"#{$view}"
    end
  end

  def find_monster
    if rand(5) == 1
      $selected = $player[:movies].pop
      $view = "battle"
    end
  end

end

# the apikey i got:
# http://www.omdbapi.com/?i=tt3896198&apikey=fe540c06
#
# http://www.omdbapi.com/?i=tt0368226

# omdbapikey = fe540c06


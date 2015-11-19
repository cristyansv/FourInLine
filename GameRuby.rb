
class Game
  attr_reader :board
  attr_accessor :moves
  attr_reader :lastMove

  def initialize
    @board = Array.new(3) {Array.new(3)}
    @moves = 9
    @lastMove
    @lastPlayer
  end

  def setBoard(board)
    i=0
    j=0
    while(i<3) do
      j=0
      while(j<3) do
        if(board[i][j]!= nil)
          @moves -=1
        end
        @board[i][j]=board[i][j]
        j+=1
      end
      i+=1
    end
  end

  def putBackGame()
    setGame(@lastMove,nil)
    @moves +=1
  end

  def isValidMove(pos)
    x = pos/3
    y = pos%3   
    if(@board[x][y]!=nil||pos>=9)
      return false
    else
      return true
    end
  end
  def setGame(pos,player)
    x = pos/3
    y = pos%3
    
    @moves-=1
    
    @board[x][y]=player
    
    @lastMove=pos
    @lastPlayer=player
      
  end
      
  def win?(player)
    i=0
    j=0
    contador = 0
    gano = false
    #horizontal
    while (!gano && i < 3) do
      j = 0
      while (!gano && j < 3) do
        if (@board[i][j] == player)
          contador+=1
        else
          contador = 0
          break
        end
        if (contador == 3)
          return true
        end
        j+=1
      end
      i+=1
    end
    i=0
    j=0
    contador = 0
    #vertical
    while (!gano && i < 3) do
      j = 0
      while (!gano && j < 3) do
        if (@board[j][i] == player) 
          contador+=1
        else 
          contador = 0
          break
        end
        if (contador == 3)
          return true
        end
        j+=1
      end
      i+=1
    end
    i=0
    j=0
    contador = 0
    corresponde = true
    #diagonal principal
    while (!gano && corresponde && i < 3) do
      if (@board[i][j] == player) 
        contador+=1
        j+=1
        i+=1
      else 
        corresponde = false;
      end
      if (contador == 3) 
        return true
      end
      
    end
    #diagonal 2
    i=0
    j=0
    contador = 0
    corresponde = true
    while (!gano && corresponde && i < 3) do
      if (@board[i][2 - j] == player) 
        contador+=1
        j+=1
        i+=1
      else 
        corresponde = false
      end
      if (contador == 3) 
        return true;
      end
    end
    
    return gano;
  end

  def over?
    return (availableMoves().size==0||win?(1)||win?(0))
  end
  
  
  def availableMoves
    i=0
    j=0
    availableMoves = []
    while(i<3) do
      j=0
      while(j<3) do
        availableMoves.push(i*3+j) if @board[i][j] == nil
        j+=1
      end
      i+=1
    end
    return availableMoves
  end
  
end

def availableGames(game,player)
  moves = game.availableMoves
  boards = []
  moves.each {|move| boards.push(Game.new)}
  boards.each {|board| board.setBoard(game.board)}
  boards.each {|board| board.setGame(moves.pop,player)}                                                                                  
  return boards
end

def score(game,depth)
  
  if game.win?(1)
    return 10-depth
  end
  
  if game.win?(0)
    return depth-10
  end
  
  return 0
  
end

def minimax(game,depth,player)
  return score(game,depth) if game.over?
  depth+=1
  scores = []
  moves = []
  
  activePlayer=player
  
  # if (player == 1)
  #   player=0
  # else
  #   player=1
  # end
  
  availableGames(game,player).each do |game2|
    scores.push(minimax(game2,depth,player))
    moves.push(game2.lastMove)
    
  end
  
  if activePlayer == 1
    max = -100
    index = 0
    indexMay=0
    scores.each {|score|
      if (score>max)
        max=score
        indexMay=index
        index+=1
      else
        index +=1
      end
    }
    
    
    $choice = moves[indexMay]
    
    return scores[indexMay]
    
  else    
    min = 100
    index = 0
    indexMin = 0
    
    scores.each{|score|
      if (min>score)
        min = score
        indexMin=index
        index+=1
      else
        index +=1
      end
    }
    
    $choice = moves[indexMin]
    return scores[indexMin]
  end
end

def printBoard(board)
  i=0
  j=0

  while(i<3) do
    while(j<3) do
      if(board[i][j]==nil)
        print "- "
      else
        print(board[i][j])
        print " "
      end
      j+=1            
    end
    puts ""
    j=0
    i+=1
  end
end

$choice = nil

game=Game.new

puts "Inicio del juego"

printBoard(game.board)

puts "----------------------"

until (game.over?) do
  puts "Ingresa la posicion donde quieres jugar"
  pos = gets
  pos.chomp!
  while(true) do
    if(game.isValidMove(pos.to_i))
      game.setGame(pos.to_i,0)
      break
    else
      puts "Ingresa una posicion valida"
      pos=gets
      pos.chomp
    end
  end
    
  # while(true) do
  #   if(!game.setGame(pos.to_i,0))
  #     break
  #   end
  #   puts "Ingresa una casilla valida"
  #   pos=gets
  #   post.chomp!
  # end
  
  printBoard(game.board)

  puts "--------------------"

  score1=minimax(game,0,1)
  puts "puntaje minimax 1: "+score1.to_s
  choice1=$choice
  score2=(-1)*minimax(game,0,0)
  puts "puntaje minimax 2: "+score2.to_s
  choice2=$choice
  
  ultimateChoice=nil

  if(score2==score1)
    game.setGame(choice1,1)
    firstChoice=choice1
    score3=minimax(game,0,0)
    ultimateChoice = $choice
    game.setGame(ultimateChoice,0)
    score4=minimax(game,0,1)
    score5=minimax(game,0,0)
    if(score4<(-1*score5))
      game.putBackGame()
      game.setGame(firstChoice,nil)
      game.setGame(ultimateChoice,1)
    else
      game.putBackGame()
    end
    
  elsif (score2>=score1)
    game.setGame(choice2,1)
  else
    game.setGame(choice1,1)
  end

  printBoard(game.board)

  puts "---------------"
end

if(game.win?(1))
  puts "Ha ganado la computadora"
elsif(game.win?(0))
  puts "Ha ganado el jugador"
else
  puts "Es un empate"
end


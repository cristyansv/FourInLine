
class Game
  attr_reader :board
  attr_accessor :moves
  attr_reader :lastMoveX
  attr_reader :lastMoveY
  attr_reader :lastPlayer

  def initialize
    @board = Array.new(7) {Array.new(6)}
    @moves = 42
    @lastMoveX
    @lastMoveY
    @lastPlayer
  end

  def setBoard(board)
    i=0
    j=0
    while(i<7) do
      j=0
      while(j<6) do
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
    deleteMove(@lastMoveX)
    @moves +=1
  end

  def isValidMove(pos)
    
    if(pos<8&&@board[pos][5]==nil)
      return true
    else
      return false
    end
  end
  
  def setGame(pos,player)
    
    @moves-=1
    y=0
    while(board[pos][y]!=nil) do
      y+=1
    end
    
    if(isValidMove(pos))
      @board[pos][y]=player
      
      @lastMoveX=pos
      @lastMoveY=y
      @lastPlayer=player
    end
  end
      
  def win?(player)
    inicialh=3
    i=3
    j=0
    fails=0
    contador = 0
    gano = false
    #horizontal
    while(j<6)
      i=3
      fails=0
      contador=0
      while(i<7&&i>=0&&fails<2) do
        if(@board[i][j]==player)
          contador+=1
        else
          fails+=1
          i=inicialh
        end
                
        if(fails==0)
          i+=1
        else
          i-=1
        end

        if(contador==4)
          return true
        end
      end
      j+=1
    end


    #vertical

    inicialv=2
    i=0
    j=2
    fails=0
    contador = 0

    while(i<7)
      fails=0
      j=2
      while(j<6&&j>=0&&fails<2) do
        if(@board[i][j]==player)
          contador+=1
        else
          fails+=1
          j=inicialv
        end
                
        if(fails==0)
          j+=1
        else
          j-=1
        end

        if(contador==4)
          return true
        end
        
      end
      contador=0
      i+=1
    end

    #diagonal1
    k=0
    l=0
    contador=0
    
    while(k<3) do
      l=0
      while(l<4) do
        i=0
        j=0
        contador=0
        corresponde=true
        if (@board[l+i][k+j]==player)
          while (corresponde && i < 4) do
            if (@board[l+i][k+j] == player) 
              contador+=1
              j+=1
              i+=1
            else 
              corresponde = false;
            end
            if (contador == 4) 
              return true
            end
            
          end
        end
        l+=1
      end
      k+=1
    end

    contador=0
    
    #diagonal2
    k=0
    l=3
    while(k<3) do
      l=3
      while(l<7) do
        i=0
        j=0
        contador=0
        corresponde=true
        if (@board[l-i][k-j]==player)
          while (corresponde && i < 4) do
            if (@board[l-i][k+j] == player) 
              contador+=1
              j+=1
              i+=1
            else 
              corresponde = false
            end
            if (contador == 4) 
              return true;
            end
          end          

        end
        l+=1
      end
     k+=1
    end
     

    return false
   
  end

  def over?
    return (availableMoves().size==0||win?(1)||win?(0))
  end

  def deleteMove(pos)
    y=0
    while(@board[pos][y]!=nil)
      y+=1
    end

    @board[pos][y-1]=nil

    @moves+=1
  end
  
  
  def availableMoves
    i=0
    j=0
    availableMoves = []
    while(i<7) do
        availableMoves.push(i) if isValidMove(i)
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
    return 20-depth
  end
  
  if game.win?(0)
    return depth-20
  end
  
  return 0
  
end

def minimax(game,depth,player)
  return score(game,depth) if (game.over? || depth == 5)
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
    moves.push(game2.lastMoveX)
    
  end
  
  if activePlayer == 1
    max = -100
    index = 0
    indexMay=0
    index2May=0
    scores.each {|score|
      if (score>max)
        max=score
        indexMay=index
        index+=1
      else
        index +=1
      end
    }

    index=0
    max2=-100
    scores.each {|score|
      if (score>max2&&score<max)
        max=score
        index2May=index
        index+=1
      else
        index +=1
      end
    }
    
    $choice = moves[indexMay]
    $altChoice = moves[index2May]
    return scores[indexMay]
    
  else    
    min = 100
    index = 0
    indexMin = 0
    index2Min=0
    
    scores.each{|score|
      if (min>score)
        min = score
        indexMin=index
        index+=1
      else
        index +=1
      end
    }

    min2=100
    index=0
    scores.each {|score|
      if (score<min2&&score>min)
        min2=score
        index2Min=index
        index+=1
      else
        index +=1
      end
    }
    
    $choice = moves[indexMin]
    $altChoice = moves[index2Min]
    return scores[indexMin]
  end
end

def printBoard(board)
  i=0
  j=0

  while(j<6) do
    while(i<7) do
      if(board[i][5-j]==nil)
        print "- "
      else
        print(board[i][5-j])
        print " "
      end
      i+=1            
    end
    puts ""
    i=0
    j+=1
  end
end

$choice = nil
$altChoice = nil
game=Game.new

puts "Inicio del juego"

printBoard(game.board)
puts "-------------"
puts "0 1 2 3 4 5 6"

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
      pos.chomp!
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

  puts "-------------"
  puts "0 1 2 3 4 5 6"
  puts "-------Turno Jugador1-------"

  if(game.win?(0))
    break
  end
  

  puts "Ingresa la posicion donde quieres jugar"
  pos = gets
  pos.chomp!
  while(true) do
    if(game.isValidMove(pos.to_i))
      game.setGame(pos.to_i,1)
      break
    else
      puts "Ingresa una posicion valida"
      pos=gets
      pos.chomp!
    end
  end
  
  printBoard(game.board)
  puts "-------------"
  puts "0 1 2 3 4 5 6"
  puts "-------Turno Jugador2-------"
end

if(game.win?(1))
  puts "Ha ganado el Jugador2"
elsif(game.win?(0))
  puts "Ha ganado el Jugador1"
else
  puts "Es un empate"
end


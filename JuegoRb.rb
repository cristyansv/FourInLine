
class Game
  attr_reader :board
  attr_accessor :moves

  def initialize
      @board = Array.new(3) {Array.new(3)}
      @moves = 9
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
  
  def setGame(pos,player)
    x = pos/3
    y = pos%3
    @moves-=1
    
    @board[x][y]=player
    
  end
  
  def win?(player)
    #Verificar si gana o no el primero   
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

def score(game)
  return 0
  
  if game.win?(player)
    return 10
  end
  
  if game.win?(opponent)
    return -10
  end
  
  return 0
  
end

def minimax(game)
  return 0
end

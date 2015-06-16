require 'fox16'
include Fox

class HelloWorldWindow < FXMainWindow
  def initialize(app)
    super(app, 'Hello World Program')

    # this is where your program goes
    random_board = [0, 1, 2].sample

    array_of_set_answers_array = [['8',nil,'7','2',nil,nil,nil,nil,'5',nil,nil,nil,nil,'6','7','2','3',nil,nil,'9','2',nil,nil,nil,'7',nil,nil,'9',nil,'1',nil,nil,nil,nil,nil,nil,'3',nil,nil,nil,nil,nil,nil,nil,'6',nil,nil,nil,nil,nil,'6','8',nil,'2',nil,nil,'9',nil,nil,nil,'4','5',nil,nil,'4','6','9','7',nil,nil,nil,nil,'2',nil,nil,nil,nil,'5','6',nil,'8'],
                                  [nil,nil,nil,nil,nil,'7','6','8',nil,nil,nil,'8',nil,nil,'3','1','2','7',nil,'9',nil,nil,nil,nil,nil,'3',nil,nil,'1','7',nil,'3',nil,nil,'9','6',nil,nil,nil,nil,'5',nil,nil,nil,nil,'6','5',nil,nil,'1',nil,'8','4',nil,nil,'3',nil,nil,nil,nil,nil,'6',nil,'8','7','1','3',nil,nil,'2',nil,nil,nil,'2','6','4',nil,nil,nil,nil,nil],
                                  ['8',nil,'4',nil,nil,'1',nil,nil,nil,'3','9',nil,'4',nil,'2',nil,'5',nil,nil,nil,nil,'8','9',nil,'4',nil,nil,nil,'7',nil,nil,nil,'9',nil,nil,'3','2',nil,'1',nil,nil,nil,'6',nil,'5','9',nil,nil,'2',nil,nil,nil,'1',nil,nil,nil,'2',nil,'4','3',nil,nil,nil,nil,'6',nil,'1',nil,'5',nil,'2','4',nil,nil,nil,'9',nil,nil,'7',nil,'1']]
    array_of_set_answers = array_of_set_answers_array[random_board]

    @mtx1 = FXMatrix.new(self, 9)

    81.times do |i|
      btn = FXButton.new(@mtx1, '', :opts => BUTTON_NORMAL|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT, :width => 50, :height => 50)
      btn.text = array_of_set_answers[i]
      if array_of_set_answers[i]
        btn.disable
      end
      btn.connect(SEL_COMMAND) do
        btn.backColor = 4291350740
        if btn.text == nil
          btn.text = "1"
        else
          btn.text = (btn.text.to_i + 1).to_s
          if btn.text.to_i > 9
            btn.text = "1"
          end
        end
      end
    end

    # create "check answer" button and check answers
    @message_btn = FXButton.new(self, "Check Answers")
    @message_btn.backColor = :green
    @message_btn.connect(SEL_COMMAND) do

      # solved sudoku board
      user_board = []
      9.times do |col|
        9.times do |row|
          child = @mtx1.childAtRowCol(row, col)
          user_board.push(child.text)
        end
      end

      array_of_solved_board_array = [['8','3','7','2','4','9','1','6','5','4','1','5','8','6','7','2','3','9','6','9','2','5','3','1','7','8','4','9','6','1','7','8','2','5','4','3','3','2','8','1','5','4','9','7','6','7','5','4','3','9','6','8','1','2','1','8','9','6','2','3','4','5','7','5','4','6','9','7','8','3','2','1','2','7','3','4','1','5','6','9','8'],
                                     ['1','4','3','5','2','7','6','8','9','5','6','8','9','4','3','1','2','7','7','9','2','1','6','8','4','3','5','2','1','7','8','3','4','5','9','6','3','8','4','6','5','9','7','1','2','6','5','9','7','1','2','8','4','3','4','3','5','2','7','1','9','6','8','8','7','1','3','9','6','2','5','4','9','2','6','4','8','5','3','7','1'],
                                     ['8','2','4','5','3','1','9','7','6','3','9','7','4','6','2','1','5','8','6','1','5','8','9','7','4','3','2','5','7','8','6','1','9','2','4','3','2','4','1','3','7','8','6','9','5','9','3','6','2','5','4','8','1','7','1','8','2','7','4','3','5','6','9','7','6','9','1','8','5','3','2','4','4','5','3','9','2','6','7','8','1']]
      array_of_solved_board = array_of_solved_board_array[random_board]

      if user_board == array_of_solved_board
        FXMessageBox.information(self, MBOX_OK, "Information", "Congratulations!!")
        self.close
      else
        # show user errors and turn to red
        9.times do |col|
          9.times do |row|
            child = @mtx1.childAtRowCol(row, col)
            if child.text != array_of_solved_board[col*9 + row]
              child.backColor = :red
            end
          end
        end
        FXMessageBox.error(self, MBOX_OK, "Error", "Not correct, try again")
      end
    end
  end

  # don't touch this
  def create
    super
    self.show(PLACEMENT_SCREEN)
  end
end

# never touch these
app = FXApp.new
HelloWorldWindow.new(app)
app.create
app.run
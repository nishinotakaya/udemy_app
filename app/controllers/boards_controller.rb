class BoardsController < ApplicationController
before_action :set_target_board, only: %i[show edit update destroy]

  def index
    @boards = params[:tag_id].present? ? Tag.find(params[:tag_id]).boards : Board.all
    @boards = @boards.page(params[:page])
  end

  def new
    @board = Board.new(flash[:board])
  end

  def create
    board = Board.new(boards_params)
    if board.save
      flash[:notice] = "「#{board.title}」の掲示板を作成しました"
      redirect_to board #ストロングパラメーターがcreateされてidが作成されているため  
    else
      redirect_to new_board_path, flash: {
        board: board,
        error_messages: board.errors.full_messages
      }
    end
  end

  def show
    @comment = Comment.new(board_id: @board.id) #書き直し@boardに紐づいたコメントに影響しない
    # @comment = @board.comments.new #あたしく関連するコメントが作れる
  end

  def edit
  end

  def update
    if @board.update(boards_params)
      flash[:notice] = "「#{@board.title}」の掲示板を編集しました"
      redirect_to @board
    else
      redirect_to edit_board_path, flash: {
        board: @board,
        error_messages: @board.errors.full_messages
      }
    end  
  end

  def destroy
    @board.destroy
    redirect_to boards_path, flash: { notice: "「#{@board.title}」の掲示板が削除されました"}
  end

private

  def set_target_board
    @board = Board.find(params[:id])
  end  

  def boards_params
    params.require(:board).permit(:name, :title, :body, tag_ids: [])
  end

end

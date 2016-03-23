class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def new
    @comments = Comment.new
  end

  def edit
    @comment = Comment.find_by_id(params[:id])
  end

  def create
    @comment = Comment.new(params_article)

    respond_to do |format|
      if @comment.save

        format.html { redirect_to @comment, notice: 'Post was successfully created.' }

      else
        flash[:error] = "data not valid"
        render 'new'
        format.js
      end
    end

  end
  def show
    @comment = Comment.find_by_id(params[:id])
  end
  def destroy
    @comment = Comment.find_by_id(params[:id])
    @comment.destroy
    respond_to do |format|
      flash[:notice] = "Success Delete a Records"
      redirect_to action: 'index'
      format.js
    end
  end
  private
  def params_comment
    params.require(:comment).permit(:content)
  end

end

class TodosController < ApplicationController
  def index
    @todos = current_user.todos
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new
    @todo.content = params[:content]
    @todo.user_id = params[:user_id]

    if @todo.save
      redirect_to todos_url, :notice => "Todo created successfully."
    else
      render 'new'
    end
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def update
    @todo = Todo.find(params[:id])

    @todo.content = params[:content]

    if @todo.save
      redirect_to todo_url(@todo.id), :notice => "Todo updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @todo = Todo.find(params[:id])

    @todo.destroy

    redirect_to todos_url, :notice => "Todo deleted."
  end
end

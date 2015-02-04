class TodosController < ApplicationController

  # Implement the before_action :set_todo

  # Create an RCAV for /public_todos, which displays all todos
  #   in the system rather than only the signed-in user's.
  #   Allow non-signed in users to visit this action.


  before_action :set_todo, :only => [:show, :edit, :update, :destroy]

  skip_before_action :authenticate_user!, :only => [:everyones_todos]

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def everyones_todos
    @todos = Todo.all

    render 'index'
  end

  def index
    @todos = current_user.todos
  end

  def show
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new
    @todo.content = params[:content]
    @todo.user = current_user

    if @todo.save
      redirect_to todos_url, :notice => "Todo created successfully."
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @todo.content = params[:content]

    if @todo.save
      redirect_to todo_url(@todo.id), :notice => "Todo updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @todo.destroy

    redirect_to todos_url, :notice => "Todo deleted."
  end

  before_action :ensure_current_user_is_owner, :only => [:destroy, :edit, :update]

  def ensure_current_user_is_owner
    unless @todo.user == current_user || current_user.admin?
      redirect_to root_url, :alert => "Nice try, sucker"
    end
  end
end

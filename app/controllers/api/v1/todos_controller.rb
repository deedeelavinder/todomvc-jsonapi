class API::V1::TodosController < ApplicationController

  def index
    @todos = Todo.all
    render json: @todos
  end

  def show
    render json: @todo
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render json: @todo, status: :created, location: api_v1_todo_path(@todo)
    else
      render json: {errors: @todo.errors}, status: :bad_request
    end
  end

  def update
    @todo = Todo.find(params[:id])

    if @todo.update(todo_params)
      render json: @todo, status: :ok
    else
      render json: {errors: @todo.errors}, status: :bad_request
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
  end

  private

  def todo_params
    params.permit( :title, :order, :completed)
  end

end
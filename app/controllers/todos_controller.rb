class TodosController < ApplicationController

  def index
    begin
      if params[:id] || params[:body] || params[:completed]
        todo_match = Todo.new
        response, response_code = todo_match.get(params)
        render_response(response, response_code)
      else
        all_todos = Todo.all
        render_response(all_todos, 200)
      end
      rescue ActiveRecord::RecordNotFound => error
        render_response(error.message, 404)
      rescue StandardError => error
        render_response(error.message, 422)
    end
  end

  def new
    new_todo = Todo.create
    render_response(new_todo, 200)
  end

  def create
    new_todo = Todo.create(body: params[:body])
    render_response(new_todo, 200)
  end

  def show
    begin
      todo_match = Todo.new
      response, response_code = todo_match.get(params)
      render_response(response, response_code)
    rescue ActiveRecord::RecordNotFound => error
      render_response(error.message, 404)
    rescue StandardError => error
      render_response(error.message, 422)
    end
  end

  def update
    begin
      todo = Todo.find(params[:id])
      todo.completed = params[:completed] if params[:completed]
      todo.body = params[:body] if params[:body]
      todo.save
      render_response(todo, 200)
    rescue ActiveRecord::RecordNotFound => error
      render_response(error.message, 404)
    rescue StandardError => error
      render_response(error.message, 422)
    end
  end

  def destroy
    begin
      todo = Todo.find(params[:id])
      todo.destroy
      render_response("deleted", 200)
    rescue ActiveRecord::RecordNotFound => error
      render_response(error.message, 404)
    rescue StandardError => error
      render_response(error.message, 422)
    end
  end


  def not_found
    response = []
    response_code = 404
    response << "-" * 50
    response << "Not Found LOL"
    response << "-" * 50
    response << "Response Code: #{response_code}"
    response << "-" * 50
    response = response.join("<p>")
    render_response(response, response_code)
  end

  private

  def render_response(response, response_code)
    render json: response, status: response_code
  end
end

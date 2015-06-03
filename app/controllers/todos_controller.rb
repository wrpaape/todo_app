class TodosController < ApplicationController

  def create
    new_todo = Todo.create
    render_response(new_todo, 200)
  end

  def show
    begin
      todo = Todo.find(params[:id])
      render_response(todo, 200)
    rescue ActiveRecord::RecordNotFound => error
      render_response(error, 404)
    rescue StandardError => error
      render_response(error, 422)
    end
  end

  def destroy
    begin
      todo = Todo.find(params[:id])
      todo.destroy
      render_response("deleted", 200)
    rescue ActiveRecord::RecordNotFound => error
      render_response(error, 404)
    rescue StandardError => error
      render_response(error, 422)
    end
  end

  def index
    all_todo = Todo.all
    render_response(all_todo, 200)
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

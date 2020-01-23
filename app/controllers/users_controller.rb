class UsersController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def top
    sql = "SELECT bids.user_id, users.name, users.created_at, COUNT(*)
    FROM bids
    JOIN users ON bids.user_id=users.id
    GROUP BY bids.user_id, users.id
    HAVING COUNT(*) > 1
    ORDER BY COUNT(*) DESC
    LIMIT #{params[:count]}"

    @result = ActiveRecord::Base.connection.execute(sql)
    render json: @result
  end
end

require 'pry'
require 'pg'
require 'sinatra'
require_relative 'db_config'
require_relative 'models/like'
require_relative 'models/meal'
require_relative 'models/user'

enable :sessions #sinatra gives us this functionalty, to log in/out
helpers do
  def current_user
    User.find_by(id: session[:user_id]) #this will return either an id or nil. which is truthy or falsey, so we can use it below in the logged_in? method to check true or false.
  end
  def logged_in?
    if current_user
      return true
    else
      return false
    end
  end
end

#== HOME PAGE HERE ==#
get '/' do
  @most_liked = Meal.joins(:likes).group('likes.meal_id', 'meals.id').select('meals.*, count(meal_id) as likes_count').order('likes_count desc').limit(3)
  @most_recent = Meal.includes(:likes).order(created_at: :desc).limit(3)
  # @most_recent2 = Meal.all.order(created_at: :desc).limit(3)
  erb :index
end
#== ALL MEALS PAGE HERE ==#
get '/all_meals' do
  @all_meals = Meal.includes(:likes).order(created_at: :desc)
  erb :all_meals
end
#== MEAL DETAILS PAGE ==#
get '/details/:id' do
  @meal = Meal.find(params[:id])
  erb :meal_details
end
#== MEAL DETAILS EDIT PAGE ==#
get '/details/:id/edit' do
  @meal = Meal.find(params[:id])
  erb :meal_edit
end
#== USER PROFILE PAGE ==#
get '/profile' do
  @rec_meals = Meal.includes(:likes).all.sample(3)
  @meals = current_user.meals.includes(:likes).order(created_at: :desc).limit(3)
  erb :profile
end
#== LOGIN PAGE ==#
get '/login' do
  erb :login
end
#== NEW USER PAGE ==#
get '/new_user' do
  erb :new_user
end
#== NEW MEAL PAGE ==#
get '/new_meal' do
  erb :new_meal
end
#== PUT MEAL UPDATE ==#
put '/meal/:id' do
  meal = Meal.find(params[:id])
  meal.meal_name = params[:name]
  meal.image_url = params[:image_url]
  meal.instructions = params[:instructions]
  meal.ingredients = params[:ingredients]
  meal.save
  redirect "/profile"
end
#== DELETE MEAL INCL. ASSOCIATED LIKES ==#
delete '/meal/:id' do
  if current_user
    likes = Like.where(meal_id: params[:id])
    likes.destroy_all
    meal = Meal.find(params[:id])
    meal.destroy
    redirect back
  end
end
#== POST A NEW LIKE ==#
post '/new_like' do
  if Like.exists?(:user_id => params[:user_id], :meal_id => params[:meal_id])
  else
    like = Like.new
    like.meal_id = params[:meal_id]
    like.user_id = params[:user_id]
    like.save
  end
  redirect back
end
#== POST A NEW MEAL ==#
post '/new_meal' do
  meal = Meal.new
  meal.meal_name = params[:meal_name]
  meal.ingredients = params[:ingredients]
  meal.instructions = params[:instructions]
  meal.image_url = params[:image_url]
  meal.user_id = current_user.id
  meal.save
  redirect '/profile'
end
#== POST A NEW USER ==#
post '/new_user' do
  user = User.new
  user.user_name = params[:username]
  user.email = params[:email]
  user.password = params[:password]
  user.save
  if user.errors.messages == {}
    redirect '/login'
  else
    @username_error = user.errors.messages[:user_name][0]
    @email_error = user.errors.messages[:email][0]
    @password_error = user.errors.messages[:password][0]
    erb :new_user
  end
end



#===============================
# => session functionality below
#===============================

post '/session' do
  user = User.find_by(email: params[:email])
  #if found a user
  if user && user.authenticate(params[:password])
    # successful create session then redirect
    # session = {} imagine this is what a session is. A HASH.
    # we write key/value pairs to the session
    session[:user_id] = user.id
    redirect '/profile'
  else
    @message = 'incorrect email or password'
    erb :login
  end
end

delete '/session' do
  session[:user_id] = nil
  redirect '/'
end


# backup sql query
# select meals.id, meal_name, likes.id, likes.user_id, meal_id from meals left join likes on meals.id = likes.meal_id order by meal_name;
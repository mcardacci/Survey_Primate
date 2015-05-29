get '/' do
  erb :'auth/login'
end

post '/login' do
  current_user = User.find_by(name: params[:username])
  if current_user && current_user.authenticate(params[:password])
    session[:user_id] = current_user.id
    redirect "/user/#{current_user.id}"
  else
    redirect '/?error=ua'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end


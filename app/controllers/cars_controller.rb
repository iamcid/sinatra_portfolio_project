class CarsController < ApplicationController

    get '/cars/new' do
        erb :"cars/new"
    end

    post '/cars' do
        if !logged_in?
            redirect '/'
        end

        @car = @user.cars.build(year: params[:year], make: params[:make], model: params[:model], color: params[:color])
        
        if @car.save
            redirect "/users/dashboard"
        else
            redirect '/cars/new'
        end
    end

end
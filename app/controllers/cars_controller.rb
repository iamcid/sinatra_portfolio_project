class CarsController < ApplicationController
    
    get '/cars' do
        authenticate
        @cars = @user.cars
        erb :"users/dashboard"
    end

    get '/cars/new' do
        authenticate
        erb :"cars/new"
    end

    post '/cars' do
        authenticate
        @car = @user.cars.build(year: params[:year], make: params[:make], model: params[:model], color: params[:color])
        
        if @car.save && params[:year] != "" && params[:make] != "" && params[:model] != "" && params[:color] != ""
            redirect "/users/dashboard"
        else
            @error = "Invalid input, please try again!"
            redirect '/cars/new'
        end
    end

    get '/cars/:id' do
        authenticate
        if @user
            @car = Car.find_by(id: params[:id])
            erb :"cars/show"
        else
            redirect '/login'
        end
    end

    get '/cars/:id/edit' do
        authenticate
        @car = Car.find_by(id: params[:id])
        if @car && @car.user == @user
            erb :"cars/edit"
        else
            redirect '/users/dashboard'
        end
    end

    patch '/cars/:id' do
        authenticate
        @car = Car.find_by(id: params[:id])

        if @car.user == @user && params[:year] != "" && params[:make] != "" && params[:model] != "" && params[:color] != ""
            @car.update(year: params[:year], make: params[:make], model: params[:model], color: params[:color]) 
            redirect "/users/dashboard"
        else
            erb :"/cars/edit"
        end
      end

    delete '/cars/:id' do
        authenticate
        @car = Car.find_by(id: params[:id])
        if @car
            @car.destroy
            redirect '/users/dashboard'
        end
    end
end
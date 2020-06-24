class CarsController < ApplicationController
    
    get '/cars' do
        authenticate
        @cars = @user.cars
        erb :"/users/dashboard"
    end

    get '/cars/new' do
        authenticate
        erb :"/cars/new"
    end

    post '/cars' do
        authenticate
        @car = @user.cars.build(year: params[:year], make: params[:make], model: params[:model], color: params[:color], parts: params[:parts])
        if @car.save && params[:year] != "" && params[:make] != "" && params[:model] != "" && params[:color] != "" && params[:parts] != ""
            erb :"/users/dashboard"
        else
            @error = "Invalid input, please try again!"
            erb :'/cars/new'
        end
    end

    get '/cars/:id' do
        @car = Car.find_by(id: params[:id]) 
        authorize(@car)
        erb :'/cars/show'
    end

    get '/cars/:id/edit' do
        @car = Car.find_by(id: params[:id])
        authorize(@car)
        if @car && @car.user == @user
            erb :"cars/edit"
        else
            redirect '/cars/show'
        end
    end

    patch '/cars/:id' do
        @car = Car.find_by(id: params[:id])
        authorize(@car)
        if @car.user == @user && params[:year] != "" && params[:make] != "" && params[:model] != "" && params[:color] != "" && params[:parts] != ""
            @car.update(year: params[:year], make: params[:make], model: params[:model], color: params[:color], parts: params[:parts]) 
            erb :"/cars/show"
        else
            @error = "All input fields must be filled out!"
            erb :"/cars/edit"
        end
      end

    delete '/cars/:id' do
        @car = Car.find_by(id: params[:id])
        authorize(@car)
        @car.delete
        redirect '/users/dashboard'
    end
end
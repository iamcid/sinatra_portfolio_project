class PartsController < ApplicationController
    
    get '/parts' do
        authenticate
        @parts = @car.parts
        erb :"users/dashboard"
    end

    get '/parts/new' do
        authenticate
        erb :"parts/new"
    end

    post '/parts' do
        authenticate
        @part = @cars.parts.build(name: params[:name], category: params[:category])
        
        if @part.save && params[:name] != "" && params[:category] != ""
            redirect "/cars/show"
        else
            @error = "Invalid input, please try again!"
            redirect '/parts/new'
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
        if @car.user == @user && params[:year] != "" && params[:make] != "" && params[:model] != "" && params[:color] != ""
            @car.update(year: params[:year], make: params[:make], model: params[:model], color: params[:color]) 
            erb :"/cars/show"
        else
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
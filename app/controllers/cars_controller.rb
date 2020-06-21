class CarsController < ApplicationController

    get '/cars/new' do
        erb :"cars/new"
    end

    post '/cars' do

    end

end
Rails.application.routes.draw do


  devise_for :users
  root 'post#index'
  get '/tests' => 'post#tests'
  post '/update' =>'post#update'
  get '/content/:id' => 'post#content', as: :content
  post '/reply/:id'=> 'post#reply', as: :reply
  post '/re_reply/:post_id/:reply_id'=> 'post#re_reply'
 
  get '/search/:id' =>'post#search',as: :search
  get '/edit/:id' =>'post#edit', as: :edit
  post '/edit_update/:id' =>'post#edit_update', as: :edit_update
  post '/delete/:id' =>'post#delete',as: :delete
  
  get 'post/write' => 'post#write', as: :write
end

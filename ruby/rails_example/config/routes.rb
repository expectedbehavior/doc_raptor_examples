ActionController::Routing::Routes.draw do |map|
  map.resources :save_to_paperclip_examples, :only => [:new, :create, :index, :destroy]
end

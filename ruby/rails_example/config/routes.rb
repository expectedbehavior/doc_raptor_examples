ActionController::Routing::Routes.draw do |map|
  map.resources :save_to_paperclip_examples, :only => [:new, :create, :index, :destroy]
  
  map.root :controller => :save_to_paperclip_examples
end

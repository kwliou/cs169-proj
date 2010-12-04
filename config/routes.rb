ActionController::Routing::Routes.draw do |map|
  map.about 'about', :controller => :main, :action => :about
  map.feedback 'feedback', :controller => :main, :action => :feedback
  map.help 'help', :controller => :main, :action => :help
  #:parse => {:id => /([^\?\/](?!(xml|html)(?!\.(xml|html))))+/},

  # :requirements is for usernames with periods in them
  map.resources :users, :requirements => {:id => /[^\?\/]+/} do |user|
    user.resources :ratings
    user.posts 'posts', :controller => :posts, :action => :index_user, :requirements => { :user_id => /([^\/?]+)/ }
  end
  map.connect '/courses/:course_id/grades/:action', :controller => 'grades'
  map.resources :assignments
  map.resources :blurbs
  map.resources :departments #, :except => :destroy
  map.resources :user_sessions
  map.resources :courses, :collection => {:auto_complete_for_department_name => :get } do |course|
    # :requirements is for items with periods in them ex. Chapter 2.1 Questions
    course.subscribe 'subscribe', :controller => :courses, :action => :subscribe
    course.unsubscribe 'unsubscribe', :controller => :courses, :action => :unsubscribe
    course.resources :grades
    course.resources :ratings
    course.resources :items, :requirements => {:id => /[^\?\/]+/} do |item|
      item.ajaxupdate 'posts/update_results', :controller => :posts, :action => :update_results, :method => :get, :requirements => {:item_id => /[^\?\/]+/}
      item.resources :posts, :requirements => {:item_id => /[^\?\/]+/} do |post|
        post.reply 'reply', :controller => :posts, :action => :new_post_reply, :requirements => {:item_id => /[^\?\/]+/}
      end
    end
  end
  # example of how huge nesting is "funny-looking" so instead use a query string
  # /courses/COMPSCI_3/items/category/assignment => /courses/COMPSCI_3/items?category=assignment
  # map.connect '/courses/:course_id/items/category/:category', :controller => :items, :action => :index
  
  # map.connect '/courses/:id/items', :controller => :items, :action => :index
  map.resources :grades
  map.connect '/courses/:id/grades', :controller => :grades, :action => :index
  map.create_course_grade '/courses/:course_id/grades/create', :controller => :grades, :action => :create
  
  map.resources :courses, :has_many => :ratings
  map.resources :users, :has_many => :ratings
  
  map.login 'login', :controller => :user_sessions, :action => :new
  map.logout 'logout', :controller => :user_sessions, :action => :destroy
  map.mobile 'mobile', :controller => :mobile, :action => :index

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => :main, :action => "index"


  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/destroy/:id', :action => :index
  map.connect ':controller/destroy/:id.:format', :action => :index
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

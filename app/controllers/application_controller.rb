# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '094c0c1163f3b1fb659bc9fb822938a5'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  #logger.info ">>> #{ Rails.public_methods.sort.join('   ') }"
  before_filter :login?
  
  def login?
    unless current_user || [ 'user_sessions', 'users'  ].include?( params['controller'] )
      flash[:error] = "Login or create an Account First"
      redirect_to( login_url )
    end
  end
end

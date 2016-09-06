class WelcomeController < ApplicationController
	def say
	end

	def index
	end

  def ajaxtest
    respond_to do |format|
      format.html { render :layout => false } # ajaxtest.html.erb
      format.json {
        render :json => { :title => Time.now }
      }
      format.js # ajaxtest.js.erb
    end

  end
end

class Admin::AddMultiplesController < ApplicationController
  layout 'admin/application.html.erb'
 

  # POST /admin/add_multiples
  def create

   @admin_add_multiple = Admin::AddMultiple.new(params[:file])
    @admin_add_multiple.save 
      redirect_to admin_add_multiples_path, notice: "Add #{@admin_add_multiple.count} users was 
      successfully created. The following rows failed #{@admin_add_multiple.failed}. If any 
      rows failed please create new csv file for the failed rows and correct the issue."
  end

end
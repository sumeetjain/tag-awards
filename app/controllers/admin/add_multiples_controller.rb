module Admin
class AddMultiplesController < ApplicationController
  layout 'admin/application.html.erb'
 

  # POST /admin/application/add_multiples
  def create

   @admin_add_multiple = AddMultiple.new(params[:file])
    @admin_add_multiple.save 
      redirect_to admin_application_add_multiple_path, notice: "Add #{@admin_add_multiple.success} users was 
      successfully created. The following rows failed #{@admin_add_multiple.failed}. If any 
      rows failed please create new csv file for the failed rows and correct the issue.
      Default password is TagNumber1!"
  end

  def display

  end

end
end
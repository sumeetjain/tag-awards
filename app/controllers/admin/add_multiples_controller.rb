class Admin::AddMultiplesController < ApplicationController
  # layout 'admin/application.html.erb'
  before_action :set_admin_add_multiple, only: [:show, :edit, :update, :destroy]

  # GET /admin/add_multiples
  def index
    @admin_add_multiples = Admin::AddMultiple.all
  end

  # GET /admin/add_multiples/1
  def show
  end

  # GET /admin/add_multiples/new
  def new
    @admin_add_multiple = Admin::AddMultiple.new
  end

  # GET /admin/add_multiples/1/edit
  def edit
  end

  # POST /admin/add_multiples
  def create


   @admin_add_multiple = Admin::AddMultiple.new(params[:file])
    @admin_add_multiple.save 
      redirect_to admin_add_multiples_path, notice: "Add #{@admin_add_multiple.count} users was 
      successfully created. The following rows failed #{@admin_add_multiple.failed}. If any 
      rows failed please create new csv file for the failed rows and correct the issue."



  end

  # PATCH/PUT /admin/add_multiples/1
  def update
    if @admin_add_multiple.update(admin_add_multiple_params)
      redirect_to @admin_add_multiple, notice: 'Add multiple was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/add_multiples/1
  def destroy
    @admin_add_multiple.destroy
    redirect_to admin_add_multiples_url, notice: 'Add multiple was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_add_multiple
      @admin_add_multiple = Admin::AddMultiple.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_add_multiple_params
      params[:admin_add_multiple]
    end
end
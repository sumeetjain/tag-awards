module Admin
  class AwardsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Award.all.paginate(10, params[:page])
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Award.find_by!(slug: param)
    # end

    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information

    def build_ballot
      @award = Award.find(params[:id])

      finalists = []

      params[:ballot][:finalists].values.each do |finalist|
        if !finalist["info"].nil?
          nominee = finalist["info"].split("||")[0]
          role = finalist["info"].split("||")[1]
          play_id = finalist["play_id"]

          if !play_id.blank?
            finalist_hash = {
              play_id: play_id,
              nominee: nominee,
              role: role
            }

            finalists << finalist_hash
          end
        end
      end

      if finalists.any? && @award.ballot_items.create(finalists)
        @award.update(ballot_set: true)
        
        redirect_to :top_ten_admin_nominations, notice: "Ballot for #{@award.award_name} set!"
      else
        redirect_to :top_ten_admin_nominations, alert: "Failed to set ballot."
      end
    end
  end
end

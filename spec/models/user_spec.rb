# require 'rails_helper'

# RSpec.describe User, type: :model do

# # I am pretty sure this is an incorrect usage. I should probably be calling #generate_token directly in the test instead of relying on the before filter. This would perhaps be better suited for the controller spec?

#   describe "#generate_token" do
#     context "when users get created" do
#       it "generates a unique token" do
#         user = User.create!(full_name: "Tom Hanks", password: "Password123", email: "tom@gmail.com")
#         other_user = User.create!(full_name: "Fred Fred", password: "Password123", email: "fred@gmail.com")
#         expect(user.secret_number).to_not eq(other_user.secret_number)
#       end
#     end
#   end

#   describe "#nomination_value" do
#     context "when this nomination was previously saved" do
#       it "returns the proper string of the previous nomination" do
#         @user1 = User.new
#         @user1.id = 1
#         @user1.save
#         @nom1 = Nomination.new
#         @nom1.nominee = "Grace Bydalek"
#         @nom1.role = "Natalie"
#         @nom1.show = "Next to Normal"
#         @nom1.theater = "Shelterbelt"
#         @nom1.user_id = @user1.id
#         @nom1.award_id = 1
#         @nom1.save

#         assert_equal("Grace Bydalek", @user1.nomination_value(1, 0, "nominee"))
#         assert_equal("Shelterbelt", @user1.nomination_value(1, 0, "theater"))
#       end
#     end
#     context "when this nomination hasn't been previously saved" do
#       it "returns an empty string" do
#         @user1 = User.new
#         @user1.id = 1
#         @user1.save
#         @nom1 = Nomination.new
#         @nom1.nominee = "Grace Bydalek"
#         @nom1.role = "Natalie"
#         @nom1.show = "Next to Normal"
#         @nom1.theater = "Shelterbelt"
#         @nom1.user_id = @user1.id
#         @nom1.award_id = 1
#         @nom1.save

#         assert_equal("", @user1.nomination_value(1,1, "nominee"))
#       end
#     end
#   end

#   describe "#record_nominations" do
#     it "saves user's new nomination to database" do
#       @user1 = User.new
#       @user1.id = 1
#       @user1.save
#       nominations_hash =
#       {"1"=>
#         {"nominations"=>
#           {"0"=>{"theater"=>"Shelterbelt", "show"=>"Next to Normal", "nominee"=>"Grace Bydalek", "role"=>"Natalie"},
#            "1"=>{"theater"=>"", "show"=>"", "nominee"=>"", "role"=>""}}}}

#       assert_equal({"1"=>{"nominations"=>{"0"=>{"theater"=>"Shelterbelt", "show"=>"Next to Normal", "nominee"=>"Grace Bydalek", "role"=>"Natalie"}, "1"=>{"theater"=>"", "show"=>"", "nominee"=>"", "role"=>""}}}},
#         @user1.record_nominations(1, nominations_hash))
#     end
#   end

#   describe "#save_nomination_object" do
#     it "saves nomination to database" do
#       @user1 = User.new
#       @user1.id = 1
#       @user1.save
#       value3 = {"theater"=>"Shelterbelt", "show"=>"Next to Normal", "nominee"=>"Grace Bydalek", "role"=>"Natalie"}

#       assert_equal(true, @user1.save_nomination_object(1, 1, value3))
#     end
#   end

#   describe "#set_secret_number" do
#     it "assigns token to the current user" do
#       @user1 = User.new
#       @user1.id = 1
#       @user1.save
#       @test_token = @user1.send(:set_secret_number)
#       @user1.save

#       assert_equal(@test_token, @user1.secret_number)
#     end
#   end

#   describe "#generate_token" do
#     it "randomly picks a 6-digit alphanumeric key" do
#       @user1 = User.new
#       @user1.id = 1
#       @user1.save
#       @test_token = @user1.send(:generate_token)
#       @user1.secret_number = @test_token
#       @user1.save
#       @token_length = @user1.secret_number.split('').length

#       assert_equal(@token_length, 6)
#     end
#   end

# end


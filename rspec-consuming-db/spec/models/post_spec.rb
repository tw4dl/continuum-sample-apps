require 'spec_helper'

describe Post do
  it "does something" do
  	# Create
  	post = Post.new
  	post.id.should be_blank
  	post.title = "Fresh"
  	post.save!

  	# Retrieve
  	db_post = Post.find(post.id)
  	db_post.title.should == "Fresh"
  	db_post.body.should be_blank

  	# Update
  	db_post.body = "West Philadelphia, born and raised."
  	db_post.save!
  	db_post.title.should == "Fresh"
	db_post.body.should == "West Philadelphia, born and raised."

  	# Delete
  	db_post.destroy!

  	Post.all.should be_blank
  end
end

require 'spec_helper'

describe "/posts/new.html.erb" do
  include PostsHelper

  before(:each) do
    assigns[:post] = stub_model(Post,
      :new_record? => true,
      :title => "value for title",
      :body => "value for body",
      :tags => "value for tags"
    )
    @user = stub_model(User,{})
  end

  it "renders new post form" do
    render

    response.should have_tag("form[action=?][method=post]", user_posts_path(@user)) do
      with_tag("input#post_title[name=?]", "post[title]")
      with_tag("textarea#post_body[name=?]", "post[body]")
      with_tag("input#post_tags[name=?]", "post[tags]")
    end
  end
end

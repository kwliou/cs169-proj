require 'spec_helper'

describe "/posts/index.html.erb" do
  include PostsHelper

  before(:each) do
    assigns[:posts] = [
      stub_model(Post,
        :title => "value for title",
        :body => "value for body",
        :tags => "value for tags"
      ),
      stub_model(Post,
        :title => "value for title",
        :body => "value for body",
        :tags => "value for tags"
      )
    ]
  end

  it "renders a list of posts" do
    render
    response.should have_tag("tr>td", "value for title".to_s, 2)
    response.should have_tag("tr>td", "value for body".to_s, 2)
    response.should have_tag("tr>td", "value for tags".to_s, 2)
  end
end

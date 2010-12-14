Given /^I posted "([^"]*)" with "([^"]*)" under "([^"]*)"$/ do |title, body, tags|
  @post = @item.posts.create!(
    :user_id => @current_user.id,
    :title => title,
    :body => body,
    :tags => tags)
end

Given /^"([^"]*)" posted "([^"]*)" with "([^"]*)" under "([^"]*)" $/ do |user, title, body, tags|
  @user = User.create!(
    :first_name => user,
    :last_name => "Dummy",
    :username => user,
    :password => "password",
    :password_confirmation => "password",
    :email => "dummy@example.com")
  @post2 = @item.posts.create!(
    :user_id => @user.id,
    :title => title,
    :body => body,
    :tags => tags)
end
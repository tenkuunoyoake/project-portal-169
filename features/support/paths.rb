# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    when /^the login page$/
      '/login'
    when /^the project submit page$/
      '/projects/new'
    when /^the project details page for project with name: "(.*)"$/
      project_path(Project.find_by(title: $1))
    when /^the project list page$/
      '/projects'
      
    when /^the GSI registration page$/
      '/instructors/new'
    when /^the profile page for the GSI with name: "(.*)"$/
      instructor_path(Instructor.find_by(name: $1))
      
    when /^the student registration page$/
      '/student_teams/new'
    when /^the profile page for the student team: "(.*)"$/
      student_team_path(StudentTeam.find_by(name: $1))
    when /^the student list page$/
      '/student_teams'
    when /^the iteration submission page for the student team: "(.*)"$/
      "/student_teams/#{StudentTeam.find_by(name: $1).id}/submit_story"
    when /^the comment list page$/
      '/comments'
      
    when /^the profile page for the customer: "(.*)"$/
      customer_path(Customer.find_by(name: $1))
    when /^the customer registration page$/
      '/customers/new'
    when /^the edit page for project: "(.*)"$/
      "/projects/#{Project.find_by(title: $1).id}/edit"
    when /^the profile page for project: "(.*)"$/
      "/projects/#{Project.find_by(title: $1).id}"
    
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)

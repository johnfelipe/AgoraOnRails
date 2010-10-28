module HelperMethods
  def login_as(user)
    visit login_path
    fill_in "Introduce tu usuario", :with => user.login
    fill_in "Dinos tu contraseña", :with => "secret"
    click_button "Identifícate"
  end

  def percentages_should_be(proposal, results)
    within(:css, "#proposal_#{proposal.id}") do
      results.each do |key, value|
        page.should have_css(".#{key} span.vote_percentage", :text => "#{value}%")
      end
    end
  end
  
  def number_of_votes_should_be(proposal, votes)
    proposal.reload
    votes.each do |key, value|
      proposal.send(key).should == value
    end
  end
  
  def should_see_hot_proposals_in_this_order(titles)
    titles.each_with_index do |title, index|
      page.should have_css("#hot_proposals .proposal:nth-child(#{index + 2}) .title", :text => title)
    end
  end
  
end

Spec::Runner.configuration.include(HelperMethods)

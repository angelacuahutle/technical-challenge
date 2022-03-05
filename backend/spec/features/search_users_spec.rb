require "rails_helper"

describe "search github users" do
  context "when logged-in" do
    it "finds a user" do
      visit '/home/'
      find_field('Search Users').set('DAVID HEINEMEIER HANSSON')

      expect(page).to have_content('David Heinemeier Hansson')
      expect(page).to have_content('dhh')
    end
  end
end

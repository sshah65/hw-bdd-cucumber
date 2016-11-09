# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
        Movie.create(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  page.should have_content(/(.*)#{e1}(.*)#{e2}(.*)/)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
    rating_list.split.each do |rating|
        step %Q{I #{uncheck}check "ratings_#{rating}"}
    end
end

Then /I should see all the movies/ do
    rows_from_db = 10 # TODO find a way to replace hard-coded number with actual DB request
    rows_on_page = page.all(:xpath, "//table[@id='movies']/tbody/tr").count
    expect(rows_on_page).to eq rows_from_db
end
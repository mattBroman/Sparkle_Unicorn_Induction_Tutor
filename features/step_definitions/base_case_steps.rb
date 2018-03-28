

Then (/^type my correct base case for simple arithmetic$/) do
    #Capybara.javascript_driver = :selenium
    #Capybara.current_driver = Capybara.javascript_driver
    
    
    
    
    

        fill_in "comment", :with => "\\begin{base}
     let b = 3
    
    b*2 = 6
    
    \\end{base}"
    

 

  
    p page.find_by_id("plain_text").value
    p page.find_by_id("pretty_page").value

 
    

end


Then (/^I should see true in the responce textbox$/) do
    p page.find_by_id("pretty_page").value
    p page.find_by_id("responce").value
    
end

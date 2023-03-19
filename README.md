# STAT-6080
STAT 6080 Data Technologies Group Project

Our group proposes a sports-related project which will involve both web scraping, simulation and visualization.  The ultimate goal of the project is to do a very basic touchdown pass simulation to compare the top twelve retired NFL quarterbacks with the most touchdown passes with all other quarterbacks.  These top twelve players are:  Tom Brady, Drew Brees, Peyton Manning, Brett Favre, Philip Rivers, Dan Marino, Ben Roethlisberger, Eli Manning, Fran Tarkenton, John Elway, Carson Palmer and Warren Moon.

To do so, we will scrape every quarterback's individual season statistics from https://www.pro-football-reference.com/ using the Rvest package.  We will systematically go through all players on the website, only scraping the per year statistics from those who whose positions played includes quarterback.  We expect the results of this web scrape to provide from several hundred to one thousand individual players to compare.

Once we have the necessary information, each player’s season statistics will be combined into one dataset, which will allow us to run multiple separate simulations.  
The first will be the equivalent of one season where one value will be randomly sampled by the sample function from each player’s totals.  By including each player’s entire career, including early and late career seasons where they may have produced fewer touchdown passes owing to less playing time as well as seasons where the player was injured, we hope to potentially include the equivalent of relatively ineffective or injured seasons in our simulation.  

The second simulation will be the equivalent of a career full of these random seasons.  In this case we will randomly sample, with replacement, from each player’s career a set number of times, for example ten times, to represent career statistics, summing their sampled totals to determine who throws the most touchdown passes over a career of these random seasons.

Another simulation will remove early career and injured seasons, so for example, seasons where a quarterback had fewer than ten touchdown passes, and repeat our earlier simulation to see if different quarterbacks score more highly when removing these types of seasons.  

We will also run a simulation where we prematurely end a player's career after their highest performing season and do our sample from  all seasons up to and including this peak year.  The length of time that each quarterback played prior to their peak season will likely vary considerably, introducing more variability and potentially more interesting results to our analysis.

For each of our simulations we will create visualizations displaying our results.  The primary goal of these will be to get a feel for how touchdowns passes are distributed overall and see how players tended to vary over our repeated simulations.  A secondary goal will be to compare our top all-time quarterbacks' results with those of the field, where perhaps these top quarterbacks are highlighted in some way to easily see if they fare as well as expected throughout the various simulations.

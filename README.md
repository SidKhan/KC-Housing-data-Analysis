# KingCounty-House-sales-prediction-data-Analysis


**The Data**:


19 house features plus the price and the id columns, along with 21613 observations.

1. id - a notation for a house

2. date - Date house was sold

3. price - Price is prediction target

4. bedrooms - Number of Bedrooms/House

5. bathrooms - Number of bathrooms/bedrooms

6. sqft_living - square footage of the home

7. sqft_lot - square footage of the lot

8. floors - Total floors (levels) in house

9. waterfront - House which has a view to a waterfront

10. view - Has been viewed

11. condition - How good the condition is ( Overall )

12. grade - overall grade given to the housing unit, based on King County grading system

13. sqft_above - square footage of house apart from basement

14. sqft_basement - square footage of the basement

15. yr_built - Built Year

16. yr_renovated - Year when house was renovated

17. zipcode - zip

18. lat - Latitude coordinate

19. long - Longitude coordinate

20. sqft_living15 - Living room area in 2015(implies-- some renovations) This might or might not have affected the lotsize area

21. sqft_lot15 - lotSize area in 2015(implies-- some renovations)



**Overview**:


The idea of this project is to explore the data and find the degree of association between different variables. This is approached by creating visuals/graphs and statistical metrics like correlation coefficients. Finally, using various regression methods to try to predict the house prices. There are numerous ways to fulfill the purpose and each has its pros and cons. In this project, I have chosen Multiple Regression analysis because its straightforward, gives more insight about the data and makes easier to interpret the relationship between the response and the explanatory variables.


**Contents:**


The analysis comprises of:

     •	importing the data into R.
     •	summarizing the data to locate any limitations like missing values or unusual/wrong data entries. 
     •	Inspecting the distribution of dependent (Price) and independent variables.
     •	Applying any variable transformations (like log).
     •	Exploratory Analysis of variables.
     •	Treating outlier and checking its effect.
     •	Building tables to check the effect of variable on response variable
     •	Creating visuals like Scatter plots, bar charts, histograms.
     •	Creating new variables to perform further deep analysis.
     •	Building Correlation matrix to examine relationship between variables.
     •	Regression Analysis (simple and multiple).
     •	Prediction with the final model and plotting the Actual vs Fitted values.

**Requirements:**

The environment used here is R version 3.5.1. The packages that are used are:

     •	ggplot2
     •	readr
     •	RColorBrewer
     •	dplyr
     •	gridExtra
     •	corrplot
     •	caret
     •	ggmap
     •	tidyverse
     •	moderndive
**Output Link**

To view the full output refer to the following link:
https://docs.google.com/document/d/1KgajDwFYQENDZwa5v8lfygzN_WMQlWUdfjwJhhvU0dU/edit

# KC-Housing-data-Analysis


**The Data**:


19 house features plus the price and the id columns, along with 21613 observations.

id - a notation for a house

date - Date house was sold

price - Price is prediction target

bedrooms - Number of Bedrooms/House

bathrooms - Number of bathrooms/bedrooms

sqft_living - square footage of the home

sqft_lot - square footage of the lot

floors - Total floors (levels) in house

waterfront - House which has a view to a waterfront

view - Has been viewed

condition - How good the condition is ( Overall )

grade - overall grade given to the housing unit, based on King County grading system

sqft_above - square footage of house apart from basement

sqft_basement - square footage of the basement

yr_built - Built Year

yr_renovated - Year when house was renovated

zipcode - zip

lat - Latitude coordinate

long - Longitude coordinate

sqft_living15 - Living room area in 2015(implies-- some renovations) This might or might not have affected the lotsize area

sqft_lot15 - lotSize area in 2015(implies-- some renovations)



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

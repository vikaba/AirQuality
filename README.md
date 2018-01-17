# Air Quality and Population Demographics in the US

This is the project I created for my Fall 2017 DS4100 class. Below are all of the steps I took in the project.
The actual code is contained in the R notebook in this repository or can be found along the description of the steps by downloading the html output of the R notebook from the repository. A video presentation of this project can be found <a href="https://youtu.be/zO5I3hTOqkI">here</a>.

<h2> Introduction + Purpose </h2>
<p> For this project, I wanted to create a linear regression model for different population demographics by US location and respective air quality in that location.
This was very interesting to me because I am very interested in environmental discrimination such as environmental racism. Therefore, I wanted to know if factors such as poverty, race, and gender affect the air quality in respective areas because this could potentially point to a symptom of environmental discrimination. </p>

<h2> Data Description + Sources </h2>
<p> The data for poverty was in the form of percentage of people in poverty by US county. The racial data was organized by white, black, hispanic, asian, and native american percentages by US county. The gender data was male percentages by US county. The air quality data was organized by number of days data was recorded, the number of good, moderate, unhealthy, very unhealthy, and hazardous data.</p>
<p> Because data was only available for all counties for 2010 for all of the variables I wanted in my model, that is the data I chose to use, even though it is not the most recent. </p>
<p> The race and poverty by county data is from the US Census' Data Mapper tool.</p>
<p> The poverty data is from the US Census' Small Area Income and Poverty Estimates tool.</p>
<p> The air quality data is from the EPA yearly Air Quality Index Report (https://www.epa.gov/outdoor-air-quality-data/air-quality-index-report).</p>

<h2> Database Storage </h2>
<p>A relational SQL database was then created in my mySQL to store all values for air quality measurements and the demographic measurements by state.</p>
<p>The database has tables for poverty, race, gender, and air quality.</p>

<h2> Data Visualizations </h2>
<p>Before creating a model for and evaluation the data, I used Tableau to create several visualizations that demonstrate some of the features by state and county as the data is interesting to visualize.</p>

<img src = "Poverty by State.png">
<img src = "White by State.png">
<img src = "Poverty vs Percent of White People per County.png">
<p> As can be seen from this visualization, the smaller circles which represent a low percentage of white people, are mostly darker colored than the bigger circles, meaning they have a higher poverty percentage. </p>
<img src = "Good Days by State.png">

<h2> Evaluating the Data </h2>

<h4> Outliers </h4>
<p>First, outliers were identified in the response variable of good days by seeing which values were about 3 standard deviations from the mean. </p>
<p> Because this model deals with air quality data, I did not think it was necessary to omit these outliers. From looking at the outliers (of which there were only 8), the number of good days was low for those days because moderate or unhealthy days were high and I think that is important data to have. It also did not seem like these outliers were due to wrongful experimentation. </p>

<h4> Distribution </h4>
<p>The response variable of good days was then analyzed for normal distribution with a histogram.</p>
<p>A squared transform was then applied to the good days to normalize the good days variable.</p>

<h4> ANOVA </h4>
<p>ANOVA's were done to see if certain features alone were enough to predict the percentage of good days for a location. These were done for male percentage, white percentage, and poverty percentage.</p>
<p>Then, ANOVA's were done to see if these features with other features present were a significant predictor variable.</p>

<h4> Scatter Plots </h4>
<p> Scatter plots were also done to see if there was a linear regression relationship between gender, race, and poverty features and air quality numbers </p>

<h4> Spearman Rank and Pearson Moment Coefficients </h4>
<p> Spearman and Pearson coefficients were also used to assess correlation between poverty, race, and gender percentages </p>
<p> Before the tests were performed on these features, an effort was made to normalize them for better correlation coefficient testing. No transforms were made on any of the data. The poverty data was relatively normally distributed. The race and gender data was skewed but did not respond well to transforms. </p>

<p> For all of the features evaluated, the Spearman Rank and Pearson Moment coefficients are relatively close to each other. This means that outliers do not seem to be having an effect on the data. However, all of the coefficients are very low and significantly below 0.8. Because none of the coefficients are 0, there seems to be some correlation between these features and the number of good air quality days, but not enough to say that there is significant correlation.
There is the least correlation between percent poverty and good air quality and the most correlation between percent of males and good air quality. None of these correlations, however, are strong.</p>

<p> The race and gender data is also not normally distributed which may be affecting the correlation coefficients. However, because the Spearman Rank and Pearson Moment coefficients for these 2 features were relatively close, the distribution does not seem to be significantly affecting the correlation coefficients </p>

<h2> Building the Model(s) </h2>
<p>The desired model for this dataset is a multiple linear regression model with some response variable dealing with the number of days of a certain air quality.

<h4> Model with Good Days as Response Variable </h4>
<p> The first model has the good days as a response variable.</p>
<p> The data was first randomly split up 50-50 into a training and validation sets.</p>
<p> Next, using the test data set was used to judge the accuracy of the model by calculating the prediction accuracy with the predicted values for the test data set. AIC and BIC calculations were also performed as they are good measures for model selection, in case other models are created for this data. </p>
<p> Using the training and test data set to calculate the prediction accuracy, the model was correct about 39% of the time.</p>

<h4> Model with Combo of Good and Moderate Days as Response Variable </h4>
<p> To create this model, the sum of good and moderate days was taken to create the feature of acceptable air quality days. </p>
<p> Then, outliers were identified again in the same method of standard deviation from the mean as the last model. Once again, I decided to leave these outliers in for more accurate data and because I believe this data is significant for analysis </p>
<p> A histogram was then used to see the distribution of the response variable.</p>
<p> Because none of the transform had a significant effect on the distribution of the heavily right skewed data, the data was left as is. </p>
<p> The data was then once again randomly split up 50-50 into training and test data sets. </p>
<p> Then, to create a multiple linear regression model, backward fitting was again used and features with p values > 0.05 were removed at each step. </p>

<p> Next, using the test data set was used to judge the accuracy of the model by calculating the prediction accuracy with the predicted values for the test data set. AIC and BIC calculations were also performed as they are good measures for model selection, in case other models are created for this data. </p>

Using the training and test data set to calculate the prediction accuracy, the model was correct about 24% of the time.

<h2> Evalulation of Models </h2>

<h4> Model 1: Good Days as Response Variable </h4>
<p> Overall, this model is not a very good measure for predicting the percentage of good air quality days a location will have. Both the multiple R squared and the adjusted R squared are very low and are significantly below 0.7. This means that the variation of good air quality days is not significantly explained by this model. The calculated MAD for this model is 28.66 which is not very close to 0, meaning there is a significant amount of deviation in this model. The model is statistically significant because the p-values for each feature as well as the overall model p-value are well below 0.05.

<h4> Model 2: Good+Moderate Days as Response Variable </h4>
<p> This model is also not a great measure for predicting the percentage of acceptable days (that is, good and moderate days). The multiple R squared and the adjusted R sqaures are even lower in this model than the previous model. This means that even less variation in the acceptable air quality days is described by this model than the previous model. The calculated MAD for this model, however, is 0.074, which is much closer to 0 than the previous model. Meaning that there is much less deviation in this model than the previous model. This makes sense because outside of the 15 outliers, the percentage of acceptable days was mostly around 90%. This model is also statistically significant with overall and individual feature p-values well below 0.05. The AIC and BIC of this model are also much lower than the previous model, meaning this model is more likely to be the true model and is closer to the truth.</p>

<h2> Conclusion </h2>
<p> Overall, I hypothesized that building a model with these above demographic features would be a good predictor for air quality is US locations. However, from the two models I have built and the data I aggregated, this does not seem to be the case. </p>
<p> There are a few reasons why this was the result: </p>
<ul>
  <li> <p> There is not enough air quality data. While there were around 3,000 records from the census demographic data, there were only about 1,000 records for the air quality data. This means that areas that could have contributed to a more successful model did not have air quality recorded. </p> </li>
  <li> <p> The correlation actually does not exist. I do not believe this is the case, because it has been shown that the correlation exists for water quality and the many environmental racism cases in the US.</p></li>
  <li> <p> The 2010 data is too old and in 2010, air quality was not dependent on any demographics. I don't, however, think this was the case as 2010 was only 7 years ago. </p></li>
</ul>



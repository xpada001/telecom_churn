# Telecom Churning Prediction

Traditional telecommunication industry is made up of telecommunication companies and Internet service
providers, which play an important role in our daily life. With technology evolution, information technology giants
such as Google and Facebook are entering the telecommunication market, and offering different ways of
information exchange. The traditional telecommunication companies are facing huge pressure. It is
crucial for the telecommunication companies to analyze and maintain their relationship with existing
customers, as well as winning new customers with marketing strategies. Therefore, retaining existing customers and building
a loyal relationship are the key factors for traditional telecommunication companies to compete with
information technology giants. This project aims to provide insights for a telecom company in
predicting the chance of a customer leaving the company.

## Data Transformation
The original dataset has a size of about 43 GB, including about 9 million users with 2 billion call records in a 3-month duration.
Since the original dataset is about call records, it is hard to see a specific user behaviour. 
Preprocessing was done to combine all the call records by caller ID. Data transformation was done to reduce the dimensions of the original dataset. 
To be specific, for each caller ID, the number of callers contacted (callersum), total number of calling records (recordsum), and calling duration (timesum) 
was calculated by month.

## Data Cleansing

### Maintain the Validity of the Dataset
It was found that for caller ID ‘8503722’, ‘12243495’ and ‘12881153’, conflicting information was
recorded. So, the observations were removed from the analysis.

### Missing data 
Since missing values are incompatible with most of the pre-implemented classification models, and that there is no clear bias for the data with missing values, 
we wanted to try both imputing these data and removing these data for our classification models.

### Outlier Detection
It was found that there exists data point with call duration longer than the
natural time in a month (>30*24*60 mins). These observations were tagged as outliers and were removed
from the analysis.

### Data Visualization
Based on the feature value distribution shown in Appendix (3), it could be found that most of the customers who left the company tend to use the services less 
while they were still using the company’s service (i.e. the churning customers were calling less frequently to fewer people, and each phone call lasted shorter). 
In other words, there is a clear difference in behavior for users with different target values. 

## Model Building
Four different models were used: Random Forest, Logistic Regression, GBDT (Gradient Boosting Decision Tree) and XGBoost.

|                     | TN       | FN    | FP     | TP    | Test Accuracy |
| -------------       | -------- | ----- | ------ | ----- | --------------|
| Random Forest       |   850263 | 22250 | 104106 | 41433 | 0.873884      |
| Logistic Regression |   915407 | 7430  | 128533 | 17121 | 0.846720      |
| GBDT                |   850919 | 22296 | 102498 | 42339 | 0.855418      |
| XGBoost             |   851827 | 21281 | 104225 | 40724 | 0.876622      |


From the result shown above, Random Forest and XGBoost provided better test accuracy than the other two algorithms. Therefore, Random Forest and XGBoost algorithm was selected for further analysis.


It is observed that the data set is imbalanced, one simple technique is to assign weights for different class.
(Class 0 weight = 0.2, Class 1 weight = 0.8) was chosen because it turned out to be balanced on both the test accuracy and ROC score.

Moreover, to reduce runtime, feature selection was done to see whether certain features can be removed from the model by using XGBoost and RandomForest building functionality.
We compared the top 10 feature selected by both models, and XGboost feature selection yielded a better result.

### Missing Data Handling
One of the amazing characteristics of XGBoost is that it is able to automatically handle missing values in the dataset. We compared the results of running XGBoost on the dataset 
with the missing values and without the missing values. We also compared with the dataset with imputed values ran by Random Forest, and we concluded that XGboost (with or without missing data) outperforms Random forest.

## More Information
For more detailed information about this project, please see the notebook and the report in this repo.

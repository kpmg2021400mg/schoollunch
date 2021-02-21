# School lunch delivery project

Due to COVID-19, schools has been shut down. Because of it, school meal itself and related businesses crashed. Also, children who were service users of school meals have poor nutrition in 2020.

Our team, 400mg view this problem as social problem, and tried to complement current business by using machine learning and deep learning.

### 1. CROP PRICE PREDICTION
By using data from ```KAMIS``` and ```KMA```, we want to predict an aspect of crop prices mainly from the previous time series price data and weather data. If the price can be predicted, the school meal services can buy produces cheaper. Also, we can ensure sustainable consumption and production patterns in long term.

### 2. DISTRIBUTION COST REDUCTION
In the case of logistic companies, using efficient and optimized route for delivery reduces transport costs. We adopted this idea to reduce transport maintenance cost. So we divide this into two steps.

#### 2-1. Dividing districts
We divided 40 districts as the maximum operation of school cafeteria is about 1500 people. We used K-nearest-Neighbors to predict the district. We used two ways to divide the district. First, we used physical distance from the schools. Also, we used weighted K-nearest Neighbors by student population. Both districts are similar, so we decided to divide the district by population as the capacity of delivery services and workforce is important.

#### 2-2. Finding efficient routes


### 3. NEW CUSTOMER TARGET
According to the report from the Bank of Korea, the population working from home will be maintained after the pandemic situation. We expand our service to young 20s who live alone and work from home, who wants to eat fresh and balanced meals and maintain the population size for each production batch(school).

To find this new customer target, we had to find some districts where our strategy could work.

#### Finding areas for our business expansion



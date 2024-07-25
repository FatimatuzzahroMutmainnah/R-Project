## Panel Data Regression

### Overview

<p align="left">This project demonstrates the application of panel data regression techniques using the R programming language. Panel data, also known as longitudinal data, involves observations over time for multiple entities, allowing for complex data structures and relationships to be analyzed.</p>

### Project Structure

<p align="left">
  - 📑 <strong>Data:</strong> The dataset used for this analysis is 	Panel101.dta from https://dss.princeton.edu/training/, which includes 8 variables and 70 data<br>
  - 📊 <strong>Data visualization:</strong> To check regression assumptions<br>
  - 🔎 <strong>Regression Methods:</strong> This project explore panel data regression methods such as Fixed Effects Model (FEM), which controls for time-invariant characteristics of entities by allowing each entity to have its own intercept, Random Effects Model (REM), which assumes that the entity-specific effects are uncorrelated with the regressors, allowing for more efficient estimation compared to fixed effects when this assumption holds, and Poolde OLS, which Analyzes the data as if all observations are from a single, pooled sample, ignoring the panel structure.<br></p>

### Key Files

<p align="left">
  - <tt>Cluster Kesehatan Balita.R</tt>: Scripts for implementing and visualizing the clustering algorithms.<br>
  - <tt>Panel Data Regression.R</tt>: Scripts for implementing and visualizing the panel data regression models.<br>
  - <tt>Images/</tt>: Directory containing all images generated from the analysis.<br>
  - <tt>README.md</tt>: This file, providing an overview and instructions for the project.<br></p>

### Getting Started

<p align="left">
  - <strong>Requirements:</strong> Ensure that R and the necessary packages are installed. You can install the required packages using the following command:<br>

  ```
install.packages(c("foreign", "car", "gplots", "stargazer", "plm", "lmtest"))
```
  - <strong>Running the Analysis:</strong> To reproduce the analysis, run the scripts in the order specified in the project structure section.</p>

### Model Estimation

<p align="left">In this analysis, we fit three key regression models to the panel data: the fixed effects model, which controls for entity-specific characteristics by allowing each entity to have its own intercept; the random effects model, which assumes that entity-specific effects are uncorrelated with the regressors for potentially more efficient estimation; and the pooled OLS model, which treats the panel data as a single combined sample. To determine the most appropriate model, we compare these models using statistical tests and criteria, including the Hausman test to assess the validity of random effects versus fixed effects, and other diagnostic tests to evaluate model fit and efficiency.</p>

### Conclusion

<p align="left">The analysis provides insights into the relationships between variables over time and across entities. The models are evaluated based on their fit and statistical significance, with comparisons made to determine the most appropriate model for the data.</p>

### Future Work

<p align="left">uture work could include exploring additional regression techniques, handling more complex panel data structures, and incorporating interaction terms or time-varying effects.</p>  

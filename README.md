# Data_Detox_SQL_Data_Cleaning_Journey

### Objective
To clean and standardize a dataset containing information about company layoffs, ensuring accurate and complete data for further analysis. The project focused on addressing null values, blanks, duplicates, and irrelevant rows and columns.

### Tools Used:
* SQL(MySQL): Data Manipulation And Querying

### Process:
**1. Removing Duplicates:**
   * Identified and removed duplicate rows to ensure each entry in the dataset was unique and reliable.

**2. Handling Null and Blank Values:**
* Challenge: Blanks in the industry column were causing issues.
* Solution: Converted blanks to null values for consistency. Updated rows in table T1 by joining with T2 to fill missing industry values, successfully populating the missing data.

**3.	Managing Inconsistent Data:**
* Updated entries where blank values were converted to nulls. This process helped resolve the initial issue with the industry column, allowing for accurate data population.

**4. Deleting Irrelevant Data:**
* Removed rows where both total laid off and percentage laid off were blank, ensuring only reliable data remained for analysis.


### Results:
* Cleaned and standardized a layoff dataset, making it ready for the next phase of exploratory data analysis.
* Filled missing industry values and removed irrelevant rows with blank total laid off and percentage laid off values.
* Successfully handled inconsistent data using SQL techniques such as joins, updates, and deletes.

### Conclusion:
**This project demonstrates effective data cleaning techniques using SQL. The cleaned dataset is now prepared for exploratory data analysis to derive trends and insights.**

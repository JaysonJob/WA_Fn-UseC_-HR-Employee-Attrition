# WA_Fn-UseC_-HR-Employee-Attrition
# HR Employee Attrition Analysis

End-to-end analysis of employee attrition built with PostgreSQL and Power BI.
This project uses the **IBM HR Analytics Employee Attrition & Performance** dataset.

- **Source:** https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset

## What's Inside

- **SQL** - data cleaning, view creation, and business-question queries
- **Power BI** - interactive dashboards covering attrition rate, department and role risk, overtime, and tenure
- **Executive Report** - a narrative-style page summarizing attrition drivers for a non-technical audience
- **Key Insights & Recommendations** - findings paired with actionable recommendations

## Tech Stack

PostgreSQL · SQL · Power BI · DAX

## Setup / Installation

### 1. Prerequisites

- PostgreSQL (local instance or any Postgres-compatible server)
- Power BI Desktop (Windows only - free download from Microsoft, offline use supported)

### 2. Installation Steps

1. Create a new database in PostgreSQL and run `Data_cleaning.sql` first - this creates the `HR` schema, builds the `staging_attrition` table, and cleans the raw data (trimming whitespace, standardizing text casing, removing the underscore in `BusinessTravel`, and checking every column for blanks/nulls).
2. Import the source data into `staging_attrition`: in pgAdmin, right-click the table → **Import/Export Data** → browse to `WA_Fn-UseC_-HR-Employee-Attrition.csv` and load it in.
3. Run `Analysis_and_views_created.sql` next - this answers the core business questions and creates four views (`vw_fact_attrition`, `vw_department_summary`, `vw_jobrole_summary`, `vw_overtime_summary`) that the Power BI report reads from.
4. Open `Bi.pbix` in Power BI Desktop.
   - **Offline / view-only:** just open the file - Power BI caches the last-refreshed data inside the `.pbix`, so all dashboards and visuals display immediately with no database connection needed.(you can also check the screenshot folder it has all the screenshots from power BI if you are un able to install it)
   - **Online / live connection:** to pull live data instead of the cached snapshot, go to **Home → Transform Data → Data Source Settings**, point the PostgreSQL connection at your own database, then click **Refresh**.

## Quick Summary

|                              |                                       |
| ---------------------------- | ------------------------------------- |
| **Total employees**          | 1,470                                 |
| **Employees who left**       | 237                                   |
| **Overall attrition rate**   | 16.1%                                 |
| **Highest-attrition department** | Sales (20.6%)                     |
| **Highest-attrition role**   | Sales Representative (39.8%)          |
| **Overtime attrition gap**   | 30.5% (overtime) vs. 10.4% (no overtime) |
| **Avg income, leavers vs. stayers** | $4,787 vs. $6,833 monthly      |

## Workflow

The project follows a clean → model → analyze → visualize pipeline.

1. **Data Cleaning (SQL)** - Loaded all 35 columns as text into a staging table, then trimmed whitespace, standardized casing, removed the underscore in every column and checked every column individually for blank or null values before treating it as clean.
2. **Business-Question Queries (SQL)** - Answered specific questions directly in SQL: overall attrition rate, department and role-level risk, above-average departments, pay as an attrition factor, tenure vs. attrition, income ranking within roles, below-average earners, and overtime as an attrition driver.
3. **Analytical Views (SQL)** - Built a fact view (`vw_fact_attrition`) plus three supporting summary views (`vw_department_summary`, `vw_jobrole_summary`, `vw_overtime_summary`) so Power BI reads from clean, purpose-built views instead of the raw staging table.
5. **Dashboarding (Power BI + DAX)** - Built two dashboard pages covering attrition KPIs, department/role/overtime breakdowns, job-level funnel, and tenure trends.
6. **Executive Report** - Wrote a plain-language summary of attrition drivers for a non-technical audience.
7. **Key Insights & Recommendations** - Paired each key finding with a concrete recommendation for the business.

## Example Queries - Business Questions Answered in SQL

**Overall Attrition Rate** *How big is the attrition problem, in one number?* → Counts total employees against those with `Attrition = 'Yes'`. Overall attrition sits at 16.1% (237 of 1,470 employees).

**Attrition by Department** *Which departments are losing the most employees?* → Groups by `Department`, ranked by attrition rate. Sales has the highest attrition (20.6%), followed by Human Resources (19.0%) and Research & Development (13.8%).
![alt text](https://github.com/JaysonJob/WA_Fn-UseC_-HR-Employee-Attrition/blob/4224ee89c79bae0815add1845823a2ce892e8083/sql.png)

**Attrition by Job Role** *Which specific roles are the biggest attrition risk?* → Groups by `JobRole`, ranked by attrition rate. Sales Representatives lead at 39.8%, well above every other role.
![alt text](https://github.com/JaysonJob/WA_Fn-UseC_-HR-Employee-Attrition/blob/edcef45fca1574146cf2d7a1870400a93978a8f4/roles.png)


## Dashboards

### Dashboard 1 - Attrition Overview

This page covers the headline KPIs: total employees, attrition count, overall attrition rate, gender split, and average hourly rate. Attrition by department shows Sales and Human Resources running above the 16.1% company average, while a clustered column of overtime vs. attrition rate makes the overtime effect immediately visible - 30.5% for overtime workers versus 10.4% for everyone else. A column chart of attrition by job role confirms Sales Representatives as the single highest-risk role.
![alt text](https://github.com/JaysonJob/WA_Fn-UseC_-HR-Employee-Attrition/blob/78dd52ca0c53a7df83d58c1c932266317ffc8d8c/screenshots/analysis%20dashboard.png)

### Dashboard 2 - Employee Trends

This page looks at tenure and career-stage patterns. A funnel of total employees by job level shows the workforce is heavily weighted toward Job Level 1 and 2, which is also where attrition is concentrated (26.3% at Level 1 vs. 4-7% at senior levels). An area chart of years at company against headcount shows attrition risk is highest in the earliest years of tenure, and a combo chart breaks down total employees and attrition rate by department side by side.
![alt text](


### Executive Report

This report examines employee attrition at the organization, focusing on key metrics such as overall attrition rate, departmental and role-level trends, overtime impact, compensation, and tenure. Overall attrition stands at 16.1%, with 237 of 1,470 employees having left. Overtime is the strongest driver of attrition: employees working overtime leave at 30.5%, nearly three times the rate of those who don't (10.4%). Employees who left were also younger on average (33.6 vs. 37.6 years) and earned less ($4,787 vs. $6,833 monthly). Sales had the highest departmental attrition (20.6%), led by Sales Representatives at 39.8%, the highest of any role, followed by Laboratory Technicians at 23.9%. Entry-level staff (Job Level 1) left at 26.3%, over five times the rate of senior levels (4-7%), pointing to early-tenure retention risk. A key opportunity lies in auditing overtime load in Sales and R&D, strengthening onboarding for Job Level 1 hires, and reviewing compensation for Sales Representatives and Lab Technicians.

### Key Insights & Recommendations

**Key Insights:**

1. Overtime is by far the biggest attrition driver - employees working overtime leave at 30.5%, almost three times the rate of those who don't (10.4%).
2. Sales Representatives leave more than any other role (39.8%), and Sales overall has the highest departmental attrition (20.6%).
3. Entry-level employees (Job Level 1) leave at 26.3%, over five times the rate of senior staff (4-7%).
4. Leavers earn less ($4,787/month) and are younger (33.6 years) than employees who stay ($6,833/month, 37.6 years).
5. Frequent travelers churn at 24.9% versus 8.0% for non-travelers, and employees with the lowest work-life-balance score leave at 31.3%, the highest of any tier.

**Recommendations:**

1. **Get overtime under control** - overtime is tied to the highest attrition rate in the data; before adding more hours to a team, check whether it's actually necessary or just how things have always been done.
2. **Fix Sales Rep pay and career path** - check if pay is behind market and whether there's a real next step, like a path to Sales Executive, so people don't leave for one elsewhere.
3. **Build a real onboarding program for new hires** - a structured first 90 days with check-ins at 3 and 6 months would catch Job Level 1 employees before they quietly decide to leave.
4. **Review pay for early-career staff specifically** - a company-wide average salary can look fine while this exact group is underpaid, so review compensation bands for this segment on their own.
5. **Rethink how travel and workload get assigned** - spread frequent travel across the team instead of loading it on the same people, and treat work-life balance as something managers check on regularly.

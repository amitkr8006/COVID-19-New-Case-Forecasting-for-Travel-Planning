# COVID-19 New Case Forecasting for Travel Planning (ETS, Indian Subcontinent)

## Overview
This project forecasts daily new confirmed COVID-19 cases to support travel planning decisions for the Indian subcontinent. It uses WHO daily case data and an ETS (Error–Trend–Seasonality) time-series model to generate short-term forecasts for the next 14 days, including an expected min–max range and forecast visualisations.

## Objective
- Forecast daily new COVID-19 cases for selected countries in the Indian subcontinent.
- Provide a simple application-style output that helps users understand near-term case trends before travel.
- Evaluate forecast reliability using a standard error metric (MAPE) across multiple historical windows.

## Data
- Source: WHO daily country-level COVID-19 reporting
- Scope: 7 countries in the Indian subcontinent (India, Pakistan, Bangladesh, Nepal, Bhutan, Maldives, Sri Lanka)
- Key fields used: Date_reported and New_cases (daily new confirmed cases)

## Tools & Methods
- R time-series workflow
- Converted daily records into a time-indexed series using xts()
- Forecasting model: ETS (exponential smoothing)
  - Captures error, trend, and seasonality components when present
  - Emphasises recent observations through smoothing parameters
  - Produces prediction intervals to express uncertainty

## Forecast Output
- User selects a country from the list of supported subcontinent countries
- Model generates:
  - Expected minimum and maximum daily cases for the next two weeks
  - A 14-day forecast plot for quick interpretation

## Model Evaluation (MAPE)
Forecast accuracy was tested by selecting four historical periods and comparing predicted vs actual cases using Mean Absolute Percentage Error (MAPE):
- 06/02/2021–19/02/2021: 11.75
- 17/05/2021–30/05/2021: 27.96
- 03/12/2021–16/12/2021: 28.13
- 21/06/2022–04/07/2022: 13.17
Average MAPE: 20.25

## Key Observations
- Cumulative cases show an upward trend; daily new cases are used for forecasting.
- No clear seasonality was identified, but irregular cycles/fluctuations were observed.
- Smoothing parameter α was high (>0.8), indicating forecasts rely heavily on recent values.
- With average MAPE around 20%, results are useful as directional guidance but should be interpreted cautiously.

## Limitations & Improvement Ideas
- ETS can be sensitive to outliers and is best suited for short-term forecasts.
- Country-level signals can be skewed by large-city trends.
- Using only time-series case counts ignores key drivers (e.g., density, vaccination, healthcare capacity).
- Future work can add more factors, test advanced models, forecast smaller geographic clusters, and build a dashboard for clearer decision support.

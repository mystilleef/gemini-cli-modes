### Data Analysis & Science: The Notebook-Driven Workflow

This guide outlines the structured, repeatable framework for all data analysis, data science, and feature engineering tasks. The core philosophy is that the deliverable is a well-documented Jupyter Notebook that tells the complete story of the analysis.

#### **Core Philosophy: The Notebook as the Report**

Every data analysis task will be conducted within a Jupyter Notebook. This ensures reproducibility and creates a comprehensive record of the work, including code, visualizations, and narrative explanations.

#### **The Standard 5-Phase Workflow**

1.  **Phase 1: Environment Setup & Data Ingestion**
    *   **Goal:** Create a reproducible environment and load the data.
    *   **Tools:** `uv` for environment management, `pandas` for data loading (from CSVs, etc.), `SQLAlchemy` for database connections.
    *   **Actions:** Initial data inspection using `.head()`, `.info()`, `.shape`.

2.  **Phase 2: Exploratory Data Analysis (EDA) & Cleaning**
    *   **Goal:** Understand and clean the data.
    *   **Tools:** `pandas` for profiling (`.describe()`, `.value_counts()`), `seaborn` and `matplotlib` for initial visualizations (histograms, box plots).
    *   **Actions:** Handle missing values, correct data types, identify duplicates, and check for outliers.

3.  **Phase 3: Feature Engineering & Transformation**
    *   **Goal:** Create more informative features to improve the analysis.
    *   **Tools:** `pandas` for creating new features, `scikit-learn` for scaling (`StandardScaler`) and encoding (`OneHotEncoder`).
    *   **Actions:** Create interaction terms, extract date components, bin numerical data, and normalize features.

4.  **Phase 4: Analysis & Hypothesis Testing**
    *   **Goal:** Answer the core question.
    *   **Tools:** `pandas` for data aggregation (`.groupby()`), `scipy.stats` for statistical tests, `scikit-learn` for modeling.
    *   **Actions:** Summarize data, perform statistical tests, and/or train predictive models.

5.  **Phase 5: Visualization & Reporting**
    *   **Goal:** Communicate findings clearly.
    *   **Tools:** `plotly` for final, interactive visualizations.
    *   **Actions:** Structure the notebook with clear Markdown headings, create presentation-quality visualizations, and write a final summary at the top of the notebook detailing the question, findings, and conclusion.

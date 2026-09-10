# Global Cybersecurity Threats
### A Hypothesis-Driven Risk Analysis | 2015–2024

---

## Overview

An end-to-end data analytics project investigating global cybersecurity incidents through a hypothesis-driven approach rather than a purely descriptive one.

The analysis moves from data cleaning and exploratory analysis in Excel, through structured hypothesis evaluation in SQL, to an interactive Power BI dashboard — with a consistent focus on identifying meaningful risk patterns rather than relying on averages alone.

Five specific hypotheses about risk, severity, and response time were evaluated using descriptive and comparative analysis across all three tools. Two were rejected in their strong form, and one revealed a mathematical artifact in a metric designed for this project — outcomes that reinforce the project's evidence-based, self-correcting approach rather than a search for confirming patterns.

> ⚠ **Data Limitation:** This project uses a synthetic dataset intended for analytical methodology demonstration. Findings should not be interpreted as real-world estimates of global cybersecurity risk. See [Limitations](#important-limitations).

---

## Business Questions

- Is the cybersecurity threat increasing over time?
- Which attack types contribute most to financial loss?
- Where is financial risk actually concentrated?
- Are some industry–attack combinations more exposed than others?
- Does incident severity affect resolution time?
- Can a derived metric be trusted before it is used as a KPI?

---

## Key Findings

- **No consistent increase in incident volume:** annual incidents remained broadly stable from 2015–2024 (263–319 incidents/year, no directional trend).
- **Tail risk matters more than averages:** average loss is nearly uniform across countries and attack types, but the highest-loss incidents show clear concentration in specific combinations.
- **USA × DDoS** appeared **12 times** within the top 10% highest-loss incidents — more than any other combination.
- **USA × Ransomware** appeared **10 times** within the same tail-risk group.
- **Japan × Banking × Phishing** recorded **11 incidents** with an average loss of approximately **$71.79M** — both frequent and high-impact, unlike most other top combinations driven by only 4–7 incidents.
- **SQL Injection** ranked #1 in annual total financial loss in **5 of 10 years**, driven primarily by incident volume rather than higher average loss per incident.
- **Resolution time remained broadly uniform (~35–37 hours)** across severity levels, attack types, and defense mechanisms.
- A seemingly strong **Resolution Efficiency** difference (up to 6.5x) was identified as a **mathematical artifact** caused by a near-zero Severity Score denominator, not a real operational difference — the metric was therefore retained only as a secondary indicator, never a primary KPI.

---

## Methodology

**Excel + Power Query**
- Data cleaning and validation
- Exploratory analysis (Pivot Tables)
- Design and validation of derived metrics (Severity Score, Cost per User, Resolution Efficiency)

**SQL Server**
- Aggregations, CTEs, and window functions (RANK, NTILE)
- Multi-dimensional combination analysis
- Tail-risk (top-decile) analysis

**Power BI + DAX**
- Interactive, question-driven dashboard (not a generic chart collection)
- KPI design with deliberately defensive language (e.g., "Loss Ratio" instead of "Effectiveness")
- Severity and response-time analysis

---

## Analytical Approach

The project follows one consistent reasoning chain for every analysis performed:

```
Question → Data → Metric → Analysis → Finding → Business Meaning → Decision
```

A core principle throughout the project was to avoid overstating what the data supports:

- Average-level comparisons were challenged with tail-risk analysis before concluding "no difference exists."
- Derived metrics were tested against a direct metric before being trusted (see the Resolution Efficiency finding).
- Causal language was avoided wherever the dataset could only support a descriptive or structural relationship (e.g., Severity Score and Financial Loss).
- Every hypothesis result is reported with an explicit **Evidence Strength** (Strong / Moderate / Weak, descriptively) rather than implying formal statistical significance that was not tested.

### Hypotheses Evaluated

| Hypothesis | Result |
|---|---|
| H1 — Incident volume is increasing over time | ❌ Not supported |
| H2 — Some attack types have higher average financial loss | ❌ Not supported |
| H3 — Tail risk is concentrated in specific combinations | ✅ Supported |
| H4 — Higher severity is associated with slower response | ❌ Not supported |
| H5 — Resolution Efficiency reflects operational performance | ⚠️ Rejected as a primary KPI due to a metric artifact |

---

## Dashboard

### 0. Executive Overview
**Question:** What are the most important findings from the analysis?
Provides a high-level view of the project's key findings and directs the reader to the three analytical perspectives below.

### 1. Threat Landscape
**Question:** Is the threat increasing over time?
Analyzes incident volume, annual financial loss, and shifts in attack-type composition.

### 2. Risk Concentration
**Question:** Where is the real risk concentrated?
Focuses on country–attack combinations, tail-risk concentration, and multi-dimensional exposure — the core of the project's central insight: *average risk and tail risk are not the same signal.*

### 3. Severity & Response
**Question:** Does severity affect response speed?
Compares constructed severity, financial loss, and incident resolution time, and documents why the Resolution Efficiency metric was demoted to a supporting role.

---

## Business Recommendations

Given the synthetic nature of the dataset, all recommendations are framed as candidates for further investigation and monitoring — not directives for immediate spending or resource reallocation.

- Maintain a balanced, layered security posture across attack types and defense mechanisms; no single category shows evidence strong enough to justify concentrated investment.
- Flag USA-associated DDoS and Ransomware incidents for targeted monitoring, given their disproportionate presence in the highest-loss decile.
- Investigate phishing-specific controls for banking-sector operations in Japan as a distinct, elevated-priority candidate.
- Treat SQL Injection as a recurring, year-level monitoring priority — driven by incident volume in specific years, not by higher severity per incident.
- Use the Severity Score only as an internal triage/sorting aid, not as a validated, independent predictor of financial impact.
- Evaluate true defense-mechanism effectiveness using operational or vendor prevention data; this dataset measures only post-incident average loss, not prevention capability.

---

## Important Limitations

- The dataset is **synthetic** and should not be interpreted as real-world estimates of global cybersecurity risk.
- The Severity Score is an internally constructed analytical index, not an industry-standard security framework (e.g., not CVSS).
- Financial Loss is one of two inputs to the Severity Score, creating a **structural relationship** between the two — not independent evidence that severity predicts loss.
- Findings throughout this project are descriptive and comparative; **formal statistical significance testing (e.g., ANOVA, Chi-Square) was not performed**, so "Evidence Strength" reflects the consistency and actionability of an observed pattern, not a p-value or confidence interval.
- Defense-mechanism comparisons represent post-incident average financial loss, not true prevention or detection effectiveness.
- Data is annual (Year only); finer-grained time-series analysis (monthly/weekly) was not possible.

---

## Tech Stack

`Excel` · `Power Query` · `SQL Server (T-SQL, CTEs, Window Functions)` · `Power BI` · `DAX`

---

## Project Structure

```text
Global-Cybersecurity-Threats/
│
├── Dataset/
│   └── global_cybersecurity_threats.csv
│
├── Excel/
│   └── Cybersecurity_Analysis.xlsx
│
├── SQL/
│   └── cybersecurity_analysis.sql
│
├── PowerBI/
│   └── Cybersecurity_Dashboard.pbix
│
├── Report/
│   └── Cybersecurity_Project_Report.docx
│
├── Screenshots/
│   ├── executive_overview.png
│   ├── threat_landscape.png
│   ├── risk_concentration.png
│   └── severity_response.png
│
└── README.md
```

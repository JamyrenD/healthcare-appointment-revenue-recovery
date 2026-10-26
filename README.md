# Healthcare Appointment Revenue Recovery

### How many appointments can a healthcare practice afford to lose?

A missed appointment isn't just an empty spot on the calendar. It's time that could have been spent treating another patient and generating revenue.

I analyzed **9,074 healthcare appointments** to understand where no-shows were happening, what those missed visits could mean financially, and how a practice might reduce them without immediately investing in an expensive solution.

The goal wasn't just to identify a problem. It was to figure out **what a business could realistically do about it.**

---

## The Opportunity

| Metric | Finding |
|---|---|
| Total appointments analyzed | 9,074 |
| Missed appointments | 941 |
| Overall no-show rate | 10.37% |
| Illustrative revenue per visit | $100 |
| Potential gross appointment value exposed | $94,100 |

That $94,100 represents the hypothetical gross value of missed appointments across the historical dataset. It is **not verified lost revenue** or money the practice could necessarily recover.

Still, the findings raised an important question:

**What if the practice could recover even a small portion of those missed visits?**

---

## Where the Problem Shows Up

Missed appointments weren't evenly distributed throughout the schedule.

| Appointment Time | No-Show Rate |
|---|---:|
| 9 AM | 6.31% |
| 2 PM | 12.54% |
| 4 PM | 12.31% |
| 5 PM | 18.11% |

The 5 PM appointment window had the highest no-show rate among the substantive hourly groups examined, while 2 PM had the largest number of missed visits.

Monday and Friday also showed higher missed-appointment volumes.

This doesn't mean those times should automatically be removed from the schedule. It means they deserve a closer look.

Instead of treating every appointment the same, a practice could test additional confirmation and follow-up efforts around the times where attendance has historically been weaker.

---

## What Could Improving Attendance Be Worth?

I built an interactive financial calculator to explore how changes in attendance could affect a practice's revenue and profit.

Here's one illustrative 30-day scenario:

| Monthly Scenario | Estimate |
|---|---:|
| Scheduled appointments | 750 |
| Starting no-show rate | 10.37% |
| Target no-show rate | 8.00% |
| Assumed recovery conversion | 80% |
| Additional completed visits | ~14.2 |
| Additional revenue | ~$1,422 |
| Contribution after visit costs | ~$569 |
| Follow-up program cost | $250 |
| **Estimated incremental profit** | **~$319** |

These are modeled estimates, not observed results. Actual outcomes depend on patient attendance, collections, operating costs, and whether recovered appointments become completed, paid visits.

**The takeaway:** A practice doesn't necessarily need a dramatic improvement to create a financial opportunity. But the cost of achieving that improvement matters.

---

## The Recommendation: Start Small, Then Measure

Rather than immediately spending more on a larger follow-up system, I'd recommend testing a lower-cost approach for 30 days.

Here's the starting plan:

1. Identify appointment windows with historically higher no-show rates.
2. Test additional reminders and confirmation follow-ups for those appointments.
3. Monitor the no-show rate and actual completed visits.
4. Calculate the additional money retained after delivery and program costs.
5. Compare the results against the existing process before deciding whether to expand.

The **primary KPI is the no-show rate**, but the final business decision should also consider completed visits and incremental profit.

A lower no-show rate is encouraging. It doesn't automatically prove the program caused the improvement. A fair comparison group, where practical, would provide stronger evidence.

---

## Explore the Work

### Client-Facing Case Study

A short, visual report covering the appointment problem, key findings, and proposed financial opportunity.

**[View the Healthcare Revenue Recovery Report](DSA_Healthcare_Revenue_Recovery_Case_Study_DSA_Matched.pdf)**

### Interactive Financial Calculator

An Excel model that lets a practice explore its own appointment volume, no-show rates, revenue per visit, program costs, and potential returns.

**[Open the Appointment Revenue Calculator](DSA_Appointment_Revenue_Calculator_Client_Ready.xlsx)**

### SQL Analysis

Want to see how I found the patterns behind the missed appointments?

This file contains the PostgreSQL queries used to examine no-show rates, appointment times, weekday patterns, data quality, and potential revenue exposure.

**[View the SQL Analysis](dsa_healthcare_revenue_analysis_clean.sql)**
---

## How the Analysis Was Done

I used PostgreSQL to examine appointment attendance patterns by day and hour, then built an Excel financial model to evaluate potential recovery scenarios.

The historical appointment findings and financial scenarios serve different purposes:

- **Historical analysis:** What happened in the appointment dataset?
- **Financial model:** What might happen if a practice improves attendance under specified assumptions?
- **Proposed pilot:** How could the practice test whether the intervention actually works?

The dataset is used for analytical demonstration. This is an independent case study, not a documented client engagement or a claim that the proposed intervention has already delivered these results.

---

## Tools Used

- **PostgreSQL / SQL** — Appointment analysis
- **Microsoft Excel** — Financial modeling and scenario comparison
- **PDF Report** — Business findings and recommendations

---

### Drake Strategy & Analytics

*Finding opportunities in the numbers and turning them into practical business decisions.*


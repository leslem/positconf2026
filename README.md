# 2026 posit::conf talk

# Configurable clinical data harmonization with help from LLMs

## Talk pitch

Hello, my name is Leslie Emery and I’ve spent the last 10 years of my career harmonizing data from inconsistent sources. Different subject ID formats, measurement units, date formats, inconsistent categorical values, synonyms for the same laboratory test – if there’s a way for a clinical data set to be messy, I’ve seen it and I want to prevent my colleagues from having to work through the same problems.

My talk is about developing a way to automate the repetitive task of data harmonization with help from LLMs, and how to put this automation process into a reproducible pipeline that allows space for human review. While my talk is focused on data from clinical trials, the approaches I describe will be useful to anyone harmonizing data from disparate sources or wrangling data frames generally. I’ll share my workflow for capturing LLM output into version-controlled files and how to design and define abstracted data transformations into configurable steps. I’d love to share this talk so that the audience won’t have to spend their time renaming columns for the rest of their careers.

## Abstract

Clinical trial data formats differ across studies and over time, even within an organization. After years of writing bespoke R code to harmonize data for cross-study analysis, my team is developing LLM-assisted automation. First, we use an LLM to develop a data model for the output, describing a format and content that accommodates all input studies. Then an LLM evaluates each study’s data files and documentation to determine how to wrangle each input file to fit the data model. The LLM generates yaml configuration files for programmatically transforming each study into an interoperable format for combined analysis. Our LLM prompts, data model, configuration files, and pipeline code are all version controlled and reproducible.

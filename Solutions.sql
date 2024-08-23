# 1. Who prefers energy drink more? (male/female/non-binary?)
# Solution-
WITH CTE1 AS (
    SELECT 
        f.Respondent_ID,
        ds.gender
    FROM fact_survey_responses f
    LEFT JOIN dim_repondents ds 
    ON f.Respondent_ID = ds.Respondent_ID
),
CTE2 AS (
    SELECT 
        Respondent_ID,
        gender
    FROM CTE1
    WHERE gender = 'female'
)
SELECT 
    (SELECT 
		COUNT(*) 
        FROM CTE2 
        WHERE gender = 'female') AS Female_Count,
    (SELECT 
		COUNT(*) 
        FROM CTE1 
        WHERE gender = 'male') AS Male_Count;
        
# 2. Which age group prefers energy drinks more?
# Solution-
with CTE1 as (SELECT 
	f.Respondent_ID,
	ds.gender,
	ds.Age
FROM fact_survey_responses f
LEFT JOIN dim_repondents ds 
ON f.Respondent_ID = ds.Respondent_ID)

select 
	Age,
	count(*) as cnt
    from CTE1
    group by Age
    order by cnt desc;
    
# 3. What are the preferred ingredients of energy drinks among respondents?
# Solution-
SELECT 
	f.Ingredients_expected,
    count(f.Respondent_ID) as No_of_res
    FROM fact_survey_responses f
    LEFT JOIN dim_repondents ds 
    ON f.Respondent_ID = ds.Respondent_ID
    group by f.Ingredients_expected
    order by No_of_res desc;
    
# 4. What packaging preferences do respondents have for energy drinks?
# Solution-
SELECT 
    f.Packaging_preference,
    count(f.Respondent_ID) as No_of_respo
FROM fact_survey_responses f
LEFT JOIN dim_repondents ds 
ON f.Respondent_ID = ds.Respondent_ID
group by f.Packaging_preference
order by No_of_respo desc;

# 5. Who are the current market leaders?
# Solution-
SELECT 
	f.Current_brands,
    count(f.Respondent_ID) as no_of_respo
FROM fact_survey_responses f
LEFT JOIN dim_repondents ds 
ON f.Respondent_ID = ds.Respondent_ID
group by f.Current_brands
order by no_of_respo desc;

# 6. Which marketing channel can be used to reach more customers?
# Solution-
SELECT 
	f.Marketing_channels,
    COUNT(f.Respondent_ID) AS no_of_respo
FROM
	fact_survey_responses f
LEFT JOIN
	dim_repondents ds 
    ON f.Respondent_ID = ds.Respondent_ID
GROUP BY
	f.Marketing_channels
ORDER BY
	no_of_respo DESC;
    
# 7. How effective are different marketing strategies and channels in reaching our customers?
# Solution-
Select
    f.Marketing_channels,
    count(f.Current_brands) as cur_CodeX
FROM
	fact_survey_responses f
LEFT JOIN
	dim_repondents ds 
    ON f.Respondent_ID = ds.Respondent_ID
where f.Current_brands ='CodeX'
group by f.Marketing_channels;

# 8. What do people think about our brand? (overall rating)
# Solution-
select
	Brand_perception,
    count(Brand_perception) as exp
from fact_survey_responses
where Current_brands='CodeX'
group by Brand_perception
order by exp desc;

# 9. Which cities do we need to focus more on?
# Solution-
Select 
	c.city,
    count(f.Respondent_ID) as Num
from fact_survey_responses f
left join dim_repondents re
on  f.Respondent_ID = re.Respondent_ID
left join dim_cities c
on re.City_ID = c.City_ID
where Current_brands != 'CodeX'
group by C.City
order by Num desc;

# 10. Where do respondents prefer to purchase energy drinks?
# Solution-
Select
	Reasons_for_choosing_brands,
    count(Reasons_for_choosing_brands) as count
from fact_survey_responses
group by Reasons_for_choosing_brands
order by count desc;

# 11. What are the typical consumption situations for energy drinks among respondents?
# Solution-
select
	Typical_consumption_situations,
    Count(Typical_consumption_situations) as count
from fact_survey_responses
group by Typical_consumption_situations
order by count desc;

# 12. What factors influence respondents purchase decisions, such as price range and limited edition packaging?
# Solution-
select 
	price_range,
    count(price_range) as cnt
from fact_survey_responses
group by Price_range
order by cnt desc;

select
	Limited_edition_packaging,
    count(Limited_edition_packaging) as cnt2
from fact_survey_responses
group by Limited_edition_packaging
order by cnt2 desc;

# 13. Which type of marketing reaches the most youth (15-30) ?
# Solution-
with cte1 as (
select * from dim_repondents where age in ('15-18', '19-30')
)
select f.Marketing_channels, count(*) as cnt
from fact_survey_responses f
left join cte1 c
on f.Respondent_ID=c.Respondent_ID
group by f.Marketing_channels
order by cnt desc;

# Some suggetion I would like to give to the business according the Data I generated-
# 1. Try to add caffeine and Vitamins in the Drink and make Compact and Portable with Innovative design for the Cans
# 2. Try to Fix the price Between (50-150). Two types of cans would be ideal for starting, Small can (240 ml) and Bigger can (330 ml)
# 3. Target audience should be aged between (15-30)
# 4. Try to advertise more in Bangalore, Hyderabad, Mumbai

The goal of this task was to create Cloud SQL instance.

Response to the SQL query (what is average age of the students in the class?):
select round(avg(age), 1) as average_age
from dareit.students

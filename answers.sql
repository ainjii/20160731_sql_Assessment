1

-----

Select all fields for all brands in the brands table.

The result set for this query should be every record in the brands table.

-----


select * from brands;


==========
2

-----

Select all fields for all car models made by Pontiac in the 
models table. 

The result set should be:
  id   | year  | brand_name |    name
-------+-------+------------+------------
    25 |  1961 | Pontiac    | Tempest
    27 |  1962 | Pontiac    | Grand Prix
    36 |  1963 | Pontiac    | Grand Prix
    42 |  1964 | Pontiac    | GTO
    43 |  1964 | Pontiac    | LeMans
    44 |  1964 | Pontiac    | Bonneville
    45 |  1964 | Pontiac    | Grand Prix
(7 rows)


-----


select * from models where brand_name = 'Pontiac';


==========
3

-----

Select the brand name and model name for all models made in 
1964 from the models table. 

The result set should be:
 brand_name |    name
------------+-------------
 Chevrolet  | Corvette
 Ford       | Mustang
 Ford       | Galaxie
 Pontiac    | GTO
 Pontiac    | LeMans
 Pontiac    | Bonneville
 Pontiac    | Grand Prix
 Plymouth   | Fury
 Studebaker | Avanti
 Austin     | Mini Cooper
 (10 rows)
 

-----


select brand_name, name from models where year = 1964;


==========
4

-----

Select the model name, brand name, and headquarters for 
the Ford Mustang from the models and brands tables.

The result set should be:
  name   | brand_name | headquarters
---------+------------+--------------
 Mustang | Ford       | Dearborn, MI
 (1 rows)


-----


select models.name as name, brands.name as brand_name, brands.headquarters
from models
join brands
on brands.name = models.brand_name
where models.name = 'Mustang';


==========
5

-----

Select all rows for the three oldest brands from the brands
table.

The result set should be:
  id   |    name    | founded |    headquarters     | discontinued
-------+------------+---------+---------------------+--------------
    10 | Studebaker |    1852 | South Bend, Indiana |         1967
    13 | Rambler    |    1901 | Kenosha, Washington |         1969
     6 | Cadillac   |    1902 | New York City, NY   |
(3 rows)


-----


select *
from brands
order by founded
limit 3;


==========
6

-----

Count the Ford models in the database The output should be a 
number.

The result set should be:
   count
------------
          6
(1 rows)


-----


select count(*) from models
where brand_name = 'Ford';


==========
7

-----

Select the name of any and all car brands that are not 
discontinued.

The result set should be:
   name
-----------
 Ford
 Chrysler
 Chevrolet
 Cadillac
 BMW
 Buick
 Tesla
(7 rows)


-----


select name from brands where discontinued is null;


==========
10

-----

Modify the query so that it shows all brands that are 
not discontinued regardless of whether they have any models in the models table.
The correct output should not include records for Fillmore and Outback, but should
show information about Tesla, a brand with no models in the models table.

-----


select b.name, b.founded, m.name from brands as b
left join models as m
on b.name = m.brand_name
where b.discontinued is null;


==========
11

-----

Modify the query so it only selects models whose brands ARE in the brands table.
So, we shouldn't see models who brands aren't in the brands table (a.k.a. Fillmore,
Outback) nor should we see information about brands who don't have any models in 
the models table (a.k.a. Tesla).

-----


select m.name, m.brand_name, b.founded from models as m
inner join brands as b
on b.name = m.brand_name;


==========
12

-----

Modify the query so that it only selects brands that do NOT have any
models in the models table.

The correct result set is:

 name  | founded
-------+---------
 Tesla |    2003
(1 rows)

-----


select b.name, b.founded from brands as b
left join models as m
on b.name = m.brand_name
where m.brand_name is null;


==========
14

-----

Select the name of any brand with more than 5 models in the 
database using a HAVING clause.

The correct result set is:

 brand_name
------------
 Chevrolet
 Pontiac
 Ford
(3 rows)


-----


select brands.name from brands
join models on brands.name = models.brand_name
group by brands.name
having count(models.brand_name) > 5;


==========
15

-----

Using a subquery, select the name and year of any model whose 
year is the same year that ANY brand was founded.

The result set should be:

   name    | year
-----------+-------
 Imperial  |  1926
 Corvette  |  1954
 Fleetwood |  1954
(3 rows)

-----


select name, year from models
where year IN (
select founded from brands);
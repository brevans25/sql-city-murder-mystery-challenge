--create a cte to hold the crime scene report info:

--with csr as (
  --select * 
  --from crime_scene_report 
  --where date = 20180115 and type = 'murder' and city = 'SQL City'
--)

--select * from csr

--Find out more about witness #1: "lives at the last house on 'Northwestern Dr'"  

--select *
--from person
--where lower(address_street_name) = 'northwestern dr'
--order by address_number desc 

--Find out more about witness #2: "named Annabel, lives somewhere on 'Franklin Ave'".

--select *
--from person 
--where lower(name) like '%annabel%' 
--and lower(address_street_name) = 'franklin ave'

-- Add a CTE to hold the info for the two witnesses

--with witnesses as (
 -- select *
 -- from person
 -- where
  --  lower(address_street_name) = 'northwestern dr'
 --   or (lower(name) like '%annabel%' 
--		and lower(address_street_name) = 'franklin ave'
	--)
--)

--select *
--from witnesses

--order by address_street_name,
--address_number desc

--limit 2;

-- select * from person where name = 'Annabel Miller'


--select *
--from get_fit_now_member g
--left join witnesses w
--on w.id=g.id


--Observed that the interview table has a person_id column 
--that can be joined with the witness CTE using the IDs of the two witnesses:

--select w.id,
--w.name,
--i.transcript 
--from witnesses w
--left join interview i
--on i.person_id=w.id
--where w.id in ('16371',
			   --'14887')
			   
--select * 
--from get_fit_now_member

--select * 
--from get_fit_now_check_in

-- person table with get_fit_now_member table on person_id;

-- get_fit_now_member table with get_fit_now_check_in table to validate check in time;

-- Using the info from Morty's statement we get that:
-- GENDER: male
-- MEMBERSHIP STATUS: gold
-- MEMBERSHIP ID: 48Z......
-- PLATE NUMBER: H42W

-- We can join the person table with drivers_license table on person_id 
-- to get the suspect's plate number, gender and name;

-- Store the results of this in a CTE potential_suspects.

-- Left joined the get_fit_now_member table on person_id and 
-- was able to exclude two of the suspects..

-- PS:. Membership _ID matches the one given by Morty 
-- in his statement also Membership_Status.

--Good job in spilling the tea, Morty!
-- #scorpioVibes #theNancyDrewofSQL #mortyBringsTheReceipts

with potential_suspects as (
  select p.id as person_id,
  p.name,
  d.age,
  d.gender,
  d.plate_number,
  p.license_id,
  p.address_number
  from person p
  left join drivers_license d 
  on p.license_id=d.id
  where d.plate_number like '%H42W%'
)

select s.person_id,
s.name,
s.gender,
s.plate_number,
m.id as GFN_member_id,
m.membership_status
from potential_suspects s
left join get_fit_now_member m on s.person_id=m.person_id

order by m.id desc

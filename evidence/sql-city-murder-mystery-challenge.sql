
              
              
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
-- left join interview i on s.person_id=i.person_id
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


 -- Left joined the get_fit_now_check_in table to validate Annabel's statement
 -- and yes, it is a match!
 -- At this moment, Jeremy Bowers is your primary suspect!

--with potential_suspects as (
  --select p.id as person_id,
  --p.name,
  --d.age,
 -- d.gender,
  --d.plate_number,
  --p.license_id,
  --p.address_number
  --from person p
  --left join drivers_license d 
  --on p.license_id=d.id
  --where d.plate_number like '%H42W%'
--)

--select s.person_id,
--s.name,
--s.gender,
--s.plate_number,
--m.id as GFN_member_id,
--m.membership_status,
--c.check_in_date,
--c.check_in_time,
--c.check_out_time
--from potential_suspects s
--left join get_fit_now_member m on s.person_id=m.person_id
--left join get_fit_now_check_in c on m.id=c.membership_id

--order by m.id desc

-- Primary suspect identified, we invited him to the police station for some questioning.
-- Below is his statement:

--select p.id as person_id,
--p.name,
--d.plate_number,
--m.id as GFN_member_id,
--m.membership_status,
--c.check_in_date,
--c.check_in_time,
--c.check_out_time
--i.transcript
--from person p
--left join drivers_license d on p.id=d.id
--left join get_fit_now_member m on p.id=m.person_id
--left join get_fit_now_check_in c on m.id=c.membership_id
--left join interview i on p.id=i.person_id
--where p.id = 67318

-- Upon joining the facebook_event_checkin table, we were able to verify one suspect did
-- three SQL Symphony Conceerts in 2017, exactly how Jeremy Bowers stated in his statement:

--with potential_masterminds as (
  --select p.id as person_id,
  --p.name,
  --d.age,
 -- d.gender,
 -- d.height,
  --d.hair_color,
  --d.car_make,
  ----d.car_model,
  --f.event_name,
  --f.date
  --from person p
  --left join drivers_license d on p.license_id=d.id
  --left join facebook_event_checkin f on p.id=f.person_id
  --where d.gender = 'female'
 -- and d.car_make = 'Tesla'
  --and d.car_model = 'Model S'
  --and d.hair_color = 'red'
  --and d.height between 65 and 67
--)

--select * from potential_masterminds

--order by date desc

  select p.id as person_id,
  p.name,
  i.transcript
  from person p
  left join interview i on p.id=i.person_id
  where p.id = 99716

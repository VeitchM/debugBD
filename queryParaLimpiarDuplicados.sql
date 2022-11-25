-- Query to Select duplicates UUID with null in DNI
select distinct u.id
	from public.users u, public.users v
	where u.uid=v.uid and u.id<>v.id and u.dni isnull) ; 

-- Delete duplicates
delete from users u where u.id in (select distinct u.id
	from public.users u, public.users v
	where u.uid=v.uid and u.id<>v.id and u.dni isnull) ; 
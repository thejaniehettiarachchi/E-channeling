create or replace view AvailableDoctors
AS 
Select D.DID,D.Title, D.FName, D.LName, S.Name as 'Specialization'
From Doctor as D JOIN Speciality as S JOIN Doc_Spec as DS
ON D.DID = DS.DID AND DS.SID = S.SID
where D.DID IN (
	select DID 
    From Schedule 
    where Status = 2
)
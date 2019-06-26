create table Associate(
    associateId number ,
    firstName varchar2(50) not null,
    lastName varchar2(50) not null,    
    yearlyInvestmentUnder80C number,
    department varchar2(50) not null,
    designation varchar2(50)not null,
    pancard varchar2(50)not null,
    emailId varchar2(50) not null
)
--------------------------------------------------------------------------------------------------------------------------
drop table Associate
--------------------------------------------------------------------------------------------------------------------------
alter table Associate
  add constraint PK_AssociateID
    primary key(associateId)
--------------------------------------------------------------------------------------------------------------------------
alter table Associate
  add constraint UK_EmailId
    unique(emailId)
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE SALARY(
  BASICSALARY NUMBER,
  HRA NUMBER,
  CONVEYENCEALLOWANCE NUMBER,
  OTHERALLOWANCE NUMBER,
  PERSONALALLOWANCE NUMBER,
  MONTHLYTAX NUMBER,
  EPF NUMBER,
  COMPANYPF NUMBER,
  GROSSSALARY NUMBER,
  NETSALARY NUMBER
)
--------------------------------------------------------------------------------------------------------------------------
alter table Salary
  add associateId number
  select  * from Salary
--------------------------------------------------------------------------------------------------------------------------
alter table Salary
 add constraint FK_AssociateID 
 foreign key (associateId) REFERENCES Associate(associateId)
--------------------------------------------------------------------------------------------------------------------------

create table BankDetails(
  associateId number constraint FK_AssociateID REFERENCES Associate(associateId),,
  accountNumber number,
  bankName varchar2(50),
  ifcsCode varchar2(50)
)

drop table bankdetails
--------------------------------------------------------------------------------------------------------------------------
select * 
  from Associate
    where firstName like '%s_'  
--------------------------------------------------------------------------------------------------------------------------
select * 
  from Associate
    where yearlyinvestmentunder80c <90000 and yearlyinvestmentunder80c >20000
--------------------------------------------------------------------------------------------------------------------------
select * 
  from Associate
    where yearlyinvestmentunder80c  between 20000 and 90000
--------------------------------------------------------------------------------------------------------------------------
select * 
  from Associate
    where yearlyinvestmentunder80c  IN (10000,20000,75000)
  --------------------------------------------------------------------------------------------------------------------------
  select count(*) "Total No Of Associate"
    from   Associate
  --------------------------------------------------------------------------------------------------------------------------
  select count(*) "Total No Of Associate"
    from   Associate
  --------------------------------------------------------------------------------------------------------------------------
  select department, count(department) 
    from Associate
      group by department
      order by department
----------------------------------------------------------------------------------------------------------------------------
select abs(-15)
  from dual
----------------------------------------------------------------------------------------------------------------------------
select round(17.171,1)
  from dual
----------------------------------------------------------------------------------------------------------------------------
select a.associateId,a.firstName,a.lastName,s.basicSalary,s.netSalary,b.bankName
  from  Associate a , Salary s,BankDetails b
----------------------------------------------------------------------------------------------------------------------------
select a.associateId,a.firstName,a.lastName,s.basicSalary,s.netSalary,b.bankName
  from Associate a,  Salary s,BankDetails b
    where a.associateId(+)=s.associateId 
----------------------------------------------------------------------------------------------------------------------------
select * 
  from Associate ,Salary,BankDetails
    where Associate.yearlyinvestmentunder80c <50000
----------------------------------------------------------------------------------------------------------------------------
select * 
  from Associate ,Salary,BankDetails
    where Associate.associateId(+)=Salary.associateId
----------------------------------------------------------------------------------------------------------------------------    
select * 
  from Associate ,Salary,BankDetails
    where Associate.associateId=Salary.associateId
     and     Associate.associateId=Bankdetails.associateId 
----------------------------------------------------------------------------------------------------------------------------
select *
   from Associate where  
--------------------------------------------------------------------------------------------------------------------------

create or replace view Associate_Salary_Details
As
  select a.associateId,a.firstName,a.lastName,s.basicSalary,s.netSalary,b.bankName
  from Associate a,  Salary s,BankDetails b
    where a.associateId(+)=s.associateId 
--------------------------------------------------------------------------------------------------------------------------

SET SERVEROUTPUT ON

begin
   DBMS_OUTPUT.PUT_LINE('Welcome');
 END;  
----------------------------------------------------------------------------------------------------------------------
DECLARE
    vcName VARCHAR2(20) NOT NULL :='Satish';
    id NUMBER;
BEGIN
  vcName:='Satish';
  DBMS_OUTPUT.PUT_LINE(vcName||' '||id);
END;

------------------------------------------------------------------------------------------------------------------------

DECLARE 
    aId number;
    fName varchar(50);
    lName varchar(50);
begin
  select associateId,firstName,lastName INTO aId,fName,lName
        from Associate
          where associateId=&aId;
   DBMS_OUTPUT.PUT_LINE(aId||' '||fName||' '||lName);                
end;

------------------------------------------------------------------------------------------------------------------------

DECLARE 
    aId ASSOCIATE.ASSOCIATEID%TYPE;
    fName ASSOCIATE.FIRSTNAME%TYPE;
    lName ASSOCIATE.LASTNAME%tyPE;
begin
  select associateId,firstName,lastName INTO aId,fName,lName
        from Associate
          where associateId=&aId;
   DBMS_OUTPUT.PUT_LINE(aId||' '||fName||' '||lName);                
end;
------------------------------------------------------------------------------------------------------------------------      

DECLARE 
    associateRow ASSOCIATE%ROWTYPE;
begin
  select * INTO associateRow
        from Associate
          where associateId=&aId;
   DBMS_OUTPUT.PUT_LINE(associateRow.ASSOCIATEID);                
end;
------------------------------------------------------------------------------------------------------------------------

DECLARE 
    CURSOR associateCursor is select * from Associate;
    associateRow ASSOCIATE%ROWTYPE;
begin
      OPEN associateCursor;
      LOOP
      FETCH associateCursor INTO associateRow;
        DBMS_OUTPUT.PUT_LINE(associateRow.ASSOCIATEID||' '||associateRow.firstName||' '||associateRow.lastName);
        EXIT WHEN associateCursor%NOTFOUND;
       
      END LOOP;
  CLOSE associateCursor;  
end;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE 
    aId number;
    fName varchar(50);
    lName varchar(50);
begin
  select associateId,firstName,lastName INTO aId,fName,lName
        from Associate
          where associateId=&aId;
            DBMS_OUTPUT.PUT_LINE(aId||' '||fName||' '||lName);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
          DBMS_OUTPUT.PUT_LINE('No employees exits');
      WHEN TOO_MANY_ROWS THEN
          DBMS_OUTPUT.PUT_LINE('Too many raecords foundf');
end;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------

DECLARE 
    CURSOR associateCursor is select * 
                                                        from Associate 
                                                            where YEARLYINVESTMENTUNDER80C>=&YEARLYINVESTMENTUNDER80C;
    associateRow ASSOCIATE%ROWTYPE;
     NO_Records_Found EXCEPTION ;
     begin
      OPEN associateCursor;
      FETCH associateCursor INTO associateRow;
      IF associateCursor%ROWCOUNT>0
          THEN
          LOOP
              FETCH associateCursor INTO associateRow;
                  DBMS_OUTPUT.PUT_LINE(associateRow.ASSOCIATEID||' '||associateRow.firstName||' '||associateRow.lastName);
                  EXIT WHEN associateCursor%NOTFOUND;
          END LOOP;
        ELSE
            RAISE NO_Records_Found; 
       END IF;     
          CLOSE associateCursor;  
          
        EXCEPTION 
          WHEN NO_Records_Found THEN
                  DBMS_OUTPUT.PUT_LINE('NO details found');
end;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------f

create or replace PROCEDURE  sp_FindAssociateDetails
AS  CURSOR associateCursor is select * 
                                                        from Associate 
                                                            where YEARLYINVESTMENTUNDER80C>=10000;
    associateRow ASSOCIATE%ROWTYPE;
     NO_Records_Found EXCEPTION ;
begin
      OPEN associateCursor;
      FETCH associateCursor INTO associateRow;
      IF associateCursor%ROWCOUNT>0
          THEN
          LOOP
              FETCH associateCursor INTO associateRow;
                  DBMS_OUTPUT.PUT_LINE(associateRow.ASSOCIATEID||' '||associateRow.firstName||' '||associateRow.lastName);
                  EXIT WHEN associateCursor%NOTFOUND;
          END LOOP;
        ELSE
            RAISE NO_Records_Found; 
       END IF;     
          CLOSE associateCursor;  
          
        EXCEPTION 
          WHEN NO_Records_Found THEN
                  DBMS_OUTPUT.PUT_LINE('NO details found');
end sp_FindAssociateDetails; 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

create or replace PROCEDURE SP_INSERTASSOCIATEDATA
( aId IN NUMBER
, fName IN VARCHAR2
, lName IN VARCHAR2
, investment IN NUMBER
, dep IN VARCHAR2
, desg IN VARCHAR2
, pCard IN VARCHAR2
, eMail IN VARCHAR2
, param1 out number
,param2 out number
) AS
BEGIN
  insert into Associate values(aId,fName,lName,investment,dep,desg,pCard,eMail);
END SP_INSERTASSOCIATEDATA;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

execute SP_INSERTASSOCIATEDATA(106,'ABC','PQR',48000,'ADC','Con','JDSJF8737','ZDJ@gmail.com');

execute sp_FindAssociateDetails;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
create or replace function addNums(n1 number,n2 number)
return number
AS
begin
  return n1+n2;
end addNums;

declare 
  ans number;
begin
  ans:=addNums(10,20);
  DBMS_OUTPUT.PUT_LINE('ans ' ||ans);
end;  
---------------------------------------------------------------------------------------------------------------------------------------------------------------

create table insertCatlog(
  tableName varchar(50),
  insertTimeStamp TimeStamp
  )

  create or replace Trigger insertAssociateRecordTrigger
    After insert on Associate
    FOR EACH ROW
     BEGIN
        insert into insertCatlog values('Associate' ,sysdate);
    END;
    
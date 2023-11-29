DECLARE TYPE ViewArray IS VARRAY(155) OF VARCHAR2(70);

NAMES ViewArray;

total integer;

ViewId varchar2(15);

ViewName varchar2(70);

ExistFlag number(1);

BEGIN NAMES := ViewArray('Contact List View', 'Visible Contact List View', 'Manager''s Contact List View', 'All Contacts across Organizations', 'UCM Contact Duplicates View', 'Consumer List View', 'Personal Contact List View', 'FINS Contacts Financial Accounts View', 'FINCORP Contact Chart View - Lead Status Analysis', 'Contact Administration View', 'MDM CIF Contact History List View', 'MDM Contact Credentials History View', 'Contact Details View (Detail tab)', 'MDM Disable Contact Cleansing View', 'MDM PODFT View', 'CRS View', 'FATCA View', 'MDM Contact Credentials View', 'Contact Detail - Personal Address View', 'MDM Contact Phone View', 'MDM Contact Email View', 'Relationship Hierarchy View (Contact)', 'MDM Party Relationship View', 'MDM Contact Segment View', 'MDM Contact Black List View', 'MDM Contact Education View', 'MDM Contact Employment View', 'MDM Contact Relativies View', 'MDM CIF Contact History List Detail View', 'MDM Contact Credentials History Detail View', 'UCM Contact Cross Reference View', 'MDM Contact SDH Detail View', 'MDM PODFT SDH Detail View', 'MDM Contact DUL Dossier VBC View', 'MDM Contact Photo Dossier VBC View', 'MDM Contact CardSign Dossier VBC View', 'MDM Contact Service Request View', 'Contact Detail - Accounts View', 'Contact Detail View', 'Contact Activity Plan', 'Contact Detail - Tasks View', 'Contact Service Agreement List View', 'FIN Contact Alerts View', 'FIN Contact Applications View', 'Contact Assessment View', 'Contact Asset Mgmt View', 'Contact Attachment View', 'FIN Service Request Acct Services Contact Bill Pay Enrollment View', 'FIN Service Request Acct Services Contact Bill Payees View', 'FIN Service Request Acct Services Contact Payment Sched View', 'FINS Contact Detail - Billing Accounts View', 'FINS Application Mortgage Calculator - Early Payoff', 'FINS Application Mortgage Calculator - Loan Amount', 'FINS Application Mortgage Calculator - Loan Comparison', 'FINS Application Mortgage Calculator - Monthly Payment View', 'FINS Application Mortgage Calculator - Refinance Breakeven View', 'INS Contact Detail - Claims View', 'FINS Contact Financial Profile View', 'FINS Investment Contact Profile View', 'FINS Contact Personal Profile View', 'FINS Contact Coverage View', 'Contact Detail - Personal Payment Profile View', 'FINS Contact Profitability List View', 'Contact Customer Satisfaction Survey', 'FINS Contact Disclosures View', 'Contact Duplicates Detail View', 'FIN Contact Account View', 'FINS Financial Planning View', 'FINS Contact Household View', 'Contact Invoice View', 'List Mgmt Contacts Detail View', 'FINS Contact List Mgmt Lists View', 'FINS Application Mortgage Pre-Qualification Calculator View', 'FIN NA RET Checking View', 'FIN NA RET Convenience View', 'FIN NA RET Credit View', 'FINS Investment Portfolio Recommendation View', 'FINS Application Mortgage NA Pre-Qualification View', 'FIN NA RET Retirement View', 'FIN NA RET Saving View', 'Contact Private Note View', 'Contact Note View', 'Contact Offers View', 'Contact Detail - Opportunities View', 'INS Contact Detail - Policy View', 'FINS Application Mortgage NA Product Recom View', 'FINCORP Contact Profile View', 'FINCORP Contact Referral View', 'Contact Relationships View', 'FIN Contact Service View', 'INS Contact Detail - Underwriting Report View', 'MDM Dup Contact Details View', 'MDM Dup Contact Credentials View', 'MDM Dup Contact Detail - Personal Address View', 'MDM Dup Contact Phone View', 'MDM Dup Contact Email View', 'MDM Dup Contact Segment View', 'MDM Dup Contact Black List View', 'MDM Dup Contact Education View', 'MDM Dup Contact Employment View', 'MDM Dup Contact Relativies View', 'MDM Dup CIF Contact Reference View', 'MDM Contact UnMerge Detail View', 'MDM Contact Credentials UnMerge View', 'MDM Contact Address UnMerge View', 'MDM Contact Phone UnMerge View', 'MDM Contact Email UnMerge View', 'MDM Contact Segment UnMerge View', 'MDM Contact Black List UnMerge View', 'MDM Contact Education UnMerge View', 'MDM Contact Employment UnMerge View', 'MDM Contact Relativies UnMerge View', 'Consumer Detail View', 'Consumer Asset Mgmt - Asset View', 'Consumer Service Request View');

total := names.count;


FOR i in 1 .. total LOOP ViewName := names(i);


SELECT CASE WHEN(EXISTS
                   (SELECT ROW_ID
                    FROM siebel.S_VIEW
                    WHERE NAME=ViewName
                      AND rownum=1)) THEN 1
           ELSE 0
       END INTO ExistFlag
FROM dual;

IF ExistFlag=1 THEN
SELECT ROW_ID INTO ViewId
FROM siebel.S_VIEW
WHERE NAME=ViewName
  AND rownum=1;


INSERT INTO SIEBEL.CX_SCRN_AUDIT (ROW_ID, CONFLICT_ID, CREATED_BY, LAST_UPD_BY, DB_LAST_UPD, DB_LAST_UPD_SRC, NAME, VIEW_ID)
VALUES (siebel.s_sequence_pkg.get_next_rowid, '0', 'ScriptAuditMDM', '0-1', sysdate, 'Script', ViewName, ViewId);


COMMIT;

END IF;

END LOOP;

END;

/
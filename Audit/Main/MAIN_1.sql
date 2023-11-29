DECLARE BCName varchar2(70);

TblName varchar2(70);

ExistFlag number(1);

AppletExists number(1);

BCExistFlag number(1);

BEGIN
FOR rec in (
SELECT ps.ROW_ID,
       p.NAME
FROM SIEBEL.S_VIEW p
INNER JOIN SIEBEL.S_VIEW_WEB_TMPL ps ON p.ROW_ID = ps.VIEW_ID
WHERE p.NAME IN ('Contact List View',
                 'Visible Contact List View',
                 'Manager''s Contact List View',
                 'All Contacts across Organizations',
                 'UCM Contact Duplicates View',
                 'Consumer List View',
                 'Personal Contact List View',
                 'FINS Contacts Financial Accounts View',
                 'FINCORP Contact Chart View - Lead Status Analysis',
                 'Contact Administration View',
                 'MDM CIF Contact History List View',
                 'MDM Contact Credentials History View',
                 'Contact Details View (Detail tab)',
                 'MDM Disable Contact Cleansing View',
                 'MDM PODFT View',
                 'CRS View',
                 'FATCA View',
                 'MDM Contact Credentials View',
                 'Contact Detail - Personal Address View',
                 'MDM Contact Phone View',
                 'MDM Contact Email View',
                 'Relationship Hierarchy View (Contact)',
                 'MDM Party Relationship View',
                 'MDM Contact Segment View',
                 'MDM Contact Black List View',
                 'MDM Contact Education View',
                 'MDM Contact Employment View',
                 'MDM Contact Relativies View',
                 'MDM CIF Contact History List Detail View',
                 'MDM Contact Credentials History Detail View',
                 'UCM Contact Cross Reference View',
                 'MDM Contact SDH Detail View',
                 'MDM PODFT SDH Detail View',
                 'MDM Contact DUL Dossier VBC View',
                 'MDM Contact Photo Dossier VBC View',
                 'MDM Contact CardSign Dossier VBC View',
                 'MDM Contact Service Request View',
                 'Contact Detail - Accounts View',
                 'Contact Detail View',
                 'Contact Activity Plan',
                 'Contact Detail - Tasks View',
                 'Contact Service Agreement List View',
                 'FIN Contact Alerts View',
                 'FIN Contact Applications View',
                 'Contact Assessment View',
                 'Contact Asset Mgmt View',
                 'Contact Attachment View',
                 'FIN Service Request Acct Services Contact Bill Pay Enrollment View',
                 'FIN Service Request Acct Services Contact Bill Payees View',
                 'FIN Service Request Acct Services Contact Payment Sched View',
                 'FINS Contact Detail - Billing Accounts View',
                 'FINS Application Mortgage Calculator - Early Payoff',
                 'FINS Application Mortgage Calculator - Loan Amount',
                 'FINS Application Mortgage Calculator - Loan Comparison',
                 'FINS Application Mortgage Calculator - Monthly Payment View',
                 'FINS Application Mortgage Calculator - Refinance Breakeven View',
                 'INS Contact Detail - Claims View',
                 'FINS Contact Financial Profile View',
                 'FINS Investment Contact Profile View',
                 'FINS Contact Personal Profile View',
                 'FINS Contact Coverage View',
                 'Contact Detail - Personal Payment Profile View',
                 'FINS Contact Profitability List View',
                 'Contact Customer Satisfaction Survey',
                 'FINS Contact Disclosures View',
                 'Contact Duplicates Detail View',
                 'FIN Contact Account View',
                 'FINS Financial Planning View',
                 'FINS Contact Household View',
                 'Contact Invoice View',
                 'List Mgmt Contacts Detail View',
                 'FINS Contact List Mgmt Lists View',
                 'FINS Application Mortgage Pre-Qualification Calculator View',
                 'FIN NA RET Checking View',
                 'FIN NA RET Convenience View',
                 'FIN NA RET Credit View',
                 'FINS Investment Portfolio Recommendation View',
                 'FINS Application Mortgage NA Pre-Qualification View',
                 'FIN NA RET Retirement View',
                 'FIN NA RET Saving View',
                 'Contact Private Note View',
                 'Contact Note View',
                 'Contact Offers View',
                 'Contact Detail - Opportunities View',
                 'INS Contact Detail - Policy View',
                 'FINS Application Mortgage NA Product Recom View',
                 'FINCORP Contact Profile View',
                 'FINCORP Contact Referral View',
                 'Contact Relationships View',
                 'FIN Contact Service View',
                 'INS Contact Detail - Underwriting Report View',
                 'MDM Dup Contact Details View',
                 'MDM Dup Contact Credentials View',
                 'MDM Dup Contact Detail - Personal Address View',
                 'MDM Dup Contact Phone View',
                 'MDM Dup Contact Email View',
                 'MDM Dup Contact Segment View',
                 'MDM Dup Contact Black List View',
                 'MDM Dup Contact Education View',
                 'MDM Dup Contact Employment View',
                 'MDM Dup Contact Relativies View',
                 'MDM Dup CIF Contact Reference View',
                 'MDM Contact UnMerge Detail View',
                 'MDM Contact Credentials UnMerge View',
                 'MDM Contact Address UnMerge View',
                 'MDM Contact Phone UnMerge View',
                 'MDM Contact Email UnMerge View',
                 'MDM Contact Segment UnMerge View',
                 'MDM Contact Black List UnMerge View',
                 'MDM Contact Education UnMerge View',
                 'MDM Contact Employment UnMerge View',
                 'MDM Contact Relativies UnMerge View',
                 'Consumer Detail View',
                 'Consumer Asset Mgmt - Asset View',
                 'Consumer Service Request View') LOOP BEGIN
  FOR rec1 in
    (SELECT APPLET_NAME
     FROM SIEBEL.S_VIEW_WTMPL_IT
     WHERE VIEW_WEB_TMPL_ID = rec.ROW_ID) LOOP BEGIN
  SELECT CASE
             WHEN (EXISTS
                     (SELECT APPLET_NAME
                      FROM SIEBEL.S_VIEW_WTMPL_IT
                      WHERE APPLET_NAME = rec1.APPLET_NAME
                        AND INACTIVE_FLG!='Y')
                   AND EXISTS
                     (SELECT BUSCOMP_NAME
                      FROM SIEBEL.S_APPLET
                      WHERE NAME = rec1.APPLET_NAME
                        AND INACTIVE_FLG!='Y')) THEN 1
             ELSE 0
         END INTO AppletExists
FROM dual;

IF AppletExists=1 THEN
SELECT DISTINCT BUSCOMP_NAME INTO BCName
FROM SIEBEL.S_APPLET
WHERE NAME = rec1.APPLET_NAME;


SELECT DISTINCT TABLE_NAME INTO TblName
FROM SIEBEL.S_BUSCOMP
WHERE NAME = BCName;

BEGIN
SELECT CASE
           WHEN exists
                  (SELECT BUSCOMP_NAME
                   FROM SIEBEL.S_AUDIT_BUSCOMP
                   WHERE BUSCOMP_NAME = BCName) THEN 1
           ELSE 0
       END INTO ExistFlag
FROM dual;

END;

IF ExistFlag = 0
AND TblName IS NOT NULL THEN
INSERT INTO SIEBEL.S_AUDIT_BUSCOMP (ROW_ID, CONFLICT_ID, CREATED_BY, LAST_UPD_BY, DB_LAST_UPD, DB_LAST_UPD_SRC, ASSOC_FLG, BASE_TBL_NAME, BUSCOMP_NAME, COPY_FLG, DELETE_FLG, EXPORT_FLG, NEW_FLG, RESTRICTION_CD, START_DT, SYS_AUDIT_FLG, UPDATE_FLG, END_DT, DESC_TEXT)
VALUES (siebel.s_sequence_pkg.get_next_rowid, '0', 'ScriptAuditMDM', '0-1', sysdate-1, 'ScriptAuditMDM','N',TblName, BCName,'N','N','Y','N','Без ограничений',sysdate-1,'N','N',NULL,NULL);


COMMIT;


INSERT INTO SIEBEL.CX_BC_AUDIT (ROW_ID, CONFLICT_ID, CREATED_BY, LAST_UPD_BY, DB_LAST_UPD, DB_LAST_UPD_SRC, BUSCOMP, BUSCOMP_NUMBER)
VALUES (siebel.s_sequence_pkg.get_next_rowid, '0', 'ScriptAuditMDM', '0-1', sysdate-1, 'ScriptAuditMDM', BCName,1);


COMMIT;

END IF;

IF ExistFlag = 1 THEN
UPDATE SIEBEL.S_AUDIT_BUSCOMP
SET EXPORT_FLG = 'Y'
WHERE BUSCOMP_NAME=BCName;


COMMIT;


UPDATE SIEBEL.S_AUDIT_BUSCOMP
SET END_DT = NULL
WHERE BUSCOMP_NAME=BCName;


COMMIT;

BEGIN
SELECT CASE
           WHEN exists
                  (SELECT BUSCOMP
                   FROM SIEBEL.CX_BC_AUDIT
                   WHERE BUSCOMP = BCName) THEN 1
           ELSE 0
       END INTO BCExistFlag
FROM dual;

END;

IF BCExistFlag = 0 THEN
INSERT INTO SIEBEL.CX_BC_AUDIT (ROW_ID, CONFLICT_ID, CREATED_BY, LAST_UPD_BY, DB_LAST_UPD, DB_LAST_UPD_SRC, BUSCOMP, BUSCOMP_NUMBER)
VALUES (siebel.s_sequence_pkg.get_next_rowid, '0', 'ScriptAuditMDM', '0-1', sysdate-1, 'ScriptAuditMDM', BCName,1);


COMMIT;

ELSE
UPDATE SIEBEL.CX_BC_AUDIT
SET BUSCOMP_NUMBER = BUSCOMP_NUMBER+1
WHERE BUSCOMP=BCName;


COMMIT;

END IF;

END IF;

END IF;

END;

END LOOP;

END;

END LOOP;


INSERT INTO SIEBEL.S_AUDIT_BUSCOMP (ROW_ID, CONFLICT_ID, CREATED_BY, LAST_UPD_BY, DB_LAST_UPD, DB_LAST_UPD_SRC, ASSOC_FLG, BASE_TBL_NAME, BUSCOMP_NAME, COPY_FLG, DELETE_FLG, EXPORT_FLG, NEW_FLG, RESTRICTION_CD, START_DT, SYS_AUDIT_FLG, UPDATE_FLG, END_DT, DESC_TEXT)
VALUES (siebel.s_sequence_pkg.get_next_rowid, '0', 'ScriptAuditMDM', '0-1', sysdate-1, 'ScriptAuditMDM','N','S_PARTY', 'MDM Merged Contact','N','N','Y','N','Без ограничений',sysdate-1,'N','N',NULL,NULL);


COMMIT;


INSERT INTO SIEBEL.CX_BC_AUDIT (ROW_ID, CONFLICT_ID, CREATED_BY, LAST_UPD_BY, DB_LAST_UPD, DB_LAST_UPD_SRC, BUSCOMP, BUSCOMP_NUMBER)
VALUES (siebel.s_sequence_pkg.get_next_rowid, '0', 'ScriptAuditMDM', '0-1', sysdate-1, 'ScriptAuditMDM', 'MDM Merged Contact',1);


COMMIT;

END;

/
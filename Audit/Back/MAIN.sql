BEGIN
DELETE
FROM SIEBEL.S_AUDIT_BUSCOMP
WHERE CREATED_BY = 'ScriptAuditMDM';


COMMIT;


DELETE
FROM SIEBEL.CX_BC_AUDIT;


COMMIT;


DELETE
FROM SIEBEL.CX_SCRN_AUDIT;


COMMIT;


DELETE
FROM SIEBEL.S_RESP
WHERE CREATED_BY = 'ScriptAuditMDM';


COMMIT;


DELETE
FROM SIEBEL.S_APP_VIEW
WHERE CREATED_BY = 'ScriptAuditMDM';


COMMIT;


DELETE
FROM SIEBEL.S_APP_VIEW_RESP
WHERE CREATED_BY = 'ScriptAuditMDM';


COMMIT;

END;

/
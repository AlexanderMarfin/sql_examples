WHENEVER
SQLERROR EXIT 50;

WHENEVER OSERROR EXIT 66;


CREATE TABLE CX_MDM_CFT_LOG (mdmid VARCHAR2(100 CHAR) NOT NULL,
                                                      cftid VARCHAR2(100 CHAR) NOT NULL,
                                                                               error_msg VARCHAR2(250 CHAR),
                                                                                         created DATE DEFAULT sysdate NOT NULL) /
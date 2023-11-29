CREATE TABLE TempCFT (ID_M3_PROFILE VARCHAR2(100 CHAR) NOT NULL,
                                                       ID_M3_CFT2RS VARCHAR2(100 CHAR) NOT NULL,
                                                                                       MSG VARCHAR2(40 CHAR),
                                                                                           MSG1 VARCHAR2(40 CHAR));


CREATE UNIQUE INDEX indx1 ON TempCFT (ID_M3_PROFILE);


CREATE UNIQUE INDEX indx2 ON TempCFT (ID_M3_CFT2RS) /
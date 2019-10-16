CREATE TABLE COMTECOPSEQ
(
	TABLE_NAME            VARCHAR(20) NOT NULL,
	NEXT_ID               NUMERIC(30) NULL,
	 PRIMARY KEY (TABLE_NAME)
)
;

CREATE UNIQUE INDEX COMTECOPSEQ_PK ON COMTECOPSEQ
(
	TABLE_NAME
)
;



CREATE TABLE COMTNBATCHOPERT
(
	BATCH_OPERT_ID        VARCHAR(20) NOT NULL,
	BATCH_OPERT_NM        VARCHAR(60) NULL,
	BATCH_PROGRM          VARCHAR(255) NULL,
	PARAMTR               VARCHAR(250) NULL,
	USE_AT                CHAR(1) NULL,
	FRST_REGISTER_ID      VARCHAR(20) NULL,
	FRST_REGIST_PNTTM     DATETIME NULL,
	LAST_UPDUSR_ID        VARCHAR(20) NULL,
	LAST_UPDT_PNTTM       DATETIME NOT NULL,
	 PRIMARY KEY (BATCH_OPERT_ID)
)
;

CREATE UNIQUE INDEX COMTNBATCHOPERT_PK ON COMTNBATCHOPERT
(
	BATCH_OPERT_ID
)
;



CREATE TABLE COMTNBATCHRESULT
(
	BATCH_RESULT_ID       VARCHAR(20) NOT NULL,
	BATCH_SCHDUL_ID       VARCHAR(20) NOT NULL,
	BATCH_OPERT_ID        VARCHAR(20) NOT NULL,
	PARAMTR               VARCHAR(250) NULL,
	STTUS                 VARCHAR(2) NULL,
	ERROR_INFO            VARCHAR(2000) NULL,
	EXECUT_BEGIN_TM       VARCHAR(14) NULL,
	EXECUT_END_TM         VARCHAR(14) NULL,
	LAST_UPDT_PNTTM       DATETIME NULL,
	LAST_UPDUSR_ID        VARCHAR(20) NULL,
	FRST_REGIST_PNTTM     DATETIME NOT NULL,
	FRST_REGISTER_ID      VARCHAR(20) NULL,
	 PRIMARY KEY (BATCH_RESULT_ID)
)
;

CREATE UNIQUE INDEX COMTNBATCHRESULT_PK ON COMTNBATCHRESULT
(
	BATCH_RESULT_ID
)
;



CREATE TABLE COMTNRESTDE
(
	RESTDE_NO             NUMERIC(6) NOT NULL,
	RESTDE                CHAR(8) NULL,
	RESTDE_NM             VARCHAR(60) NULL,
	RESTDE_DC             VARCHAR(200) NULL,
	RESTDE_SE_CODE        VARCHAR(2) NULL,
	FRST_REGIST_PNTTM     DATETIME NULL,
	FRST_REGISTER_ID      VARCHAR(20) NULL,
	LAST_UPDT_PNTTM       DATETIME NULL,
	LAST_UPDUSR_ID        VARCHAR(20) NULL,
	 PRIMARY KEY (RESTDE_NO)
)
;

CREATE UNIQUE INDEX COMTNRESTDE_PK ON COMTNRESTDE
(
	RESTDE_NO
)
;



CREATE TABLE COMTCCMMNCLCODE
(
	CL_CODE               CHAR(3) NOT NULL,
	CL_CODE_NM            VARCHAR(60) NULL,
	CL_CODE_DC            VARCHAR(200) NULL,
	USE_AT                CHAR(1) NULL,
	FRST_REGIST_PNTTM     DATETIME NULL,
	FRST_REGISTER_ID      VARCHAR(20) NULL,
	LAST_UPDT_PNTTM       DATETIME NULL,
	LAST_UPDUSR_ID        VARCHAR(20) NULL,
	 PRIMARY KEY (CL_CODE)
)
;

CREATE UNIQUE INDEX COMTCCMMNCLCODE_PK ON COMTCCMMNCLCODE
(
	CL_CODE
)
;



CREATE TABLE COMTCCMMNCODE
(
	CODE_ID               VARCHAR(6) NOT NULL,
	CODE_ID_NM            VARCHAR(60) NULL,
	CODE_ID_DC            VARCHAR(200) NULL,
	USE_AT                CHAR(1) NULL,
	CL_CODE               CHAR(3) NULL,
	FRST_REGIST_PNTTM     DATETIME NULL,
	FRST_REGISTER_ID      VARCHAR(20) NULL,
	LAST_UPDT_PNTTM       DATETIME NULL,
	LAST_UPDUSR_ID        VARCHAR(20) NULL,
	 PRIMARY KEY (CODE_ID),
	FOREIGN KEY COMTCCMMNCODE_FK1 (CL_CODE) REFERENCES COMTCCMMNCLCODE(CL_CODE)
)
;

CREATE UNIQUE INDEX COMTCCMMNCODE_PK ON COMTCCMMNCODE
(
	CODE_ID
)
;
CREATE INDEX COMTCCMMNCODE_i01 ON COMTCCMMNCODE
(
	CL_CODE
)
;



CREATE TABLE COMTCCMMNDETAILCODE
(
	CODE_ID               VARCHAR(6) NOT NULL,
	CODE                  VARCHAR(15) NOT NULL,
	CODE_NM               VARCHAR(60) NULL,
	CODE_DC               VARCHAR(200) NULL,
	USE_AT                CHAR(1) NULL,
	FRST_REGIST_PNTTM     DATETIME NULL,
	FRST_REGISTER_ID      VARCHAR(20) NULL,
	LAST_UPDT_PNTTM       DATETIME NULL,
	LAST_UPDUSR_ID        VARCHAR(20) NULL,
	 PRIMARY KEY (CODE_ID,CODE),
	FOREIGN KEY COMTCCMMNDETAILCODE_FK1 (CODE_ID) REFERENCES COMTCCMMNCODE(CODE_ID)
)
;

CREATE UNIQUE INDEX COMTCCMMNDETAILCODE_PK ON COMTCCMMNDETAILCODE
(
	CODE_ID,
	CODE
)
;
CREATE INDEX COMTCCMMNDETAILCODE_i01 ON COMTCCMMNDETAILCODE
(
	CODE_ID
)
;



CREATE TABLE COMTNAUTHORGROUPINFO
(
	GROUP_ID              CHAR(20) NOT NULL,
	GROUP_NM              VARCHAR(60) NOT NULL,
	GROUP_CREAT_DE        CHAR(20) NOT NULL,
	GROUP_DC              VARCHAR(100) NULL,
	 PRIMARY KEY (GROUP_ID)
)
;

CREATE UNIQUE INDEX COMTNAUTHORGROUPINFO_PK ON COMTNAUTHORGROUPINFO
(
	GROUP_ID
)
;



CREATE TABLE COMTNORGNZTINFO
(
	ORGNZT_ID             CHAR(20) NOT NULL,
	ORGNZT_NM             VARCHAR(20) NOT NULL,
	ORGNZT_DC             VARCHAR(100) NULL,
	 PRIMARY KEY (ORGNZT_ID)
)
;

CREATE UNIQUE INDEX COMTNORGNZTINFO_PK ON COMTNORGNZTINFO
(
	ORGNZT_ID
)
;



CREATE TABLE COMTNFILE
(
	ATCH_FILE_ID          CHAR(20) NOT NULL,
	CREAT_DT              DATETIME NOT NULL,
	USE_AT                CHAR(1) NULL,
	 PRIMARY KEY (ATCH_FILE_ID)
)
;

CREATE UNIQUE INDEX COMTNFILE_PK ON COMTNFILE
(
	ATCH_FILE_ID
)
;



CREATE TABLE COMTNFILEDETAIL
(
	ATCH_FILE_ID          CHAR(20) NOT NULL,
	FILE_SN               NUMERIC(10) NOT NULL,
	FILE_STRE_COURS       VARCHAR(2000) NOT NULL,
	STRE_FILE_NM          VARCHAR(255) NOT NULL,
	ORIGNL_FILE_NM        VARCHAR(255) NULL,
	FILE_EXTSN            VARCHAR(20) NOT NULL,
	FILE_CN               MEDIUMTEXT NULL,
	FILE_SIZE             NUMERIC(8) NULL,
	 PRIMARY KEY (ATCH_FILE_ID,FILE_SN),
	FOREIGN KEY COMTNFILEDETAIL_FK1 (ATCH_FILE_ID) REFERENCES COMTNFILE(ATCH_FILE_ID)
)
;

CREATE UNIQUE INDEX COMTNFILEDETAIL_PK ON COMTNFILEDETAIL
(
	ATCH_FILE_ID,
	FILE_SN
)
;
CREATE INDEX COMTNFILEDETAIL_i01 ON COMTNFILEDETAIL
(
	ATCH_FILE_ID
)
;



CREATE TABLE COMTNBATCHSCHDUL
(
	BATCH_SCHDUL_ID       VARCHAR(20) NOT NULL,
	BATCH_OPERT_ID        VARCHAR(20) NOT NULL,
	EXECUT_CYCLE          VARCHAR(2) NULL,
	EXECUT_SCHDUL_DE      CHAR(20) NULL,
	EXECUT_SCHDUL_HOUR    CHAR(2) NULL,
	EXECUT_SCHDUL_MNT     CHAR(2) NULL,
	EXECUT_SCHDUL_SECND   CHAR(2) NULL,
	FRST_REGISTER_ID      VARCHAR(20) NULL,
	FRST_REGIST_PNTTM     DATETIME NULL,
	LAST_UPDUSR_ID        VARCHAR(20) NULL,
	LAST_UPDT_PNTTM       DATETIME NOT NULL,
	 PRIMARY KEY (BATCH_SCHDUL_ID)
)
;

CREATE UNIQUE INDEX COMTNBATCHSCHDUL_PK ON COMTNBATCHSCHDUL
(
	BATCH_SCHDUL_ID
)
;



CREATE TABLE COMTNBATCHSCHDULDFK
(
	BATCH_SCHDUL_ID       VARCHAR(20) NOT NULL,
	EXECUT_SCHDUL_DFK_SE  CHAR(1) NOT NULL,
	 PRIMARY KEY (BATCH_SCHDUL_ID,EXECUT_SCHDUL_DFK_SE),
	FOREIGN KEY COMTNBATCHSCHDULDFK_FK1 (BATCH_SCHDUL_ID) REFERENCES COMTNBATCHSCHDUL(BATCH_SCHDUL_ID)
)
;

CREATE UNIQUE INDEX COMTNBATCHSCHDULDFK_PK ON COMTNBATCHSCHDULDFK
(
	BATCH_SCHDUL_ID,
	EXECUT_SCHDUL_DFK_SE
)
;




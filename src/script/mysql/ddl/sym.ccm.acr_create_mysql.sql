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



CREATE TABLE COMTCADMINISTCODE
(
	ADMINIST_ZONE_SE      CHAR(1) NOT NULL,
	ADMINIST_ZONE_CODE    VARCHAR(10) NOT NULL,
	USE_AT                CHAR(1) NOT NULL,
	ADMINIST_ZONE_NM      VARCHAR(60) NULL,
	UPPER_ADMINIST_ZONE_CODE  VARCHAR(10) NULL,
	CREAT_DE              CHAR(20) NULL,
	ABL_DE                CHAR(20) NULL,
	FRST_REGIST_PNTTM     DATETIME NULL,
	FRST_REGISTER_ID      VARCHAR(20) NULL,
	LAST_UPDT_PNTTM       DATETIME NULL,
	LAST_UPDUSR_ID        VARCHAR(20) NULL,
	 PRIMARY KEY (ADMINIST_ZONE_SE,ADMINIST_ZONE_CODE)
)
;

CREATE UNIQUE INDEX COMTCADMINISTCODE_PK ON COMTCADMINISTCODE
(
	ADMINIST_ZONE_SE,
	ADMINIST_ZONE_CODE
)
;



CREATE TABLE COMTCADMINISTCODERECPTNLOG
(
	OCCRRNC_DE            CHAR(20) NOT NULL,
	ADMINIST_ZONE_SE      CHAR(1) NOT NULL,
	ADMINIST_ZONE_CODE    VARCHAR(10) NOT NULL,
	OPERT_SN              NUMERIC(10) NOT NULL,
	CHANGE_SE_CODE        VARCHAR(2) NULL,
	PROCESS_SE            VARCHAR(2) NULL,
	ADMINIST_ZONE_NM      VARCHAR(60) NULL,
	LOWEST_ADMINIST_ZONE_NM  VARCHAR(60) NULL,
	CTPRVN_CODE           VARCHAR(2) NULL,
	SIGNGU_CODE           VARCHAR(3) NULL,
	EMD_CODE              VARCHAR(3) NULL,
	LI_CODE               VARCHAR(2) NULL,
	CREAT_DE              CHAR(20) NULL,
	ABL_DE                CHAR(20) NULL,
	ABL_ENNC              CHAR(1) NULL,
	FRST_REGISTER_ID      VARCHAR(20) NULL,
	FRST_REGIST_PNTTM     DATETIME NULL,
	LAST_UPDUSR_ID        VARCHAR(20) NULL,
	LAST_UPDT_PNTTM       DATETIME NULL,
	 PRIMARY KEY (OCCRRNC_DE,ADMINIST_ZONE_SE,ADMINIST_ZONE_CODE,OPERT_SN)
)
;

CREATE UNIQUE INDEX COMTCADMINISTCODERECPTNLOG_PK ON COMTCADMINISTCODERECPTNLOG
(
	OCCRRNC_DE,
	ADMINIST_ZONE_SE,
	ADMINIST_ZONE_CODE,
	OPERT_SN
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




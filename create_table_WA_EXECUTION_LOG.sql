CREATE TABLE EDUMAN.WA_EXECUTION_LOG
(
  LOG_ID             NUMBER PRIMARY KEY,
  WA_NAME            VARCHAR2(64),
  PROCESS_START_DATE DATE,
  PROCESS_END_DATE   DATE,
  STATUS             VARCHAR2(1),
  REMARK             VARCHAR2(4000),
  LOG_DATE           DATE
);

-- Add comments to the table 
COMMENT ON TABLE EDUMAN.WA_EXECUTION_LOG IS 'WA_EXECUTION_LOG entity stores log information about workaround and their execution to know process start, end, status.';

-- Add comments to the columns 
COMMENT ON column EDUMAN.WA_EXECUTION_LOG.log_id IS 'LOG_ID attribute stores process number of workaround execution log. Unique primary key, filled with WA_EXECUTION_LOG_SEQ sequence';
COMMENT ON column EDUMAN.WA_EXECUTION_LOG.wa_name IS 'WA_NAME attribute stores workaround name for execution log.';
COMMENT ON column EDUMAN.WA_EXECUTION_LOG.process_start_date IS 'PROCESS_START_DATE attribute stores start date of process for a workaround.';
COMMENT ON column EDUMAN.WA_EXECUTION_LOG.process_end_date IS 'PROCESS_END_DATE attribute stores end date of process for a workaround.';
COMMENT ON column EDUMAN.WA_EXECUTION_LOG.status IS 'STATUS attribute stores status of process execution.';
COMMENT ON column EDUMAN.WA_EXECUTION_LOG.remark IS 'REMARK attribute stores remark for workaround execution log.';
COMMENT ON column EDUMAN.WA_EXECUTION_LOG.log_date IS 'LOG_DATE attribute stores date of log.';

-- CREATE SEQUENCE 
CREATE SEQUENCE EDUMAN.WA_EXECUTION_LOG_SEQ
	MINVALUE 1
	MAXVALUE 999999999999999999999999999
	START WITH 1
	INCREMENT BY 1
	CACHE 20;

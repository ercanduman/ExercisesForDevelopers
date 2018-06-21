CREATE OR REPLACE PACKAGE BODY EDUMAN.EFD
/**************************************************************************************
  * Purpose    : The solution of all challenges of "Exercises for Programmers" book  written by "Brian P. Hogan".
                 (57 Challenges to Develop Your Coding Skills)
  * Notes      : EFD: Exercises For Developers
                 All codes written in Oracle database language PLSQL on XE database. 
  * -------------------------------------------------------------------------------------
  * History    :        
   | Author         | Date                 | Purpose
   |-------         |-----------           |-----------------------------------
   | Ercan DUMAN    | 25.01.2018           | Package creation.
  **************************************************************************************/
 IS

  cs_OUTPUT_FAILURE_PREFIX CONSTANT VARCHAR2(7) := 'ERROR> ';
  cs_OUTPUT_SUCCESS_PREFIX CONSTANT VARCHAR2(7) := 'INFO> ';
  cs_PROGRAM_OUTPUT        CONSTANT VARCHAR2(8) := 'OUTPUT> ';

  PROCEDURE SayingHello(pis_Name IN VARCHAR2)
  /**************************************************************************************
    * Purpose    : Create a program that prompts for your name and prints a greeting using your name.
    * Notes      : N/A
    * -------------------------------------------------------------------------------------
    * Parameters : 
      - pis_Name  : User name input text.
    * Return     : N/A
    * Exceptions : N/A
    * -------------------------------------------------------------------------------------
    * History    :        
    | Author         | Date                 | Purpose
    |-------         |-----------           |-----------------------------------
    | Ercan DUMAN    | 25-JAN-2018          | Procedure creation.
    **************************************************************************************/
   IS
  BEGIN
    dbms_output.put_line(cs_PROGRAM_OUTPUT || 'Hello, ' || pis_Name ||
                         ' nice to meet you!');
  END SayingHello;

  PROCEDURE CountingTheNumberOfCharacters(pis_InputSring VARCHAR2)
  /**************************************************************************************
    * Purpose    : Create a program that prompts for an input string and displays output that shows the input string and the number of characters the string contains.. 
    * Notes      : If the user enters nothing, state that the user must enter something into the program.
    * -------------------------------------------------------------------------------------
    * Parameters : 
     - pis_InputSring : Qoute input text.
    * Return     : N/A
    * Exceptions : 
     - ve_EmptyInputException: Raised if the input is empty!
    * -------------------------------------------------------------------------------------
    * History    :        
    | Author         | Date                 | Purpose
    |-------         |-----------           |-----------------------------------
    | Ercan DUMAN    | 20-JUN-2018          | Procedure creation.
    **************************************************************************************/
   IS
    vn_InputStringLentgh NUMBER;
    ve_EmptyInputException EXCEPTION;
  BEGIN
    vn_InputStringLentgh := length(pis_InputSring);
    IF vn_InputStringLentgh IS NULL
       OR vn_InputStringLentgh <= 0 THEN
      RAISE ve_EmptyInputException;
    END IF;
  
    dbms_output.put_line(cs_OUTPUT_SUCCESS_PREFIX ||
                         'What is the input string? ''' || pis_InputSring || '''');
    dbms_output.put_line(cs_PROGRAM_OUTPUT || pis_InputSring || ' has ' ||
                         vn_InputStringLentgh || ' characters!');
  EXCEPTION
    WHEN ve_EmptyInputException THEN
      dbms_output.put_line(cs_OUTPUT_FAILURE_PREFIX ||
                           ' must enter something into the program!');
  END CountingTheNumberOfCharacters;

  PROCEDURE PrintingQuotes
  (
    pis_Quote  IN VARCHAR2,
    pis_Author IN VARCHAR2
  )
  /**************************************************************************************
    * Purpose    : Create a program that prompts for a quote and an author. Display the quotation and author. 
    * Notes      : 
    * -------------------------------------------------------------------------------------
    * Parameters : 
     - pis_Quote  : Qoute input text.
     - pis_Author : The author of qoute.
    * Return     : N/A
    * Exceptions : N/A
    * -------------------------------------------------------------------------------------
    * History    :        
    | Author         | Date                 | Purpose
    |-------         |-----------           |-----------------------------------
    | Ercan DUMAN    | 21-JUN-2018          | Procedure creation.
    **************************************************************************************/
   IS
  BEGIN
    dbms_output.put_line(cs_OUTPUT_SUCCESS_PREFIX || 'What is the quote? ' ||
                         pis_Quote);
    dbms_output.put_line(cs_OUTPUT_SUCCESS_PREFIX || 'Who said it? ' ||
                         pis_Author);
    dbms_output.put_line(cs_PROGRAM_OUTPUT || pis_Author || ' says, "' ||
                         pis_Quote || '"');
  END PrintingQuotes;

  PROCEDURE AddWAExecutionLog
  (
    pis_WaName           EDUMAN.WA_EXECUTION_LOG.WA_NAME%TYPE,
    pid_ProcessStartDate EDUMAN.WA_EXECUTION_LOG.PROCESS_START_DATE%TYPE,
    pid_ProcessEndDate   EDUMAN.WA_EXECUTION_LOG.PROCESS_END_DATE%TYPE,
    pis_Status           EDUMAN.WA_EXECUTION_LOG.STATUS%TYPE,
    pis_Remark           EDUMAN.WA_EXECUTION_LOG.REMARK%TYPE
  )
  /**************************************************************************************
      * Purpose    : To log/trace every process of workaround and insert the log data in  EDUMAN.WA_EXECUTION_LOG table.
      * Notes      : N/A
      * -------------------------------------------------------------------------------------
      * Parameters :
      - pis_WaName : Workaround name for execution log
      - pid_ProcessStartDate : Execution start time
      - pid_ProcessEndDate : Execution end time
      - pis_Status : Status of execution process failed or succeed (F,S)
      - pis_Remark : Remark for execution
      * Return     : N/A
      * Exceptions :
      * -------------------------------------------------------------------------------------
      * History    :
       | Author        | Date                 | Purpose
       |-------        |-----------           |----------------------------------------------
       | Ercan DUMAN   | 21-JUN-2018          | Procedure creation.
    **************************************************************************************/
   IS
    PRAGMA AUTONOMOUS_TRANSACTION; --> This means COMMIT only in this procedure, do not effect other processes.
  BEGIN
    INSERT INTO EDUMAN.WA_EXECUTION_LOG
      (LOG_ID, WA_NAME, PROCESS_START_DATE, PROCESS_END_DATE, STATUS, REMARK, LOG_DATE)
    VALUES
      (EDUMAN.WA_EXECUTION_LOG_SEQ.NEXTVAL, pis_WaName, pid_ProcessStartDate, pid_ProcessEndDate, pis_Status, pis_Remark, SYSDATE);
    COMMIT;
  END AddWAExecutionLog;

END EFD;
/

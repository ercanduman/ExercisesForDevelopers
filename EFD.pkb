CREATE OR REPLACE PACKAGE BODY EDUMAN.EFD
/**************************************************************************************
  * Purpose    : The solution for the challenges of "Exercises for Programmers" book  written by "Brian P. Hogan".
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
  cs_OUTPUT_SUCCESS_PREFIX CONSTANT VARCHAR2(7) := 'INFO> ';
  cs_PROGRAM_OUTPUT        CONSTANT VARCHAR2(8) := 'OUTPUT> ';

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
    vd_LastExecutionDate DATE;
    vs_ErrorMessage      VARCHAR2(3000);
  BEGIN
    vd_LastExecutionDate := SYSDATE;
    dbms_output.put_line(cs_PROGRAM_OUTPUT || 'Hello, ' || pis_Name ||
                         ' nice to meet you!');
    -- logging  
    AddWAExecutionLog('EFD.SayingHello', vd_LastExecutionDate, SYSDATE, 'S', 'SayingHello, Run successfully!');
  EXCEPTION
    WHEN OTHERS THEN
      vs_ErrorMessage := SUBSTR('SayingHello ERROR :  ' || SQLERRM ||
                                DBMS_UTILITY.format_error_backtrace, 1, 3000);
      AddWAExecutionLog('EFD.SayingHello', vd_LastExecutionDate, SYSDATE, 'F', vs_ErrorMessage);
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
    vd_LastExecutionDate DATE;
    vs_ErrorMessage      VARCHAR2(3000);
    ve_EmptyInputException EXCEPTION;
  BEGIN
    vd_LastExecutionDate := SYSDATE;
    vn_InputStringLentgh := length(pis_InputSring);
    IF vn_InputStringLentgh IS NULL
       OR vn_InputStringLentgh <= 0 THEN
      RAISE ve_EmptyInputException;
    END IF;
  
    dbms_output.put_line(cs_OUTPUT_SUCCESS_PREFIX ||
                         'What is the input string? ''' || pis_InputSring || '''');
    dbms_output.put_line(cs_PROGRAM_OUTPUT || pis_InputSring || ' has ' ||
                         vn_InputStringLentgh || ' characters!');
  
    -- logging  
    AddWAExecutionLog('EFD.CountingTheNumberOfCharacters', vd_LastExecutionDate, SYSDATE, 'S', 'CountingTheNumberOfCharacters, Run successfully!');
  EXCEPTION
    WHEN ve_EmptyInputException THEN
      vs_ErrorMessage := SUBSTR('CountingTheNumberOfCharacters ERROR :  ' ||
                                ' must enter something into the program! ' ||
                                SQLERRM ||
                                DBMS_UTILITY.format_error_backtrace, 1, 3000);
      AddWAExecutionLog('EFD.CountingTheNumberOfCharacters', vd_LastExecutionDate, SYSDATE, 'F', vs_ErrorMessage);
    
    WHEN OTHERS THEN
      vs_ErrorMessage := SUBSTR('CountingTheNumberOfCharacters ERROR :  ' ||
                                SQLERRM ||
                                DBMS_UTILITY.format_error_backtrace, 1, 3000);
      AddWAExecutionLog('EFD.CountingTheNumberOfCharacters', vd_LastExecutionDate, SYSDATE, 'F', vs_ErrorMessage);
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
    vd_LastExecutionDate DATE;
    vs_ErrorMessage      VARCHAR2(3000);
  BEGIN
    vd_LastExecutionDate := SYSDATE;
    dbms_output.put_line(cs_OUTPUT_SUCCESS_PREFIX || 'What is the quote? ' ||
                         pis_Quote);
    dbms_output.put_line(cs_OUTPUT_SUCCESS_PREFIX || 'Who said it? ' ||
                         pis_Author);
    dbms_output.put_line(cs_PROGRAM_OUTPUT || pis_Author || ' says, "' ||
                         pis_Quote || '"');
  
    -- logging  
    AddWAExecutionLog('EFD.PrintingQuotes', vd_LastExecutionDate, SYSDATE, 'S', 'PrintingQuotes, Run successfully!');
  EXCEPTION
    WHEN OTHERS THEN
      vs_ErrorMessage := SUBSTR('PrintingQuotes ERROR :  ' || SQLERRM ||
                                DBMS_UTILITY.format_error_backtrace, 1, 3000);
      AddWAExecutionLog('EFD.PrintingQuotes', vd_LastExecutionDate, SYSDATE, 'F', vs_ErrorMessage);
  END PrintingQuotes;

  PROCEDURE SimpleMath
  (
    pin_FirstNumber  IN NUMBER,
    pin_SecondNumber IN NUMBER
  )
  /**************************************************************************************
    * Purpose    : Write a program that prompts for two numbers. Print the sum, difference, product, and quotient of those numbers
    * Notes      : Don’t allow the user to enter a negative number.
    * -------------------------------------------------------------------------------------
    * Parameters : 
     - pin_FirstNumber  : First number that user input to use for calculations.
     - pin_SecondNumber : Second number that user input to use for calculations.
    * Return     : N/A
    * Exceptions : N/A
    * -------------------------------------------------------------------------------------
    * History    :        
    | Author         | Date                 | Purpose
    |-------         |-----------           |-----------------------------------
    | Ercan DUMAN    | 21-JUN-2018          | Procedure creation.
    **************************************************************************************/
   IS
    vd_LastExecutionDate DATE;
    vs_ErrorMessage      VARCHAR2(3000);
    ve_NegativeNumberException EXCEPTION;
  BEGIN
    vd_LastExecutionDate := SYSDATE;
  
    IF pin_FirstNumber < 0
       OR pin_SecondNumber < 0 THEN
      RAISE ve_NegativeNumberException;
    END IF;
  
    dbms_output.put_line(cs_OUTPUT_SUCCESS_PREFIX ||
                         'What is the first number? ' || pin_FirstNumber);
    dbms_output.put_line(cs_OUTPUT_SUCCESS_PREFIX ||
                         'What is the second number? ' || pin_SecondNumber);
  
    -- Output calculations
    dbms_output.put_line(cs_PROGRAM_OUTPUT || pin_FirstNumber || ' + ' ||
                         pin_SecondNumber || ' = ' ||
                         (pin_FirstNumber + pin_SecondNumber));
    dbms_output.put_line(cs_PROGRAM_OUTPUT || pin_FirstNumber || ' - ' ||
                         pin_SecondNumber || ' = ' ||
                         (pin_FirstNumber - pin_SecondNumber));
    dbms_output.put_line(cs_PROGRAM_OUTPUT || pin_FirstNumber || ' * ' ||
                         pin_SecondNumber || ' = ' ||
                         (pin_FirstNumber * pin_SecondNumber));
    dbms_output.put_line(cs_PROGRAM_OUTPUT || pin_FirstNumber || ' / ' ||
                         pin_SecondNumber || ' = ' ||
                         (pin_FirstNumber / pin_SecondNumber));
  
    -- logging  
    AddWAExecutionLog('EFD.SimpleMath', vd_LastExecutionDate, SYSDATE, 'S', 'SimpleMath, Run successfully!');
  EXCEPTION
    WHEN ve_NegativeNumberException THEN
      vs_ErrorMessage := SUBSTR('SimpleMath ERROR :  ' ||
                                ' must enter only positive numbers! ' ||
                                SQLERRM ||
                                DBMS_UTILITY.format_error_backtrace, 1, 3000);
      AddWAExecutionLog('EFD.SimpleMath', vd_LastExecutionDate, SYSDATE, 'F', vs_ErrorMessage);
    WHEN OTHERS THEN
      vs_ErrorMessage := SUBSTR('SimpleMath ERROR :  ' || SQLERRM ||
                                DBMS_UTILITY.format_error_backtrace, 1, 3000);
      AddWAExecutionLog('EFD.SimpleMath', vd_LastExecutionDate, SYSDATE, 'F', vs_ErrorMessage);
  END SimpleMath;

  PROCEDURE RetirementCalculator
  (
    pin_UserAge       IN NUMBER,
    pin_RetirementAge IN NUMBER
  )
  /**************************************************************************************
    * Purpose    : Create a program that determines how many years you have left until retirement and the year you can retire.
    * Notes      : Don’t hard-code the current year into your program. Get it from the system time
                   Handle situations where the program returns a negative number by stating that the user can already retire.
    * -------------------------------------------------------------------------------------
    * Parameters : 
     - pin_UserAge  : User age in curretn year.
     - pin_RetirementAge : The age that user can legally retire.
    * Return     : N/A
    * Exceptions : N/A
    * -------------------------------------------------------------------------------------
    * History    :        
    | Author         | Date                 | Purpose
    |-------         |-----------           |-----------------------------------
    | Ercan DUMAN    | 21-JUN-2018          | Procedure creation.
    **************************************************************************************/
   IS
    vd_LastExecutionDate DATE;
    vs_ErrorMessage      VARCHAR2(3000);
    ve_NegativeNumberException EXCEPTION;
    vn_RemainingYears NUMBER;
  BEGIN
    vd_LastExecutionDate := SYSDATE;
  
    IF pin_UserAge < 0
       OR pin_RetirementAge < 0 THEN
      RAISE ve_NegativeNumberException;
    END IF;
  
    IF pin_UserAge > pin_RetirementAge THEN
      vn_RemainingYears := pin_RetirementAge - pin_UserAge;
      dbms_output.put_line(cs_OUTPUT_SUCCESS_PREFIX ||
                           'What is your current age? ' || pin_UserAge);
      dbms_output.put_line(cs_OUTPUT_SUCCESS_PREFIX ||
                           'At what age would you like to retire? ' ||
                           pin_RetirementAge);
      -- Outputs
      dbms_output.put_line(cs_PROGRAM_OUTPUT ||
                           'Congrats! You already retired ' ||
                           ABS(vn_RemainingYears) || ' years ago.');
      dbms_output.put_line(cs_PROGRAM_OUTPUT || 'It''s ' ||
                           to_char(SYSDATE, 'YYYY') ||
                           ', so you retired in ' ||
                           (to_char(SYSDATE, 'YYYY') + vn_RemainingYears) || '!');
    ELSE
      vn_RemainingYears := pin_RetirementAge - pin_UserAge;
      dbms_output.put_line(cs_OUTPUT_SUCCESS_PREFIX ||
                           'What is your current age? ' || pin_UserAge);
      dbms_output.put_line(cs_OUTPUT_SUCCESS_PREFIX ||
                           'At what age would you like to retire? ' ||
                           pin_RetirementAge);
    
      dbms_output.put_line(cs_PROGRAM_OUTPUT || 'You have ' ||
                           vn_RemainingYears ||
                           ' years left until you can retire. ');
      dbms_output.put_line(cs_PROGRAM_OUTPUT || 'It''s ' ||
                           to_char(SYSDATE, 'YYYY') ||
                           ' , so you can retire in ' ||
                           (to_char(SYSDATE, 'YYYY') + vn_RemainingYears));
    END IF;
    AddWAExecutionLog('EFD.RetirementCalculator', vd_LastExecutionDate, SYSDATE, 'S', 'RetirementCalculator, Run successfully!');
  EXCEPTION
    WHEN ve_NegativeNumberException THEN
      vs_ErrorMessage := SUBSTR('RetirementCalculator ERROR :  ' ||
                                'Age cannot be negative! Should enter only positive numbers! ' ||
                                SQLERRM ||
                                DBMS_UTILITY.format_error_backtrace, 1, 3000);
      AddWAExecutionLog('EFD.RetirementCalculator', vd_LastExecutionDate, SYSDATE, 'F', vs_ErrorMessage);
    WHEN OTHERS THEN
      vs_ErrorMessage := SUBSTR('RetirementCalculator ERROR :  ' || SQLERRM ||
                                DBMS_UTILITY.format_error_backtrace, 1, 3000);
      AddWAExecutionLog('EFD.RetirementCalculator', vd_LastExecutionDate, SYSDATE, 'F', vs_ErrorMessage);
  END RetirementCalculator;

END EFD;
/

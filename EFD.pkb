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

  PROCEDURE SayingHello(pis_Name IN VARCHAR2) IS
  BEGIN
    dbms_output.put_line(cs_OUTPUT_SUCCESS_PREFIX || 'Hello, ' || pis_Name ||
                         ' nice to meet you!');
  END SayingHello;

  PROCEDURE CountingTheNumberOfCharacters(pis_InputSring VARCHAR2) IS
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
    dbms_output.put_line(cs_OUTPUT_SUCCESS_PREFIX || pis_InputSring ||
                         ' has ' || vn_InputStringLentgh || ' characters!');
  EXCEPTION
    WHEN ve_EmptyInputException THEN
      dbms_output.put_line(cs_OUTPUT_FAILURE_PREFIX ||
                           ' must enter something into the program!');
  END CountingTheNumberOfCharacters;

  PROCEDURE PrintingQuotes
  (
    pis_Quote  IN VARCHAR2,
    pis_Author IN VARCHAR2
  ) IS
  BEGIN
                         pis_Quote);
                         pis_Author);
  END PrintingQuotes;
END EFD;
/

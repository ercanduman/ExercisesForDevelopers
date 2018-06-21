CREATE OR REPLACE PACKAGE EDUMAN.EFD
/**************************************************************************************
  * Purpose    : The solution of all challenges of "Exercises for Programmers" book  written by "Brian P. Hogan".
                 (57 Challenges to Develop Your Coding Skills)
  * Notes      : EFD: Exercises For Developers
                 All codes written in Oracle database language PLSQL on XE local database. 
  * -------------------------------------------------------------------------------------
  * History    :        
   | Author         | Date                 | Purpose
   |-------         |-----------           |-----------------------------------
   | Ercan DUMAN    | 25.01.2018           | Package creation.
  **************************************************************************************/
 IS
  PROCEDURE SayingHello(pis_Name IN VARCHAR2);
  PROCEDURE CountingTheNumberOfCharacters(pis_InputSring VARCHAR2);
  PROCEDURE PrintingQuotes
  (
    pis_Quote  IN VARCHAR2,
    pis_Author IN VARCHAR2
  );
END EFD;
/

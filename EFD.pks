CREATE OR REPLACE PACKAGE EDUMAN.EFD
/**************************************************************************************
Change History:
 When                 Who                         What
 25.Jan.2018          Ercan DUMAN                 1.0: The solution for the challenges of "Exercises for Programmers" book  written by "Brian P. Hogan". (57 Challenges to Develop Your Coding Skills)
                                                       EFD: Exercises For Developers. All codes written in Oracle database language PLSQL on XE local database.  When                 Who                         What
    **************************************************************************************/
 IS
  PROCEDURE SayingHello(pis_Name IN VARCHAR2);
  PROCEDURE CountingTheNumberOfCharacters(pis_InputSring VARCHAR2);
  PROCEDURE PrintingQuotes
  (
    pis_Quote  IN VARCHAR2,
    pis_Author IN VARCHAR2
  );
  PROCEDURE SimpleMath
  (
    pin_FirstNumber  IN NUMBER,
    pin_SecondNumber IN NUMBER
  );
  PROCEDURE RetirementCalculator
  (
    pin_UserAge       IN NUMBER,
    pin_RetirementAge IN NUMBER
  );
  PROCEDURE AreaOfARectangularRoom
  (
    pin_Length IN NUMBER,
    pin_Width  IN NUMBER
  );
END EFD;
/

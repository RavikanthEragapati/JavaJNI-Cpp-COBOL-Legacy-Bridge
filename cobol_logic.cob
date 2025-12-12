       IDENTIFICATION DIVISION.
       PROGRAM-ID. COBOL-BUSINESS-LOGIC.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01  WS-TOTAL-EXECUTIONS    PIC S9(8) COMP-5 
                                  IS EXTERNAL
                                  VALUE 0.
       01  WS-EVEN-COUNT          PIC S9(8) COMP-5 
                                  IS EXTERNAL
                                  VALUE 0.
       01  WS-ODD-COUNT           PIC S9(8) COMP-5 
                                  IS EXTERNAL
                                  VALUE 0.
       01  WS-REMAINDER           PIC 9(1).
       01  WS-DIVISOR             PIC 9(3) VALUE 100.
       01  WS-DIVIDED-RESULT      PIC S9(8) COMP-5.
       LINKAGE SECTION.
      * ----------------------------------------------------
      * 1. Define the pointer passed from C++
      * ----------------------------------------------------
       01  LS-INPUT-PTR           USAGE IS POINTER.



      * ----------------------------------------------------
      * NOTE: The PROCEDURE DIVISION must use the name of the 
      * pointer (LS-INPUT-PTR) as its argument.
      * ----------------------------------------------------
       PROCEDURE DIVISION USING LS-INPUT-PTR.
      
           DISPLAY "[COBOL] Entered COBOL logic."

      * 1. Increment the total execution counter
           ADD 1 TO WS-TOTAL-EXECUTIONS.

      * 2. Determine if the current execution number is Even or Odd
           DIVIDE 2 INTO WS-TOTAL-EXECUTIONS GIVING WS-DIVIDED-RESULT
                                             REMAINDER WS-REMAINDER.

           IF WS-REMAINDER IS ZERO 
             ADD 1 TO WS-EVEN-COUNT
             DISPLAY "[COBOL] Execution:" WS-TOTAL-EXECUTIONS " (EVEN)"
           ELSE
             ADD 1 TO WS-ODD-COUNT
             DISPLAY "[COBOL] Execution:" WS-TOTAL-EXECUTIONS " (ODD)"
           END-IF.

      * 3. Check for the 100th loop interval (Modulo 100 check)
           DIVIDE WS-DIVISOR INTO WS-TOTAL-EXECUTIONS 
                         GIVING WS-DIVIDED-RESULT
                             REMAINDER WS-REMAINDER.

           IF WS-REMAINDER IS ZERO 
              PERFORM WRITE-STATS-REPORT
           END-IF.

           GOBACK.

       WRITE-STATS-REPORT SECTION.
           DISPLAY "---------------------------------------------------"
           DISPLAY "--- STATS REPORT @ LOOP " WS-TOTAL-EXECUTIONS " ---"
           DISPLAY "---------------------------------------------------"
           DISPLAY "Total COBOL Calls: " WS-TOTAL-EXECUTIONS
           DISPLAY "Total EVEN Counts: " WS-EVEN-COUNT
           DISPLAY "Total ODD Counts:  " WS-ODD-COUNT
           DISPLAY "---------------------------------------------------"
           .

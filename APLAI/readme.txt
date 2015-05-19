###############################################################################
#                       ReadMe APLAI assignment                               #
###############################################################################

This file contains information about how to run the different programs to solve 
the sudoku problem and the battleships problem with CHR and Eclipse.

    # Sudoku
------------------------------------------

* To solve sudoku puzzles with eclipse load the files 'sudex_toledo.pl' and 'sudoku.pl'
  in TkEclipse.
  Viewpoint 1: run by using 'solve(PuzzleId,Search)'.
  Viewpoint 2: run by using 'solve_2(PuzzleId,Search)'.
  Channeling : run by using 'channeling(PuzzleId,Search)'.

  Search can be : naive, first_fail, middle_out, moff or moff_mo.

* To solve sudoku puzzles with CHR load the file 'sudex_toledo.pl' in a SWIPL environment.
  Viewpoint 1: load 'sudokuCHR.pl' and run 'solve(PuzzleId)'.
  Viewpoint 2: load 'sudokuCHR2.pl' and run 'solve(PuzzleId)'.
  Channeling : load 'sudokuCHR3.pl' and run 'solve(PuzzleId)'. 

    # Battleships
------------------------------------------

* To solve a battleships problem in eclipse load 'battleships.pl' and either
  'problems_toledo_big.pl' or 'problems_toledo_small.pl'.
 
  Solve one puzzle: run 'solve(ProblemId,Search)'.
  Solve all puzzles with one search method: run 'findall(_,solve(_,Search),_)'.
  Find all solutions for a puzzle without the hints: run 'all_solutions(ProblemId,Search)'.
 
* To solve a battleships problem in CHR load 'battleshipsCHR.pl' and either
  'problems_toledo_big.pl' or 'problems_toledo_small.pl'.
  
  Solve one puzzle: run 'solve(ProblemId)'.
  Solve all puzzles: run 'solve_all'.
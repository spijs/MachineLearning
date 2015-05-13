test(0).
test(5).
test(16).
test(20).
test(25).
test(30).
test(35).
test(40).
test(45).
test(50).
test(100).
test(105).
test(110).
test(115).
test(120).
test(125).
test(130).
test(135).
test(140).
test(145).
test(150).
test(155).
test(160).
test(165).
test(170).


%findall(I,(test(I),solve(I,naive)),_).

% 70 Solutions for this problem.
problem( 0, [ (7,10,circle), (1,6,water) ], 
 			[2, 4, 3, 3, 2, 4, 1, 1, 0, 0] , 
 			[0, 5, 0, 2, 2, 3, 1, 3, 2, 2] ).

% 2222 Solutions for this problem.
problem( 1, [ (6,3,circle), (5,7,circle), (6,9,water) ], 
 			[3, 2, 1, 1, 1, 2, 0, 4, 1, 5] , 
 			[2, 1, 5, 3, 2, 1, 2, 0, 4, 0] ).

% 1089 Solutions for this problem.
problem( 2, [ (4,1,circle), (6,5,circle) ], 
 			[1, 2, 4, 3, 1, 4, 3, 1, 1, 0] , 
 			[5, 0, 1, 1, 2, 1, 1, 3, 0, 6] ).

% 5260 Solutions for this problem.
problem( 3, [ (9,10,circle), (1,3,circle) ], 
 			[5, 1, 2, 1, 1, 2, 2, 3, 1, 2] , 
 			[4, 0, 1, 2, 1, 4, 0, 6, 1, 1] ).

% 1707 Solutions for this problem.
problem( 4, [ (5,3,circle), (10,3,circle) ], 
 			[2, 5, 2, 1, 3, 1, 3, 2, 0, 1] , 
 			[4, 0, 4, 1, 0, 3, 1, 3, 2, 2] ).

% 2289 Solutions for this problem.
problem( 5, [ (6,7,circle), (6,10,circle), (8,6,water) ], 
 			[1, 2, 2, 3, 1, 3, 1, 1, 4, 2] , 
 			[1, 6, 1, 2, 0, 2, 1, 2, 0, 5] ).

% 4871 Solutions for this problem.
problem( 6, [ (6,9,circle), (4,3,circle), (8,6,water) ], 
 			[1, 2, 1, 3, 1, 5, 0, 2, 3, 2] , 
 			[3, 1, 2, 1, 2, 4, 1, 4, 1, 1] ).

% 2646 Solutions for this problem.
problem( 7, [ (2,6,circle), (10,1,circle), (3,10,water) ], 
 			[3, 1, 4, 2, 3, 2, 1, 2, 1, 1] , 
 			[3, 1, 3, 2, 0, 2, 3, 0, 5, 1] ).

% 1183 Solutions for this problem.
problem( 8, [ (2,6,circle), (1,3,water) ], 
 			[3, 1, 2, 2, 3, 1, 0, 1, 3, 4] , 
 			[1, 2, 3, 1, 2, 3, 2, 1, 5, 0] ).

% 796 Solutions for this problem.
problem( 9, [ (6,3,circle), (5,9,circle), (2,1,water) ], 
 			[0, 2, 3, 4, 2, 3, 3, 0, 0, 3] , 
 			[2, 2, 2, 1, 4, 0, 4, 1, 3, 1] ).

% 224 Solutions for this problem.
problem( 10, [ (7,8,bottom), (5,3,water), (1,8,water) ], 
 			[3, 4, 1, 1, 2, 2, 2, 2, 1, 2] , 
 			[1, 1, 4, 0, 4, 5, 0, 3, 0, 2] ).

% 606 Solutions for this problem.
problem( 11, [ (4,1,left), (7,4,water) ], 
 			[0, 0, 2, 2, 2, 3, 3, 1, 4, 3] , 
 			[2, 1, 1, 3, 1, 4, 1, 4, 2, 1] ).

% 448 Solutions for this problem.
problem( 12, [ (5,1,middle), (10,5,water) ], 
 			[4, 2, 1, 2, 2, 2, 1, 2, 2, 2] , 
 			[3, 1, 4, 2, 5, 2, 1, 2, 0, 0] ).

% 16 Solutions for this problem.
problem( 13, [ (5,10,water), (2,10,water) ], 
 			[0, 3, 2, 0, 5, 2, 5, 2, 1, 0] , 
 			[3, 2, 0, 1, 2, 2, 3, 2, 3, 2] ).

% 530 Solutions for this problem.
problem( 14, [ (10,7,circle), (9,4,water) ], 
 			[1, 2, 4, 2, 2, 0, 4, 2, 2, 1] , 
 			[2, 2, 1, 2, 2, 3, 3, 1, 3, 1] ).

% 68 Solutions for this problem.
problem( 16, [ (1,1,circle), (5,7,water) ], 
 			[2, 2, 0, 0, 4, 3, 2, 0, 4, 3] , 
 			[1, 2, 2, 2, 4, 1, 2, 4, 1, 1] ).

% 22 Solutions for this problem.
problem( 18, [ (2,4,water), (5,9,water) ], 
 			[1, 5, 2, 3, 1, 0, 1, 0, 3, 4] , 
 			[1, 5, 0, 2, 3, 3, 1, 1, 4, 0] ).

% 168 Solutions for this problem.
problem( 19, [ (2,8,circle), (3,5,water) ], 
 			[2, 2, 5, 0, 2, 1, 0, 1, 6, 1] , 
 			[2, 4, 2, 1, 2, 4, 1, 2, 1, 1] ).

% 97 Solutions for this problem.
problem( 20, [ (5,8,circle), (9,2,water) ], 
 			[0, 1, 3, 0, 2, 2, 2, 4, 2, 4] , 
 			[3, 3, 1, 5, 1, 1, 2, 3, 1, 0] ).

% 126 Solutions for this problem.
problem( 21, [ (7,2,left), (3,4,water), (9,5,water) ], 
 			[4, 0, 1, 0, 1, 2, 4, 0, 4, 4] , 
 			[2, 3, 2, 3, 2, 3, 1, 1, 3, 0] ).

% 49874 Solutions for this problem.
problem( 22, [ (1,8,circle), (7,5,circle), (8,10,water), (2,3,water) ], 
 			[1, 3, 2, 2, 2, 2, 2, 3, 1, 2] , 
 			[3, 0, 4, 0, 3, 0, 3, 1, 2, 4] ).

% 798 Solutions for this problem.
problem( 23, [ (5,9,circle), (6,5,water) ], 
 			[1, 5, 2, 2, 3, 2, 3, 0, 1, 1] , 
 			[1, 4, 1, 1, 3, 1, 2, 1, 5, 1] ).

% 1559 Solutions for this problem.
problem( 24, [ (2,5,circle), (9,7,circle) ], 
 			[2, 1, 1, 2, 1, 2, 5, 1, 4, 1] , 
 			[6, 0, 2, 1, 3, 1, 2, 0, 5, 0] ).

% 33915 Solutions for this problem.
problem( 25, [ (7,8,circle), (4,2,top), (3,5,circle) ], 
 			[1, 2, 2, 2, 2, 1, 4, 1, 1, 4] , 
 			[1, 2, 2, 1, 2, 2, 1, 4, 1, 4] ).

% 52 Solutions for this problem.
problem( 26, [ (6,9,bottom) ], 
 			[0, 0, 1, 1, 3, 3, 3, 3, 3, 3] , 
 			[1, 3, 0, 5, 0, 5, 2, 0, 4, 0] ).

% 502 Solutions for this problem.
problem( 27, [ (2,7,circle), (6,7,left), (1,1,water) ], 
 			[1, 1, 3, 3, 1, 4, 2, 4, 0, 1] , 
 			[4, 1, 1, 1, 5, 1, 3, 3, 0, 1] ).

% 328 Solutions for this problem.
problem( 28, [ (6,1,circle), (4,1,circle) ], 
 			[1, 2, 2, 3, 4, 3, 3, 1, 0, 1] , 
 			[2, 2, 4, 0, 4, 0, 2, 1, 5, 0] ).

% 2751 Solutions for this problem.
problem( 29, [ (10,1,circle), (6,3,circle), (1,8,water) ], 
 			[1, 1, 0, 6, 2, 2, 1, 2, 2, 3] , 
 			[5, 1, 2, 1, 3, 1, 1, 2, 0, 4] ).

% 202 Solutions for this problem.
problem( 30, [ (10,5,circle) ], 
 			[0, 1, 1, 0, 3, 1, 4, 4, 2, 4] , 
 			[2, 1, 3, 2, 3, 1, 1, 4, 1, 2] ).

% 1480 Solutions for this problem.
problem( 31, [ (4,5,circle), (1,8,circle) ], 
 			[1, 2, 2, 2, 3, 0, 1, 1, 6, 2] , 
 			[7, 0, 2, 1, 3, 0, 2, 2, 1, 2] ).

% 897 Solutions for this problem.
problem( 32, [ (3,6,circle), (2,10,circle), (2,1,water) ], 
 			[4, 2, 3, 4, 2, 0, 0, 1, 1, 3] , 
 			[2, 1, 3, 3, 1, 3, 0, 5, 0, 2] ).

% 6082 Solutions for this problem.
problem( 33, [ (1,10,top), (3,1,circle), (5,3,water), (8,2,water) ], 
 			[1, 3, 3, 1, 2, 1, 1, 4, 1, 3] , 
 			[1, 1, 4, 0, 6, 0, 3, 1, 2, 2] ).

% 632 Solutions for this problem.
problem( 34, [ (5,1,circle), (7,5,water) ], 
 			[0, 1, 2, 4, 3, 2, 4, 1, 1, 2] , 
 			[2, 3, 1, 1, 4, 0, 5, 1, 3, 0] ).

% 2684 Solutions for this problem.
problem( 35, [ (8,1,circle), (8,7,right), (3,4,water), (4,6,water) ], 
 			[1, 0, 3, 1, 1, 2, 2, 4, 1, 5] , 
 			[3, 1, 5, 1, 0, 3, 2, 2, 1, 2] ).

% 7164 Solutions for this problem.
problem( 36, [ (5,1,circle), (6,3,circle), (6,9,water) ], 
 			[2, 2, 3, 4, 1, 2, 3, 2, 1, 0] , 
 			[2, 0, 4, 0, 4, 0, 5, 0, 5, 0] ).

% 136 Solutions for this problem.
problem( 37, [ (10,3,circle), (8,1,top), (6,3,water) ], 
 			[1, 3, 2, 0, 0, 2, 1, 6, 2, 3] , 
 			[4, 0, 3, 2, 2, 0, 0, 4, 0, 5] ).

% 38 Solutions for this problem.
problem( 38, [ (6,4,middle) ], 
 			[2, 2, 1, 1, 2, 5, 0, 0, 5, 2] , 
 			[2, 4, 2, 3, 2, 2, 3, 1, 1, 0] ).

% 1718 Solutions for this problem.
problem( 39, [ (2,8,circle), (6,1,top), (1,4,water) ], 
 			[2, 2, 4, 0, 5, 1, 3, 0, 3, 0] , 
 			[3, 1, 3, 1, 0, 3, 2, 3, 3, 1] ).

% 635 Solutions for this problem.
problem( 40, [ (6,3,circle), (9,10,water), (1,1,water), (1,5,water) ], 
 			[3, 0, 2, 0, 0, 4, 1, 6, 2, 2] , 
 			[4, 1, 2, 0, 2, 1, 3, 2, 1, 4] ).

% 2546 Solutions for this problem.
problem( 43, [ (5,10,circle), (10,7,circle), (3,6,water) ], 
 			[2, 0, 2, 2, 5, 2, 2, 1, 1, 3] , 
 			[3, 2, 1, 0, 0, 4, 1, 4, 0, 5] ).

% 126 Solutions for this problem.
problem( 44, [ (4,3,circle), (10,2,left) ], 
 			[1, 8, 0, 3, 0, 2, 1, 2, 1, 2] , 
 			[3, 3, 3, 2, 1, 4, 1, 1, 0, 2] ).

% 124 Solutions for this problem.
problem( 45, [ (9,10,circle) ], 
 			[1, 1, 1, 2, 5, 1, 4, 4, 1, 0] , 
 			[2, 2, 0, 5, 0, 3, 1, 2, 3, 2] ).

% 1201 Solutions for this problem.
problem( 46, [ (10,7,left), (3,9,top), (1,10,water) ], 
 			[4, 1, 1, 6, 0, 2, 1, 2, 1, 2] , 
 			[1, 1, 5, 2, 3, 2, 1, 2, 2, 1] ).

% 23 Solutions for this problem.
problem( 47, [ (7,4,water) ], 
 			[0, 0, 2, 1, 5, 2, 4, 1, 4, 1] , 
 			[4, 3, 1, 3, 1, 3, 1, 2, 2, 0] ).

% 3984 Solutions for this problem.
problem( 48, [ (8,6,circle), (9,3,circle), (5,8,water) ], 
 			[1, 3, 2, 3, 4, 2, 2, 1, 2, 0] , 
 			[3, 1, 1, 3, 0, 5, 1, 1, 0, 5] ).

% 528 Solutions for this problem.
problem( 49, [ (2,10,circle), (7,3,circle) ], 
 			[1, 1, 1, 2, 4, 1, 4, 3, 2, 1] , 
 			[2, 0, 2, 0, 4, 1, 4, 3, 1, 3] ).

% 608 Solutions for this problem.
problem( 50, [ (8,7,circle), (5,4,water) ], 
 			[1, 1, 0, 2, 4, 2, 3, 3, 3, 1] , 
 			[5, 0, 2, 1, 1, 3, 2, 0, 4, 2] ).

% 2219 Solutions for this problem.
problem( 51, [ (6,7,circle), (4,1,water), (2,1,water) ], 
 			[2, 1, 4, 2, 2, 1, 1, 0, 3, 4] , 
 			[4, 1, 1, 1, 2, 1, 2, 4, 0, 4] ).

% 1030 Solutions for this problem.
problem( 52, [ (1,9,circle), (8,4,water) ], 
 			[3, 3, 0, 1, 1, 1, 0, 5, 1, 5] , 
 			[1, 3, 4, 2, 1, 2, 1, 2, 2, 2] ).

% 2976 Solutions for this problem.
problem( 53, [ (8,9,circle), (8,1,middle), (10,6,water) ], 
 			[3, 0, 1, 1, 2, 3, 1, 4, 2, 3] , 
 			[3, 1, 5, 1, 3, 1, 1, 0, 1, 4] ).

% 3779 Solutions for this problem.
problem( 54, [ (5,1,circle), (9,8,left), (4,3,water) ], 
 			[5, 0, 0, 3, 2, 3, 2, 1, 3, 1] , 
 			[1, 1, 4, 0, 1, 5, 1, 4, 1, 2] ).

% 9257 Solutions for this problem.
problem( 55, [ (8,5,circle), (2,7,circle), (3,3,top), (10,8,water) ], 
 			[0, 3, 3, 3, 1, 2, 3, 2, 1, 2] , 
 			[6, 0, 4, 0, 3, 0, 1, 2, 0, 4] ).

% 870 Solutions for this problem.
problem( 56, [ (10,7,circle), (6,1,circle), (6,7,water) ], 
 			[6, 0, 3, 0, 0, 2, 5, 1, 2, 1] , 
 			[2, 1, 2, 2, 3, 0, 4, 2, 3, 1] ).

% 1681 Solutions for this problem.
problem( 57, [ (10,9,circle), (10,1,circle), (5,4,water) ], 
 			[4, 3, 2, 2, 1, 1, 1, 2, 2, 2] , 
 			[1, 3, 0, 2, 3, 1, 2, 4, 3, 1] ).

% 1009 Solutions for this problem.
problem( 58, [ (5,10,middle), (1,1,water) ], 
 			[3, 5, 1, 1, 1, 1, 1, 1, 4, 2] , 
 			[3, 2, 2, 1, 0, 2, 1, 4, 1, 4] ).

% 581 Solutions for this problem.
problem( 59, [ (3,7,circle), (5,7,water) ], 
 			[2, 0, 5, 1, 1, 3, 2, 2, 3, 1] , 
 			[1, 5, 1, 1, 2, 1, 4, 3, 2, 0] ).

% 143 Solutions for this problem.
problem( 60, [ (6,7,circle), (2,9,water) ], 
 			[0, 2, 6, 0, 0, 3, 3, 1, 3, 2] , 
 			[2, 2, 2, 3, 1, 1, 2, 1, 3, 3] ).

% 1563 Solutions for this problem.
problem( 63, [ (2,5,circle), (5,9,circle), (1,1,water) ], 
 			[1, 2, 4, 1, 5, 1, 0, 4, 2, 0] , 
 			[3, 1, 3, 2, 2, 1, 3, 0, 4, 1] ).

% 3025 Solutions for this problem.
problem( 64, [ (8,4,circle), (6,10,circle) ], 
 			[6, 1, 1, 0, 2, 2, 1, 1, 4, 2] , 
 			[2, 1, 2, 2, 1, 4, 1, 4, 1, 2] ).

% 544 Solutions for this problem.
problem( 65, [ (7,3,circle), (4,7,bottom), (7,1,water), (1,5,water) ], 
 			[2, 2, 3, 2, 3, 0, 4, 2, 0, 2] , 
 			[2, 0, 2, 0, 3, 1, 5, 1, 4, 2] ).

% 600 Solutions for this problem.
problem( 66, [ (10,7,circle), (9,3,circle) ], 
 			[3, 1, 2, 1, 1, 2, 2, 2, 2, 4] , 
 			[4, 0, 1, 0, 1, 1, 6, 1, 6, 0] ).

% 3952 Solutions for this problem.
problem( 69, [ (1,2,right), (10,3,circle) ], 
 			[3, 0, 0, 1, 3, 0, 5, 1, 2, 5] , 
 			[2, 1, 3, 2, 2, 3, 2, 2, 2, 1] ).

% 11994 Solutions for this problem.
problem( 71, [ (6,3,circle), (3,4,circle), (2,8,water) ], 
 			[0, 2, 1, 2, 4, 1, 2, 2, 1, 5] , 
 			[4, 0, 1, 2, 1, 3, 2, 2, 1, 4] ).

% 371 Solutions for this problem.
problem( 72, [ (3,6,circle) ], 
 			[1, 0, 1, 5, 1, 4, 3, 3, 1, 1] , 
 			[1, 4, 1, 2, 1, 2, 3, 1, 4, 1] ).

% 425 Solutions for this problem.
problem( 73, [ (3,4,circle), (1,7,circle), (4,10,water) ], 
 			[2, 0, 1, 3, 2, 5, 1, 0, 1, 5] , 
 			[1, 2, 3, 3, 2, 0, 5, 0, 2, 2] ).

% 468 Solutions for this problem.
problem( 74, [ (3,8,middle), (1,4,water) ], 
 			[4, 1, 4, 0, 6, 0, 1, 1, 1, 2] , 
 			[4, 0, 1, 2, 1, 1, 2, 3, 1, 5] ).

% 1202 Solutions for this problem.
problem( 75, [ (9,10,circle), (1,3,circle), (4,6,water) ], 
 			[1, 0, 2, 2, 3, 1, 5, 2, 3, 1] , 
 			[5, 0, 4, 0, 0, 4, 0, 2, 4, 1] ).

% 773 Solutions for this problem.
problem( 76, [ (6,10,circle), (5,4,water), (7,6,water) ], 
 			[5, 1, 5, 1, 3, 1, 2, 0, 1, 1] , 
 			[1, 3, 1, 5, 1, 3, 1, 1, 3, 1] ).

% 1336 Solutions for this problem.
problem( 77, [ (8,5,circle), (7,1,water), (3,7,water) ], 
 			[6, 0, 4, 0, 0, 4, 2, 2, 1, 1] , 
 			[2, 0, 2, 2, 3, 4, 1, 3, 1, 2] ).

% 927 Solutions for this problem.
problem( 78, [ (1,4,circle), (8,10,circle), (10,7,water) ], 
 			[4, 2, 2, 1, 4, 2, 1, 2, 0, 2] , 
 			[3, 0, 5, 1, 0, 3, 3, 1, 2, 2] ).

% 20 Solutions for this problem.
problem( 79, [ (4,10,middle), (6,8,water) ], 
 			[3, 0, 1, 2, 3, 3, 3, 3, 1, 1] , 
 			[1, 0, 1, 2, 3, 2, 4, 1, 0, 6] ).

% 2735 Solutions for this problem.
problem( 80, [ (9,3,circle), (2,4,circle), (1,7,water) ], 
 			[2, 3, 0, 3, 0, 0, 5, 0, 5, 2] , 
 			[3, 1, 1, 2, 2, 1, 2, 3, 2, 3] ).

% 10882 Solutions for this problem.
problem( 81, [ (5,3,circle), (7,4,circle), (4,8,middle) ], 
 			[1, 1, 4, 2, 3, 2, 3, 2, 1, 1] , 
 			[1, 2, 1, 4, 1, 1, 0, 5, 0, 5] ).

% 746 Solutions for this problem.
problem( 82, [ (2,2,left), (1,7,water), (8,3,water) ], 
 			[1, 5, 1, 2, 0, 1, 1, 2, 6, 1] , 
 			[5, 1, 3, 1, 2, 1, 2, 2, 2, 1] ).

% 1105 Solutions for this problem.
problem( 83, [ (8,5,circle), (4,1,top), (1,7,water) ], 
 			[1, 0, 4, 1, 4, 0, 0, 5, 1, 4] , 
 			[4, 0, 1, 2, 2, 1, 4, 2, 1, 3] ).

% 138 Solutions for this problem.
problem( 84, [ (3,1,circle), (5,6,water) ], 
 			[2, 0, 1, 4, 1, 4, 0, 6, 1, 1] , 
 			[4, 2, 0, 2, 1, 3, 1, 2, 1, 4] ).

% 65 Solutions for this problem.
problem( 85, [ (9,1,circle), (4,6,water) ], 
 			[1, 7, 0, 3, 2, 0, 0, 2, 5, 0] , 
 			[2, 2, 1, 2, 3, 2, 2, 1, 4, 1] ).

% 760 Solutions for this problem.
problem( 86, [ (3,9,circle), (7,1,circle), (1,4,water) ], 
 			[2, 1, 2, 2, 2, 4, 2, 1, 2, 2] , 
 			[1, 0, 3, 2, 3, 4, 1, 4, 1, 1] ).

% 1856 Solutions for this problem.
problem( 87, [ (1,7,left), (10,8,water) ], 
 			[3, 3, 2, 1, 2, 1, 1, 1, 2, 4] , 
 			[1, 0, 3, 0, 5, 2, 1, 3, 0, 5] ).

% 1263 Solutions for this problem.
problem( 88, [ (9,3,circle), (2,5,circle) ], 
 			[1, 3, 3, 2, 3, 4, 1, 1, 1, 1] , 
 			[5, 0, 3, 0, 3, 1, 1, 0, 3, 4] ).

% 440 Solutions for this problem.
problem( 89, [ (8,5,bottom), (4,5,water), (8,1,water) ], 
 			[2, 3, 2, 3, 3, 1, 1, 3, 2, 0] , 
 			[3, 0, 0, 0, 6, 0, 6, 0, 2, 3] ).

% 1064 Solutions for this problem.
problem( 90, [ (10,4,circle), (4,1,circle) ], 
 			[2, 0, 2, 4, 1, 3, 1, 2, 4, 1] , 
 			[2, 0, 0, 4, 1, 4, 1, 2, 1, 5] ).

% 679 Solutions for this problem.
problem( 91, [ (6,9,circle), (4,1,circle) ], 
 			[1, 1, 0, 3, 3, 2, 4, 0, 5, 1] , 
 			[1, 1, 3, 2, 4, 0, 4, 1, 1, 3] ).

% 647 Solutions for this problem.
problem( 92, [ (9,1,top), (7,8,water) ], 
 			[1, 3, 1, 2, 2, 2, 2, 3, 2, 2] , 
 			[2, 0, 2, 5, 1, 6, 0, 3, 1, 0] ).

% 324 Solutions for this problem.
problem( 93, [ (6,10,circle) ], 
 			[1, 0, 5, 2, 4, 2, 1, 0, 4, 1] , 
 			[0, 3, 1, 4, 1, 5, 1, 2, 0, 3] ).

% 27 Solutions for this problem.
problem( 94, [ (4,6,circle) ], 
 			[1, 5, 1, 3, 0, 2, 1, 1, 5, 1] , 
 			[3, 4, 0, 2, 1, 2, 0, 6, 1, 1] ).

% 27 Solutions for this problem.
problem( 95, [ (5,1,top), (7,9,water) ], 
 			[0, 4, 5, 2, 2, 1, 2, 1, 1, 2] , 
 			[5, 2, 1, 1, 1, 1, 1, 4, 2, 2] ).

% 720 Solutions for this problem.
problem( 96, [ (6,1,circle), (2,5,left), (6,10,water) ], 
 			[0, 3, 1, 6, 0, 2, 1, 0, 4, 3] , 
 			[1, 2, 3, 1, 2, 2, 2, 1, 3, 3] ).

% 340 Solutions for this problem.
problem( 97, [ (4,9,middle) ], 
 			[3, 0, 0, 3, 1, 6, 1, 5, 1, 0] , 
 			[3, 0, 2, 0, 2, 2, 3, 4, 2, 2] ).

% 4709 Solutions for this problem.
problem( 98, [ (7,4,right), (1,1,circle) ], 
 			[1, 1, 4, 1, 5, 1, 3, 0, 3, 1] , 
 			[2, 1, 1, 1, 4, 2, 2, 2, 3, 2] ).

% 749 Solutions for this problem.
problem( 99, [ (7,1,circle), (8,3,circle) ], 
 			[0, 1, 4, 2, 4, 3, 2, 2, 1, 1] , 
 			[3, 0, 3, 1, 2, 1, 3, 2, 4, 1] ).

% 261 Solutions for this problem.
problem( 100, [ (4,1,bottom), (4,5,water), (9,1,water) ], 
 			[0, 1, 3, 2, 2, 5, 0, 0, 4, 3] , 
 			[3, 1, 3, 1, 4, 2, 2, 2, 1, 1] ).

% 448 Solutions for this problem.
problem( 101, [ (8,1,circle), (5,1,circle), (1,7,water) ], 
 			[1, 1, 4, 2, 3, 2, 2, 1, 3, 1] , 
 			[2, 0, 1, 0, 4, 1, 4, 3, 2, 3] ).

% 7710 Solutions for this problem.
problem( 103, [ (4,9,top), (5,4,circle), (1,3,water) ], 
 			[6, 0, 3, 2, 2, 2, 2, 2, 1, 0] , 
 			[1, 3, 1, 1, 2, 1, 5, 1, 2, 3] ).

% 360 Solutions for this problem.
problem( 104, [ (8,1,circle), (1,10,water) ], 
 			[1, 0, 1, 4, 1, 4, 2, 2, 1, 4] , 
 			[3, 0, 1, 0, 3, 1, 1, 4, 1, 6] ).

% 81 Solutions for this problem.
problem( 105, [ (5,1,circle), (1,10,water) ], 
 			[1, 1, 4, 2, 3, 1, 3, 3, 2, 0] , 
 			[2, 2, 0, 2, 1, 1, 1, 4, 3, 4] ).

% 1788 Solutions for this problem.
problem( 106, [ (2,7,circle), (1,2,water) ], 
 			[2, 1, 1, 4, 1, 1, 1, 2, 4, 3] , 
 			[2, 4, 2, 0, 3, 1, 1, 2, 0, 5] ).

% 323 Solutions for this problem.
problem( 107, [ (6,1,circle), (7,5,circle), (9,2,water) ], 
 			[4, 3, 1, 7, 1, 1, 1, 0, 1, 1] , 
 			[3, 2, 2, 2, 2, 1, 2, 3, 1, 2] ).

% 50 Solutions for this problem.
problem( 108, [ (2,5,circle), (6,7,water) ], 
 			[1, 2, 0, 1, 1, 1, 3, 4, 4, 3] , 
 			[1, 2, 2, 1, 3, 0, 4, 3, 3, 1] ).

% 3866 Solutions for this problem.
problem( 109, [ (7,1,circle), (1,7,circle), (2,5,circle) ], 
 			[1, 3, 1, 0, 4, 1, 2, 3, 4, 1] , 
 			[1, 2, 2, 2, 2, 2, 3, 1, 1, 4] ).

% 33 Solutions for this problem.
problem( 110, [ (6,5,left) ], 
 			[6, 0, 0, 1, 1, 3, 0, 1, 6, 2] , 
 			[3, 4, 0, 2, 2, 3, 1, 1, 3, 1] ).

% 1507 Solutions for this problem.
problem( 111, [ (9,5,circle), (6,1,water), (2,3,water) ], 
 			[0, 1, 1, 1, 3, 4, 3, 3, 3, 1] , 
 			[4, 0, 3, 1, 4, 1, 3, 1, 2, 1] ).

% 1831 Solutions for this problem.
problem( 113, [ (5,9,circle), (9,5,circle), (3,8,water) ], 
 			[7, 1, 1, 0, 3, 2, 2, 1, 2, 1] , 
 			[1, 4, 1, 2, 2, 1, 3, 2, 2, 2] ).

% 100 Solutions for this problem.
problem( 114, [ (7,6,right), (8,2,water) ], 
 			[2, 0, 1, 6, 0, 0, 3, 2, 5, 1] , 
 			[2, 1, 1, 1, 2, 3, 3, 2, 3, 2] ).

% 285 Solutions for this problem.
problem( 115, [ (1,10,circle), (3,2,water) ], 
 			[1, 1, 5, 1, 2, 1, 5, 3, 0, 1] , 
 			[2, 4, 0, 4, 2, 2, 1, 2, 1, 2] ).

% 28 Solutions for this problem.
problem( 116, [ (5,3,right), (2,7,water) ], 
 			[0, 1, 1, 0, 3, 4, 1, 4, 3, 3] , 
 			[0, 2, 3, 1, 2, 3, 1, 4, 2, 2] ).

% 3188 Solutions for this problem.
problem( 117, [ (9,3,circle), (4,1,circle), (1,8,water) ], 
 			[1, 4, 1, 2, 1, 2, 2, 2, 5, 0] , 
 			[3, 1, 3, 1, 1, 0, 1, 5, 1, 4] ).

% 6304 Solutions for this problem.
problem( 119, [ (9,8,middle), (5,1,water), (1,10,water) ], 
 			[4, 0, 0, 1, 2, 4, 2, 3, 3, 1] , 
 			[4, 1, 3, 1, 2, 1, 2, 2, 1, 3] ).

% 257 Solutions for this problem.
problem( 120, [ (1,3,circle), (6,5,water) ], 
 			[2, 0, 0, 1, 1, 2, 5, 3, 4, 2] , 
 			[4, 1, 2, 0, 4, 0, 4, 0, 5, 0] ).

% 2462 Solutions for this problem.
problem( 121, [ (2,3,circle), (3,1,top), (4,10,water) ], 
 			[1, 2, 1, 3, 3, 2, 2, 4, 1, 1] , 
 			[5, 0, 3, 0, 3, 3, 2, 0, 2, 2] ).

% 2094 Solutions for this problem.
problem( 122, [ (5,3,circle), (8,5,circle) ], 
 			[2, 0, 1, 3, 2, 4, 1, 3, 2, 2] , 
 			[6, 0, 3, 0, 4, 1, 1, 1, 4, 0] ).

% 15256 Solutions for this problem.
problem( 123, [ (2,3,left), (7,8,circle), (5,10,water), (1,1,water) ], 
 			[2, 3, 3, 2, 1, 1, 2, 2, 1, 3] , 
 			[1, 0, 1, 4, 0, 5, 0, 5, 0, 4] ).

% 5594 Solutions for this problem.
problem( 124, [ (10,6,circle), (5,7,water), (5,3,water) ], 
 			[2, 1, 4, 0, 4, 1, 4, 1, 2, 1] , 
 			[4, 1, 1, 0, 2, 2, 3, 2, 0, 5] ).

% 464 Solutions for this problem.
problem( 125, [ (7,1,circle), (7,7,circle), (3,5,water) ], 
 			[0, 3, 3, 4, 2, 0, 2, 0, 1, 5] , 
 			[3, 1, 5, 1, 3, 0, 3, 0, 4, 0] ).

% 10152 Solutions for this problem.
problem( 126, [ (7,10,circle), (5,5,circle), (6,8,water), (2,1,water) ], 
 			[0, 5, 2, 1, 3, 2, 1, 2, 1, 3] , 
 			[4, 0, 2, 1, 2, 2, 1, 4, 0, 4] ).

% 1491 Solutions for this problem.
problem( 127, [ (8,1,circle), (3,3,circle) ], 
 			[0, 2, 2, 1, 1, 2, 4, 3, 1, 4] , 
 			[5, 1, 3, 1, 0, 2, 2, 1, 4, 1] ).

% 921 Solutions for this problem.
problem( 128, [ (1,2,circle), (3,9,water) ], 
 			[3, 3, 2, 1, 1, 3, 1, 1, 1, 4] , 
 			[5, 1, 0, 1, 0, 1, 4, 2, 4, 2] ).

% 179 Solutions for this problem.
problem( 129, [ (1,2,circle), (4,10,water), (8,10,water) ], 
 			[2, 1, 2, 2, 3, 2, 2, 1, 4, 1] , 
 			[1, 1, 0, 4, 0, 3, 6, 1, 1, 3] ).

% 3970 Solutions for this problem.
problem( 130, [ (3,10,circle), (8,7,circle) ], 
 			[2, 3, 2, 3, 3, 1, 2, 1, 0, 3] , 
 			[1, 5, 1, 1, 4, 0, 5, 0, 2, 1] ).

% 260 Solutions for this problem.
problem( 131, [ (10,6,circle), (2,10,water) ], 
 			[4, 3, 0, 1, 2, 2, 3, 0, 3, 2] , 
 			[5, 1, 2, 3, 1, 1, 2, 0, 1, 4] ).

% 10426 Solutions for this problem.
problem( 132, [ (9,9,circle), (4,1,circle), (8,7,water) ], 
 			[1, 1, 2, 2, 2, 5, 1, 2, 2, 2] , 
 			[4, 0, 1, 2, 1, 1, 2, 3, 1, 5] ).

% 63 Solutions for this problem.
problem( 134, [ (4,6,right), (8,1,water) ], 
 			[1, 1, 2, 5, 2, 2, 5, 1, 1, 0] , 
 			[2, 4, 1, 1, 3, 2, 2, 0, 3, 2] ).

% 4085 Solutions for this problem.
problem( 135, [ (2,2,circle), (5,6,circle), (1,4,water) ], 
 			[2, 2, 2, 3, 1, 0, 1, 2, 3, 4] , 
 			[1, 1, 3, 1, 1, 3, 0, 4, 0, 6] ).

% 9508 Solutions for this problem.
problem( 136, [ (3,10,circle), (7,8,middle), (2,3,water) ], 
 			[2, 3, 1, 3, 2, 2, 2, 1, 3, 1] , 
 			[4, 0, 1, 2, 1, 2, 0, 6, 1, 3] ).

% 1408 Solutions for this problem.
problem( 137, [ (6,7,top), (2,4,water) ], 
 			[2, 2, 3, 3, 4, 1, 2, 1, 1, 1] , 
 			[1, 3, 1, 3, 1, 0, 4, 0, 2, 5] ).

% 2451 Solutions for this problem.
problem( 138, [ (8,9,circle), (7,7,top) ], 
 			[0, 3, 4, 2, 2, 1, 1, 2, 2, 3] , 
 			[4, 0, 2, 2, 1, 0, 5, 0, 4, 2] ).

% 985 Solutions for this problem.
problem( 139, [ (6,5,circle), (7,1,water), (3,3,water) ], 
 			[4, 1, 2, 0, 1, 2, 3, 2, 5, 0] , 
 			[4, 2, 3, 2, 3, 1, 0, 3, 1, 1] ).

% 19151 Solutions for this problem.
problem( 140, [ (3,1,circle), (2,6,circle), (10,7,middle), (8,3,middle) ], 
 			[3, 2, 2, 2, 1, 1, 0, 4, 0, 5] , 
 			[1, 3, 2, 5, 1, 3, 1, 1, 2, 1] ).

% 243 Solutions for this problem.
problem( 141, [ (1,2,circle), (7,10,water) ], 
 			[1, 2, 1, 2, 1, 2, 3, 4, 3, 1] , 
 			[2, 1, 1, 0, 4, 0, 4, 4, 1, 3] ).

% 190 Solutions for this problem.
problem( 142, [ (2,10,circle), (4,1,water), (1,3,water) ], 
 			[1, 2, 2, 5, 3, 2, 2, 1, 1, 1] , 
 			[1, 1, 1, 4, 3, 2, 1, 4, 0, 3] ).

% 428 Solutions for this problem.
problem( 143, [ (7,8,circle), (5,4,circle) ], 
 			[5, 2, 0, 0, 2, 2, 2, 2, 5, 0] , 
 			[3, 1, 2, 2, 0, 5, 0, 3, 1, 3] ).

% 2986 Solutions for this problem.
problem( 144, [ (2,9,circle), (6,3,water), (1,6,water), (8,1,water) ], 
 			[2, 1, 5, 0, 1, 3, 3, 2, 1, 2] , 
 			[4, 0, 3, 1, 2, 1, 5, 0, 4, 0] ).

% 100 Solutions for this problem.
problem( 145, [ (8,9,circle), (6,3,water) ], 
 			[2, 1, 1, 1, 2, 4, 2, 4, 2, 1] , 
 			[3, 0, 1, 2, 1, 3, 5, 1, 4, 0] ).

% 2471 Solutions for this problem.
problem( 146, [ (7,5,circle), (7,10,water) ], 
 			[3, 0, 4, 0, 2, 1, 3, 1, 5, 1] , 
 			[2, 4, 0, 3, 1, 1, 2, 2, 2, 3] ).

% 6157 Solutions for this problem.
problem( 147, [ (4,5,circle), (3,9,water), (8,9,water) ], 
 			[2, 1, 3, 1, 2, 1, 1, 4, 1, 4] , 
 			[4, 0, 0, 4, 3, 1, 2, 3, 2, 1] ).

% 49 Solutions for this problem.
problem( 148, [ (7,5,left), (2,6,water) ], 
 			[0, 1, 2, 0, 4, 0, 4, 2, 4, 3] , 
 			[0, 3, 3, 3, 3, 3, 1, 1, 1, 2] ).

% 521 Solutions for this problem.
problem( 149, [ (10,3,left) ], 
 			[1, 2, 4, 1, 1, 3, 2, 0, 2, 4] , 
 			[4, 0, 4, 1, 0, 3, 2, 4, 1, 1] ).

% 28 Solutions for this problem.
problem( 150, [ (3,9,water) ], 
 			[4, 2, 1, 4, 1, 1, 3, 4, 0, 0] , 
 			[3, 2, 3, 3, 0, 3, 0, 2, 4, 0] ).

% 2439 Solutions for this problem.
problem( 151, [ (7,1,circle), (4,10,top), (6,8,water) ], 
 			[4, 0, 1, 3, 2, 2, 1, 1, 6, 0] , 
 			[3, 1, 2, 1, 4, 0, 3, 2, 1, 3] ).

% 12568 Solutions for this problem.
problem( 152, [ (6,2,circle), (8,5,left), (3,1,water), (6,8,water) ], 
 			[4, 1, 5, 1, 1, 3, 0, 2, 2, 1] , 
 			[2, 2, 3, 2, 2, 2, 1, 1, 4, 1] ).

% 218 Solutions for this problem.
problem( 153, [ (7,8,circle), (2,6,water) ], 
 			[2, 2, 5, 1, 5, 1, 2, 1, 0, 1] , 
 			[6, 1, 0, 2, 1, 3, 1, 1, 2, 3] ).

% 244 Solutions for this problem.
problem( 154, [ (5,1,circle), (9,5,circle) ], 
 			[0, 6, 2, 2, 3, 0, 6, 0, 1, 0] , 
 			[2, 1, 3, 2, 2, 1, 2, 3, 0, 4] ).

% 413 Solutions for this problem.
problem( 155, [ (10,8,circle), (8,3,circle), (2,7,water) ], 
 			[0, 3, 0, 6, 1, 5, 1, 3, 0, 1] , 
 			[4, 0, 3, 2, 1, 4, 1, 2, 2, 1] ).

% 5125 Solutions for this problem.
problem( 156, [ (2,5,circle), (8,1,circle), (3,2,water) ], 
 			[2, 2, 2, 2, 1, 2, 3, 2, 0, 4] , 
 			[1, 2, 2, 1, 3, 3, 1, 1, 2, 4] ).

% 1842 Solutions for this problem.
problem( 157, [ (5,8,circle), (2,1,circle) ], 
 			[3, 3, 2, 0, 5, 0, 1, 1, 0, 5] , 
 			[3, 1, 1, 3, 1, 5, 1, 1, 3, 1] ).

% 20 Solutions for this problem.
problem( 158, [ (3,2,water) ], 
 			[2, 0, 1, 2, 1, 2, 4, 0, 6, 2] , 
 			[3, 4, 3, 3, 1, 1, 1, 2, 1, 1] ).

% 17522 Solutions for this problem.
problem( 159, [ (2,4,circle), (7,1,circle), (5,9,middle), (5,3,water) ], 
 			[1, 2, 2, 0, 4, 1, 1, 3, 1, 5] , 
 			[2, 1, 1, 1, 3, 2, 2, 2, 1, 5] ).

% 369 Solutions for this problem.
problem( 160, [ (2,4,circle), (9,6,bottom) ], 
 			[1, 2, 1, 1, 4, 1, 1, 4, 2, 3] , 
 			[0, 3, 0, 4, 0, 3, 0, 3, 1, 6] ).

% 1470 Solutions for this problem.
problem( 162, [ (3,1,circle), (9,1,circle) ], 
 			[2, 4, 2, 3, 1, 2, 2, 1, 3, 0] , 
 			[4, 0, 1, 1, 1, 5, 1, 1, 5, 1] ).

% 304 Solutions for this problem.
problem( 163, [ (6,3,middle), (1,7,water) ], 
 			[2, 1, 3, 2, 1, 1, 2, 1, 4, 3] , 
 			[0, 0, 5, 1, 4, 2, 3, 2, 1, 2] ).

% 1843 Solutions for this problem.
problem( 164, [ (10,6,circle), (3,3,circle), (3,8,water) ], 
 			[6, 0, 3, 2, 1, 0, 1, 3, 0, 4] , 
 			[3, 0, 2, 3, 2, 3, 1, 2, 1, 3] ).

% 3404 Solutions for this problem.
problem( 165, [ (1,3,circle), (9,8,circle), (4,1,water) ], 
 			[5, 2, 1, 2, 0, 6, 1, 1, 1, 1] , 
 			[4, 1, 1, 2, 1, 2, 2, 2, 0, 5] ).

% 117 Solutions for this problem.
problem( 166, [ (9,10,circle), (6,8,water) ], 
 			[1, 1, 0, 4, 3, 3, 1, 2, 4, 1] , 
 			[1, 0, 4, 3, 2, 1, 0, 5, 1, 3] ).

% 2399 Solutions for this problem.
problem( 167, [ (4,6,circle), (6,7,circle), (2,1,water) ], 
 			[1, 4, 1, 4, 2, 2, 1, 2, 0, 3] , 
 			[1, 5, 1, 2, 1, 1, 1, 2, 4, 2] ).

% 613 Solutions for this problem.
problem( 168, [ (4,7,circle), (4,3,circle), (1,1,water) ], 
 			[2, 5, 2, 2, 1, 1, 0, 2, 1, 4] , 
 			[2, 1, 2, 3, 3, 1, 2, 3, 2, 1] ).

% 1040 Solutions for this problem.
problem( 169, [ (6,1,circle), (4,7,water) ], 
 			[0, 4, 1, 3, 1, 4, 3, 3, 1, 0] , 
 			[4, 1, 2, 3, 2, 0, 3, 1, 1, 3] ).

% 158 Solutions for this problem.
problem( 170, [ (1,10,circle), (3,8,water) ], 
 			[2, 1, 1, 1, 1, 3, 3, 2, 5, 1] , 
 			[1, 1, 1, 4, 1, 2, 3, 3, 3, 1] ).

% 22104 Solutions for this problem.
problem( 171, [ (7,3,circle), (6,1,circle), (6,6,bottom), (4,8,water) ], 
 			[0, 0, 1, 2, 3, 3, 3, 3, 2, 3] , 
 			[3, 1, 1, 3, 0, 4, 0, 4, 0, 4] ).

% 481 Solutions for this problem.
problem( 172, [ (8,3,circle) ], 
 			[2, 1, 2, 5, 1, 3, 3, 1, 0, 2] , 
 			[2, 3, 1, 1, 5, 0, 3, 3, 1, 1] ).

% 5784 Solutions for this problem.
problem( 174, [ (9,5,circle), (5,5,circle), (4,10,water), (4,9,water) ], 
 			[2, 4, 0, 3, 3, 3, 2, 1, 1, 1] , 
 			[4, 0, 3, 1, 2, 1, 4, 1, 3, 1] ).

% 5417 Solutions for this problem.
problem( 175, [ (6,8,circle), (9,3,circle), (6,4,water) ], 
 			[3, 2, 2, 5, 0, 4, 2, 1, 1, 0] , 
 			[3, 1, 2, 2, 2, 1, 3, 1, 1, 4] ).

% 970 Solutions for this problem.
problem( 176, [ (6,10,top), (6,3,circle), (1,1,water) ], 
 			[3, 2, 1, 7, 0, 4, 1, 2, 0, 0] , 
 			[3, 2, 3, 2, 2, 1, 2, 2, 0, 3] ).

% 652 Solutions for this problem.
problem( 178, [ (5,7,circle), (4,3,water) ], 
 			[0, 0, 1, 1, 2, 3, 2, 4, 1, 6] , 
 			[2, 1, 5, 1, 3, 1, 1, 2, 1, 3] ).

% 1515 Solutions for this problem.
problem( 179, [ (5,5,circle), (8,3,circle), (1,4,water) ], 
 			[4, 0, 1, 4, 4, 1, 0, 1, 2, 3] , 
 			[2, 1, 2, 1, 3, 1, 4, 2, 2, 2] ).

% 301 Solutions for this problem.
problem( 180, [ (7,8,circle), (6,1,water) ], 
 			[0, 2, 0, 4, 3, 2, 4, 2, 3, 0] , 
 			[4, 2, 3, 2, 1, 2, 1, 3, 1, 1] ).

% 150 Solutions for this problem.
problem( 181, [ (10,9,circle), (1,1,circle) ], 
 			[1, 0, 1, 0, 2, 6, 1, 2, 5, 2] , 
 			[2, 2, 2, 1, 4, 0, 2, 3, 1, 3] ).

% 1234 Solutions for this problem.
problem( 183, [ (8,9,circle), (10,2,circle), (1,7,water) ], 
 			[2, 0, 6, 1, 4, 1, 2, 1, 0, 3] , 
 			[4, 1, 1, 2, 1, 1, 3, 1, 5, 1] ).

% 1546 Solutions for this problem.
problem( 184, [ (6,5,circle), (3,8,top) ], 
 			[2, 0, 1, 2, 3, 3, 4, 1, 0, 4] , 
 			[3, 0, 5, 0, 2, 0, 2, 3, 1, 4] ).

% 849 Solutions for this problem.
problem( 185, [ (9,7,circle), (5,6,circle), (7,8,water) ], 
 			[3, 0, 5, 1, 3, 2, 3, 1, 2, 0] , 
 			[2, 4, 1, 5, 2, 1, 1, 2, 1, 1] ).

% 96 Solutions for this problem.
problem( 186, [ (7,1,circle), (2,6,water) ], 
 			[1, 3, 4, 2, 5, 1, 1, 2, 1, 0] , 
 			[3, 1, 1, 5, 0, 2, 3, 0, 1, 4] ).

% 243 Solutions for this problem.
problem( 188, [ (1,7,circle), (4,1,circle), (6,4,water) ], 
 			[1, 3, 2, 3, 0, 1, 0, 4, 4, 2] , 
 			[3, 1, 1, 3, 1, 2, 3, 1, 4, 1] ).

% 393 Solutions for this problem.
problem( 190, [ (9,1,circle), (10,8,circle) ], 
 			[6, 1, 3, 2, 3, 2, 0, 1, 1, 1] , 
 			[1, 3, 1, 4, 1, 1, 5, 2, 1, 1] ).

% 755 Solutions for this problem.
problem( 191, [ (5,4,bottom), (2,9,circle), (6,9,water) ], 
 			[3, 1, 0, 1, 3, 3, 2, 2, 4, 1] , 
 			[2, 4, 0, 5, 0, 3, 2, 2, 2, 0] ).

% 3994 Solutions for this problem.
problem( 192, [ (4,3,circle), (8,6,circle), (1,7,water) ], 
 			[1, 2, 3, 2, 1, 3, 1, 2, 2, 3] , 
 			[2, 0, 2, 4, 0, 2, 4, 1, 3, 2] ).

% 350 Solutions for this problem.
problem( 193, [ (1,2,middle), (1,7,water) ], 
 			[4, 2, 1, 0, 4, 3, 0, 1, 4, 1] , 
 			[2, 1, 1, 2, 4, 2, 3, 2, 2, 1] ).

% 67 Solutions for this problem.
problem( 194, [ (8,9,circle) ], 
 			[2, 3, 3, 2, 1, 5, 1, 2, 0, 1] , 
 			[1, 3, 3, 2, 2, 3, 4, 1, 1, 0] ).

% 52 Solutions for this problem.
problem( 195, [ (4,4,left), (3,10,water) ], 
 			[0, 0, 2, 4, 1, 3, 3, 3, 4, 0] , 
 			[5, 1, 1, 2, 3, 0, 1, 4, 0, 3] ).

% 492 Solutions for this problem.
problem( 196, [ (5,5,left), (10,1,circle) ], 
 			[0, 1, 3, 1, 4, 2, 1, 4, 2, 2] , 
 			[4, 0, 1, 5, 2, 2, 3, 0, 2, 1] ).

% 183 Solutions for this problem.
problem( 197, [ (4,1,circle) ], 
 			[1, 4, 2, 3, 3, 1, 1, 2, 1, 2] , 
 			[5, 2, 1, 6, 1, 0, 3, 0, 2, 0] ).

% 5834 Solutions for this problem.
problem( 198, [ (4,7,circle), (4,3,circle), (6,5,water) ], 
 			[0, 6, 1, 4, 0, 4, 0, 1, 0, 4] , 
 			[2, 1, 1, 2, 3, 2, 3, 3, 2, 1] ).

% 594 Solutions for this problem.
problem( 199, [ (3,10,circle), (5,1,middle), (3,6,water) ], 
 			[0, 0, 2, 3, 4, 4, 3, 1, 1, 2] , 
 			[4, 1, 0, 3, 0, 5, 0, 5, 0, 2] ).

% 78 Solutions for this problem.
problem( 200, [ (7,1,middle) ], 
 			[1, 2, 4, 1, 4, 4, 2, 2, 0, 0] , 
 			[4, 0, 6, 0, 3, 2, 0, 1, 3, 1] ).

% 288 Solutions for this problem.
problem( 201, [ (6,3,circle), (8,7,water), (2,1,water) ], 
 			[0, 6, 1, 6, 0, 2, 0, 2, 2, 1] , 
 			[1, 1, 2, 1, 3, 2, 3, 3, 2, 2] ).

% 391 Solutions for this problem.
problem( 202, [ (5,1,bottom) ], 
 			[4, 1, 2, 2, 4, 1, 3, 1, 1, 1] , 
 			[4, 2, 0, 0, 1, 2, 2, 4, 4, 1] ).

% 39 Solutions for this problem.
problem( 203, [ (6,7,circle), (8,5,water) ], 
 			[5, 3, 1, 0, 0, 2, 4, 2, 3, 0] , 
 			[4, 1, 3, 2, 3, 2, 2, 1, 2, 0] ).

% 924 Solutions for this problem.
problem( 205, [ (5,9,circle), (1,9,water) ], 
 			[1, 2, 6, 2, 4, 0, 1, 2, 1, 1] , 
 			[4, 0, 3, 1, 2, 0, 2, 3, 3, 2] ).

% 1034 Solutions for this problem.
problem( 206, [ (2,7,circle), (7,1,circle), (4,7,water) ], 
 			[1, 3, 2, 2, 2, 1, 4, 1, 2, 2] , 
 			[1, 4, 0, 0, 6, 0, 2, 5, 0, 2] ).

% 367 Solutions for this problem.
problem( 207, [ (9,9,left), (1,6,water) ], 
 			[2, 4, 2, 1, 4, 3, 1, 1, 2, 0] , 
 			[1, 1, 3, 1, 4, 2, 1, 3, 3, 1] ).

% 2724 Solutions for this problem.
problem( 208, [ (2,7,top), (9,1,circle), (5,4,water) ], 
 			[2, 1, 1, 1, 5, 1, 3, 1, 3, 2] , 
 			[3, 0, 4, 1, 2, 1, 4, 0, 5, 0] ).

% 2290 Solutions for this problem.
problem( 209, [ (1,1,left), (8,2,left), (6,3,water) ], 
 			[2, 1, 4, 1, 2, 3, 1, 5, 1, 0] , 
 			[3, 2, 3, 1, 2, 0, 5, 0, 4, 0] ).

% 2421 Solutions for this problem.
problem( 210, [ (6,7,circle), (6,4,left), (2,3,water) ], 
 			[2, 2, 1, 2, 2, 4, 1, 5, 1, 0] , 
 			[5, 0, 4, 1, 2, 1, 2, 4, 0, 1] ).

% 12538 Solutions for this problem.
problem( 211, [ (8,8,circle), (6,2,circle), (5,8,water) ], 
 			[5, 1, 1, 2, 2, 1, 1, 1, 5, 1] , 
 			[1, 4, 1, 1, 4, 1, 1, 3, 1, 3] ).

% 3825 Solutions for this problem.
problem( 212, [ (4,1,circle), (1,10,circle), (1,6,water) ], 
 			[4, 0, 4, 1, 1, 1, 2, 2, 0, 5] , 
 			[5, 0, 4, 1, 1, 1, 2, 2, 2, 2] ).

% 148 Solutions for this problem.
problem( 213, [ (10,5,circle), (5,8,water) ], 
 			[0, 2, 1, 1, 3, 0, 4, 4, 2, 3] , 
 			[2, 1, 2, 4, 2, 2, 1, 1, 4, 1] ).

% 12486 Solutions for this problem.
problem( 214, [ (4,3,circle), (4,5,circle), (3,10,water) ], 
 			[5, 2, 2, 2, 1, 2, 0, 1, 1, 4] , 
 			[4, 0, 4, 0, 3, 1, 2, 2, 1, 3] ).

% 264 Solutions for this problem.
problem( 215, [ (9,9,circle), (1,6,water) ], 
 			[2, 2, 3, 2, 2, 0, 3, 3, 2, 1] , 
 			[1, 0, 4, 3, 0, 5, 1, 4, 2, 0] ).

% 59 Solutions for this problem.
problem( 216, [ (5,9,top), (1,1,water) ], 
 			[2, 5, 1, 1, 1, 2, 1, 4, 3, 0] , 
 			[1, 4, 3, 2, 2, 3, 1, 1, 3, 0] ).

% 128 Solutions for this problem.
problem( 217, [ (7,6,circle), (2,9,water), (3,1,water) ], 
 			[5, 1, 2, 3, 4, 1, 2, 0, 1, 1] , 
 			[3, 4, 1, 5, 0, 3, 0, 1, 3, 0] ).

% 1106 Solutions for this problem.
problem( 218, [ (1,7,circle), (4,7,water) ], 
 			[6, 0, 0, 1, 1, 2, 2, 1, 2, 5] , 
 			[2, 1, 1, 1, 5, 1, 3, 2, 3, 1] ).

% 840 Solutions for this problem.
problem( 219, [ (7,3,left), (5,10,circle), (8,10,water), (1,7,water) ], 
 			[3, 4, 1, 0, 2, 2, 2, 1, 4, 1] , 
 			[3, 0, 2, 2, 2, 3, 2, 3, 1, 2] ).

% 391 Solutions for this problem.
problem( 220, [ (8,3,circle), (1,7,circle) ], 
 			[5, 0, 0, 1, 0, 5, 2, 3, 2, 2] , 
 			[2, 2, 4, 1, 2, 3, 2, 0, 3, 1] ).

% 142 Solutions for this problem.
problem( 221, [ (4,3,circle), (8,7,water) ], 
 			[2, 2, 1, 2, 0, 4, 3, 4, 2, 0] , 
 			[5, 1, 3, 0, 1, 2, 1, 3, 4, 0] ).

% 1506 Solutions for this problem.
problem( 223, [ (4,7,circle), (8,9,bottom), (1,1,water), (8,4,water) ], 
 			[1, 5, 0, 4, 0, 2, 1, 2, 4, 1] , 
 			[3, 1, 1, 4, 2, 3, 2, 0, 4, 0] ).

% 1339 Solutions for this problem.
problem( 224, [ (6,5,circle), (4,5,circle), (4,1,water), (1,3,water) ], 
 			[2, 1, 0, 5, 2, 2, 2, 1, 2, 3] , 
 			[4, 2, 3, 0, 2, 0, 2, 1, 2, 4] ).

% 216 Solutions for this problem.
problem( 225, [ (5,10,circle), (3,7,water) ], 
 			[0, 1, 4, 3, 1, 5, 0, 0, 2, 4] , 
 			[3, 1, 1, 3, 1, 3, 3, 2, 2, 1] ).

% 1963 Solutions for this problem.
problem( 226, [ (5,8,circle), (10,8,circle) ], 
 			[1, 5, 3, 2, 3, 0, 1, 2, 2, 1] , 
 			[4, 1, 2, 1, 2, 3, 1, 3, 1, 2] ).

% 2811 Solutions for this problem.
problem( 227, [ (2,8,circle), (6,1,circle) ], 
 			[5, 1, 0, 2, 2, 4, 1, 4, 0, 1] , 
 			[2, 2, 1, 2, 3, 2, 3, 2, 2, 1] ).

% 1059 Solutions for this problem.
problem( 228, [ (4,1,circle), (3,10,water) ], 
 			[2, 0, 1, 5, 1, 4, 2, 2, 1, 2] , 
 			[4, 1, 2, 0, 1, 2, 3, 1, 3, 3] ).

% 578 Solutions for this problem.
problem( 229, [ (8,1,circle), (9,5,circle) ], 
 			[5, 1, 0, 3, 0, 5, 2, 2, 2, 0] , 
 			[3, 0, 5, 1, 3, 2, 2, 3, 0, 1] ).

% 2834 Solutions for this problem.
problem( 230, [ (10,7,circle), (6,9,circle), (8,3,water) ], 
 			[2, 1, 1, 1, 1, 5, 1, 3, 3, 2] , 
 			[2, 4, 2, 1, 3, 1, 4, 0, 1, 2] ).

% 82 Solutions for this problem.
problem( 231, [ (6,8,circle), (6,6,water), (5,1,water) ], 
 			[4, 3, 1, 1, 1, 3, 4, 2, 1, 0] , 
 			[2, 0, 2, 3, 4, 3, 1, 2, 0, 3] ).

% 3676 Solutions for this problem.
problem( 232, [ (3,7,circle), (1,10,circle), (1,5,water) ], 
 			[2, 1, 3, 1, 4, 1, 5, 0, 1, 2] , 
 			[2, 4, 0, 1, 4, 1, 1, 3, 2, 2] ).

% 194 Solutions for this problem.
problem( 234, [ (9,10,circle), (4,1,water) ], 
 			[5, 0, 1, 4, 0, 1, 6, 0, 3, 0] , 
 			[3, 2, 0, 1, 3, 3, 1, 2, 3, 2] ).

% 18824 Solutions for this problem.
problem( 235, [ (10,5,circle), (5,8,middle), (7,3,circle) ], 
 			[4, 0, 4, 1, 2, 1, 2, 1, 3, 2] , 
 			[2, 1, 4, 2, 2, 2, 2, 3, 0, 2] ).

% 340 Solutions for this problem.
problem( 236, [ (5,4,middle), (2,8,water), (9,6,water) ], 
 			[0, 3, 5, 0, 6, 0, 1, 1, 1, 3] , 
 			[4, 3, 2, 1, 2, 2, 1, 2, 2, 1] ).

% 5545 Solutions for this problem.
problem( 237, [ (7,1,circle), (6,5,circle), (3,10,water) ], 
 			[2, 4, 2, 1, 1, 2, 1, 1, 0, 6] , 
 			[3, 1, 3, 2, 2, 2, 1, 3, 1, 2] ).

% 56 Solutions for this problem.
problem( 238, [ (6,1,circle) ], 
 			[2, 0, 1, 4, 4, 3, 0, 6, 0, 0] , 
 			[4, 0, 4, 0, 3, 0, 3, 1, 3, 2] ).

% 2535 Solutions for this problem.
problem( 239, [ (7,5,circle), (2,9,circle), (7,9,water) ], 
 			[0, 4, 1, 2, 1, 1, 2, 3, 0, 6] , 
 			[2, 3, 1, 1, 3, 3, 2, 1, 4, 0] ).

% 27 Solutions for this problem.
problem( 240, [ (4,3,middle) ], 
 			[4, 2, 2, 2, 7, 1, 0, 0, 2, 0] , 
 			[4, 0, 4, 1, 3, 0, 1, 2, 3, 2] ).

% 1026 Solutions for this problem.
problem( 241, [ (5,7,middle), (10,4,circle), (1,2,water) ], 
 			[1, 0, 3, 0, 4, 1, 0, 7, 0, 4] , 
 			[1, 3, 1, 4, 2, 2, 2, 2, 3, 0] ).

% 290 Solutions for this problem.
problem( 242, [ (5,8,circle), (2,2,water) ], 
 			[0, 2, 5, 0, 5, 2, 4, 0, 2, 0] , 
 			[2, 3, 1, 2, 2, 1, 2, 3, 2, 2] ).

% 2544 Solutions for this problem.
problem( 243, [ (10,10,circle), (3,1,circle), (1,3,water) ], 
 			[4, 0, 1, 1, 2, 2, 1, 2, 3, 4] , 
 			[4, 1, 4, 1, 0, 2, 1, 1, 4, 2] ).

% 520 Solutions for this problem.
problem( 244, [ (10,4,circle), (6,1,water) ], 
 			[0, 5, 1, 3, 1, 4, 2, 1, 2, 1] , 
 			[4, 0, 2, 2, 0, 1, 1, 5, 0, 5] ).

% 2376 Solutions for this problem.
problem( 245, [ (3,8,circle), (1,1,circle) ], 
 			[4, 0, 1, 4, 1, 0, 3, 2, 0, 5] , 
 			[2, 1, 0, 3, 2, 3, 1, 4, 2, 2] ).

% 90 Solutions for this problem.
problem( 246, [ (7,1,circle), (7,6,water) ], 
 			[5, 0, 1, 2, 6, 2, 3, 0, 1, 0] , 
 			[2, 1, 3, 1, 2, 3, 0, 3, 0, 5] ).

% 33 Solutions for this problem.
problem( 247, [ (4,1,circle), (1,5,water) ], 
 			[4, 1, 1, 4, 1, 0, 5, 4, 0, 0] , 
 			[3, 2, 1, 1, 3, 1, 4, 1, 3, 1] ).

% 282 Solutions for this problem.
problem( 248, [ (7,9,circle), (8,4,water) ], 
 			[1, 5, 2, 3, 1, 0, 2, 4, 1, 1] , 
 			[2, 2, 3, 1, 2, 2, 2, 3, 3, 0] ).

% 7536 Solutions for this problem.
problem( 249, [ (3,1,circle), (1,7,circle), (5,5,water) ], 
 			[1, 2, 2, 2, 2, 2, 4, 1, 3, 1] , 
 			[1, 1, 3, 0, 6, 0, 4, 0, 0, 5] ).

% 7474 Solutions for this problem.
problem( 250, [ (7,10,middle), (1,1,left), (3,9,water) ], 
 			[3, 2, 1, 4, 0, 1, 1, 1, 4, 3] , 
 			[1, 2, 2, 2, 3, 1, 3, 1, 1, 4] ).

% 151 Solutions for this problem.
problem( 251, [ (4,9,bottom), (6,6,water) ], 
 			[2, 0, 2, 1, 1, 2, 2, 5, 1, 4] , 
 			[3, 4, 0, 1, 1, 2, 1, 4, 3, 1] ).

% 8535 Solutions for this problem.
problem( 252, [ (7,7,left), (10,1,water), (3,5,water) ], 
 			[0, 3, 2, 2, 2, 3, 2, 1, 0, 5] , 
 			[5, 1, 3, 0, 4, 0, 1, 3, 1, 2] ).

% 4692 Solutions for this problem.
problem( 253, [ (2,3,circle), (1,9,circle), (3,1,water) ], 
 			[2, 2, 1, 5, 1, 2, 3, 2, 1, 1] , 
 			[3, 1, 3, 4, 1, 1, 3, 0, 3, 1] ).

% 216 Solutions for this problem.
problem( 254, [ (10,1,circle), (3,5,water) ], 
 			[5, 3, 2, 0, 0, 0, 3, 0, 5, 2] , 
 			[3, 2, 2, 2, 3, 1, 2, 1, 2, 2] ).

% 23 Solutions for this problem.
problem( 255, [ (8,8,circle) ], 
 			[1, 1, 6, 2, 1, 3, 2, 3, 0, 1] , 
 			[1, 1, 1, 3, 3, 4, 1, 3, 0, 3] ).

% 1985 Solutions for this problem.
problem( 256, [ (9,5,circle), (5,4,left), (1,5,water) ], 
 			[2, 1, 3, 1, 4, 0, 3, 1, 1, 4] , 
 			[5, 2, 2, 1, 3, 1, 1, 0, 5, 0] ).

% 2012 Solutions for this problem.
problem( 257, [ (8,10,circle), (10,7,left), (6,8,water) ], 
 			[1, 1, 0, 0, 3, 2, 3, 3, 2, 5] , 
 			[2, 0, 4, 0, 1, 4, 1, 3, 1, 4] ).

% 877 Solutions for this problem.
problem( 258, [ (7,3,circle), (2,8,circle) ], 
 			[1, 2, 3, 2, 1, 1, 3, 2, 4, 1] , 
 			[4, 0, 3, 3, 0, 6, 1, 2, 0, 1] ).

% 1046 Solutions for this problem.
problem( 259, [ (7,6,middle), (1,1,left), (2,9,water), (5,9,water) ], 
 			[2, 2, 2, 0, 5, 1, 1, 1, 5, 1] , 
 			[2, 3, 2, 3, 0, 4, 2, 2, 2, 0] ).

% 1122 Solutions for this problem.
problem( 260, [ (7,5,circle), (1,10,circle) ], 
 			[2, 0, 0, 3, 3, 2, 2, 2, 2, 4] , 
 			[4, 1, 3, 3, 2, 2, 0, 2, 1, 2] ).

% 2072 Solutions for this problem.
problem( 261, [ (9,10,circle), (4,3,water), (3,1,water), (8,8,water) ], 
 			[1, 1, 2, 3, 1, 0, 4, 1, 2, 5] , 
 			[3, 2, 3, 2, 0, 2, 2, 1, 3, 2] ).

% 1759 Solutions for this problem.
problem( 262, [ (5,9,circle), (6,7,circle), (1,8,water) ], 
 			[3, 1, 2, 3, 2, 3, 1, 0, 5, 0] , 
 			[1, 3, 1, 3, 2, 1, 2, 1, 3, 3] ).

% 962 Solutions for this problem.
problem( 263, [ (10,7,circle), (8,3,middle) ], 
 			[2, 0, 4, 1, 3, 1, 2, 2, 2, 3] , 
 			[2, 0, 3, 0, 3, 1, 5, 0, 2, 4] ).

% 23 Solutions for this problem.
problem( 264, [ (4,1,water) ], 
 			[1, 3, 5, 3, 3, 2, 1, 0, 0, 2] , 
 			[3, 1, 4, 1, 1, 4, 1, 3, 1, 1] ).

% 224 Solutions for this problem.
problem( 265, [ (10,3,circle), (7,4,water), (2,2,water) ], 
 			[0, 1, 1, 0, 4, 3, 2, 3, 3, 3] , 
 			[2, 2, 2, 3, 1, 2, 1, 4, 2, 1] ).

% 1469 Solutions for this problem.
problem( 266, [ (5,4,right), (3,1,circle), (5,6,water) ], 
 			[3, 0, 5, 0, 5, 3, 0, 1, 1, 2] , 
 			[3, 1, 3, 2, 3, 2, 1, 3, 1, 1] ).

% 40 Solutions for this problem.
problem( 267, [ (4,7,top) ], 
 			[0, 2, 0, 2, 2, 3, 2, 4, 2, 3] , 
 			[0, 4, 0, 4, 4, 1, 3, 1, 2, 1] ).

% 907 Solutions for this problem.
problem( 268, [ (7,1,circle), (1,3,water), (3,3,water) ], 
 			[3, 0, 1, 0, 2, 3, 2, 2, 1, 6] , 
 			[4, 2, 2, 1, 5, 1, 2, 1, 2, 0] ).

% 2596 Solutions for this problem.
problem( 269, [ (1,3,circle), (8,6,circle), (3,1,water) ], 
 			[2, 2, 4, 0, 4, 3, 3, 1, 0, 1] , 
 			[3, 2, 2, 2, 1, 2, 2, 2, 2, 2] ).

% 45 Solutions for this problem.
problem( 270, [ (8,8,water), (3,9,water) ], 
 			[4, 0, 2, 5, 1, 1, 2, 2, 2, 1] , 
 			[2, 0, 1, 1, 1, 4, 3, 5, 2, 1] ).

% 782 Solutions for this problem.
problem( 272, [ (9,4,circle), (1,4,middle), (7,10,water) ], 
 			[6, 0, 4, 0, 0, 0, 1, 2, 2, 5] , 
 			[4, 1, 1, 3, 1, 3, 1, 2, 1, 3] ).

% 116 Solutions for this problem.
problem( 273, [ (4,4,left), (6,1,water) ], 
 			[3, 0, 1, 4, 2, 3, 3, 3, 1, 0] , 
 			[1, 1, 3, 2, 2, 4, 1, 2, 3, 1] ).

% 5788 Solutions for this problem.
problem( 274, [ (1,8,circle), (5,5,circle), (2,1,middle), (6,1,water) ], 
 			[4, 2, 2, 1, 3, 1, 1, 1, 1, 4] , 
 			[5, 0, 4, 0, 2, 3, 2, 3, 1, 0] ).

% 3423 Solutions for this problem.
problem( 275, [ (7,3,middle), (1,8,middle), (9,8,water) ], 
 			[5, 1, 1, 1, 1, 3, 3, 3, 1, 1] , 
 			[1, 2, 1, 2, 0, 3, 2, 3, 1, 5] ).

% 597 Solutions for this problem.
problem( 276, [ (6,8,circle), (5,5,water) ], 
 			[4, 1, 1, 3, 1, 6, 0, 0, 4, 0] , 
 			[3, 1, 4, 0, 3, 1, 1, 2, 2, 3] ).

% 3021 Solutions for this problem.
problem( 277, [ (2,4,circle), (8,8,circle) ], 
 			[1, 1, 1, 5, 1, 2, 2, 4, 1, 2] , 
 			[4, 0, 5, 1, 1, 0, 1, 2, 1, 5] ).

% 77 Solutions for this problem.
problem( 278, [ (3,7,water) ], 
 			[2, 2, 4, 2, 2, 0, 1, 1, 2, 4] , 
 			[0, 4, 1, 4, 4, 0, 5, 0, 2, 0] ).

% 80 Solutions for this problem.
problem( 279, [ (5,1,top), (3,6,water) ], 
 			[0, 0, 1, 5, 2, 4, 1, 0, 3, 4] , 
 			[3, 0, 2, 2, 1, 3, 2, 2, 3, 2] ).

% 41 Solutions for this problem.
problem( 282, [ (9,10,water), (1,2,water) ], 
 			[1, 0, 0, 0, 2, 4, 3, 3, 2, 5] , 
 			[4, 2, 1, 2, 3, 2, 1, 1, 0, 4] ).

% 107 Solutions for this problem.
problem( 283, [ (1,9,circle), (4,4,water) ], 
 			[1, 1, 1, 4, 1, 0, 3, 1, 7, 1] , 
 			[1, 2, 1, 2, 1, 5, 0, 5, 1, 2] ).

% 1205 Solutions for this problem.
problem( 285, [ (4,2,left), (6,9,circle) ], 
 			[2, 2, 3, 3, 2, 1, 2, 0, 4, 1] , 
 			[0, 4, 2, 0, 2, 1, 5, 1, 5, 0] ).

% 354 Solutions for this problem.
problem( 286, [ (8,7,circle), (9,4,water) ], 
 			[0, 2, 1, 2, 4, 2, 2, 2, 3, 2] , 
 			[1, 1, 3, 2, 3, 2, 3, 1, 4, 0] ).

% 58 Solutions for this problem.
problem( 287, [ (7,9,water), (2,1,water) ], 
 			[0, 2, 2, 1, 2, 4, 3, 4, 1, 1] , 
 			[2, 3, 2, 2, 0, 0, 4, 0, 2, 5] ).

% 329 Solutions for this problem.
problem( 288, [ (10,2,circle) ], 
 			[1, 1, 2, 2, 4, 2, 2, 2, 1, 3] , 
 			[3, 5, 1, 5, 0, 4, 0, 1, 1, 0] ).

% 754 Solutions for this problem.
problem( 289, [ (9,10,circle), (3,1,circle) ], 
 			[4, 3, 1, 0, 1, 1, 1, 2, 3, 4] , 
 			[2, 1, 2, 2, 3, 2, 3, 2, 2, 1] ).

% 2106 Solutions for this problem.
problem( 290, [ (6,5,circle), (5,8,water) ], 
 			[0, 1, 3, 2, 3, 2, 4, 2, 1, 2] , 
 			[3, 1, 4, 1, 2, 3, 1, 3, 1, 1] ).

% 8101 Solutions for this problem.
problem( 291, [ (4,3,circle), (9,6,circle), (6,2,water) ], 
 			[3, 3, 1, 2, 1, 4, 1, 1, 3, 1] , 
 			[1, 4, 1, 4, 1, 1, 1, 1, 1, 5] ).

% 41 Solutions for this problem.
problem( 292, [ (6,6,circle), (2,4,water) ], 
 			[0, 1, 6, 2, 2, 1, 1, 4, 3, 0] , 
 			[2, 4, 0, 4, 1, 3, 1, 1, 2, 2] ).

% 1606 Solutions for this problem.
problem( 293, [ (2,6,circle), (3,4,circle), (3,2,water) ], 
 			[2, 1, 2, 0, 4, 2, 1, 5, 0, 3] , 
 			[3, 3, 0, 3, 1, 2, 2, 2, 1, 3] ).

% 1806 Solutions for this problem.
problem( 294, [ (8,6,circle), (5,9,circle), (3,5,water) ], 
 			[4, 2, 2, 2, 4, 1, 3, 2, 0, 0] , 
 			[3, 2, 2, 1, 2, 1, 5, 0, 2, 2] ).

% 60 Solutions for this problem.
problem( 295, [ (3,10,circle), (9,7,water) ], 
 			[0, 0, 1, 0, 5, 3, 5, 1, 2, 3] , 
 			[3, 1, 2, 1, 4, 1, 1, 3, 1, 3] ).

% 10868 Solutions for this problem.
problem( 296, [ (8,1,circle), (1,5,left), (3,8,circle), (5,10,water) ], 
 			[4, 0, 2, 0, 1, 3, 0, 5, 0, 5] , 
 			[1, 3, 3, 1, 1, 3, 2, 3, 1, 2] ).

% 68 Solutions for this problem.
problem( 297, [ (6,5,left), (3,1,water) ], 
 			[0, 0, 3, 1, 3, 6, 1, 4, 1, 1] , 
 			[3, 2, 2, 2, 1, 3, 1, 1, 0, 5] ).

% 552 Solutions for this problem.
problem( 298, [ (8,6,circle), (6,4,water) ], 
 			[0, 1, 5, 2, 3, 2, 1, 4, 1, 1] , 
 			[0, 4, 1, 4, 1, 3, 3, 1, 1, 2] ).

% 1465 Solutions for this problem.
problem( 299, [ (1,1,circle), (9,7,left) ], 
 			[1, 0, 6, 1, 3, 1, 1, 2, 4, 1] , 
 			[5, 0, 2, 1, 1, 3, 3, 2, 2, 1] ).

% 4545 Solutions for this problem.
problem( 300, [ (3,5,circle), (10,10,circle), (6,1,water), (1,8,water) ], 
 			[1, 5, 2, 1, 1, 4, 0, 4, 1, 1] , 
 			[4, 2, 3, 2, 2, 1, 1, 2, 0, 3] ).


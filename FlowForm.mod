param n;
set CITIES ordered := 1..n;

set LINKS := {i in CITIES, j in CITIES: ord(i) != ord(j)};

param COST{LINKS} >= 0;
var x {LINKS} binary;
var u {CITIES} integer;

minimize minDist: sum{i in CITIES, j in CITIES: ord(i) != ord(j)} x[i,j]*COST[i,j];

subject to SumXi {i in CITIES}: sum{j in CITIES:ord(i) != ord(j)} x[i,j] =1;
subject to SumXj {j in CITIES}: sum{i in CITIES:ord(i) != ord(j)} x[i,j] =1;

subject to SumY1: sum{j in CITIES: j !=1} y[1,j] = n-1;
subject to SumYj {j in CITIES: j !=1} : 
	sum{i in CITIES:ord(i) != ord(j)} y[i,j] - sum{k in CITIES:ord(j) != ord(k)} =1;

subject to Flow {i in CITIES, j in CITIES: ord(i) != ord(j)}: 
	y[i,j] <= (n-1)*x[i,j];
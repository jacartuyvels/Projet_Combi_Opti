param n;
set CITIES ordered := 1..n;

set LINKS := {i in CITIES, j in CITIES: ord(i) != ord(j)};

param COST{LINKS} >= 0;
var x {LINKS} binary;

var u {CITIES} integer >= 0;

minimize minDist: sum{i in CITIES, j in CITIES: ord(i) != ord(j)} x[i,j]*COST[i,j];

subject to SumXi {i in CITIES}: sum{j in CITIES:ord(i) != ord(j)} x[i,j] =1;
subject to SumXj {j in CITIES}: sum{i in CITIES:ord(i) != ord(j)} x[i,j] =1;

subject to SeqFlow {i in CITIES,j in CITIES: ord(i) != ord(j) && i!= 1 && j!=1}:
	u[i]-u[j]+n*x[i,j] <= n-1;
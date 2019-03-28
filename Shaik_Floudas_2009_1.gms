$Title Shaik_Floudas_2009_1
$Ontext
         Novel unified modeling approach for short-term scheduling (2009)
         M.A. Shaik & C.A. Floudas
         Example 1
$Offtext
Sets
i                Tasks
                 /i1*i5/
j                Units
                 /j1*j5/
n                Events
                 /n1*n4/
s                States
                 /s1*s4/
ij(i,j)          Tasks which can be performed in unit j
                 /i1.j1,i2.j2,i3.j3,i4.j4,i5.j5/
is(i,s)          Tasks which process state s and either produce or consume
                 /i1.s1,i1.s2,i2.s1,i2.s2,i3.s2,i3.s3,i4.s3,i4.s4,i5.s3,i5.s4/
isc(i,s)         Tasks which consume state s
                 /i1.s1,i2.s1,i3.s2,i4.s3,i5.s3/
isp(i,s)         Tasks which produce state s
                 /i1.s2,i2.s2,i3.s3,i4.s4,i5.s4/
ji(j,i)          Units which are suitable for performing task i
                 /j1.i1,j2.i2,j3.i3,j4.i4,j5.i5/
$Ontext
ij1(i)           Tasks which can be performed in unit j1
                 /i1/
ij2(i)           Tasks which can be performed in unit j2
                 /i2/
ij3(i)           Tasks which can be performed in unit j3
                 /i3/
ij4(i)           Tasks which can be performed in unit j4
                 /i4/
ij5(i)           Tasks which can be performed in unit j5
                 /i5/
is1(i)           Tasks which process state s1 and either produce or consume
                 /i1,i2/
is2(i)           Tasks which process state s2 and either produce or consume
                 /i1,i2,i3/
is3(i)           Tasks which process state s3 and either produce or consume
                 /i3,i4,i5/
is4(i)           Tasks which process state s4 and either produce or consume
                 /i4,i5/
isc1(i)          Tasks which consume state s1
                 /i1,i2/
isc2(i)          Tasks which consume state s2
                 /i3/
isc3(i)          Tasks which consume state s3
                 /i4,i5/
isp2(i)          Tasks which produce state s2
                 /i1,i2/
isp3(i)          Tasks which produce state s3
                 /i3/
isp4(i)          Tasks which consume state s4
                 /i4,i5/
*iu(i,u)          Tasks which consume utility u
*                 //
ji1(j)           Units which are suitable for performing task i1
                 /j1/
ji2(j)           Units which are suitable for performing task i2
                 /j2/
ji3(j)           Units which are suitable for performing task i3
                 /j3/
ji4(j)           Units which are suitable for performing task i4
                 /j4/
ji5(j)           Units which are suitable for performing task i5
                 /j5/
$Offtext
sp(s)            States that are final products
                 /s4/
sr(s)            States that are raw materials
                 /s1/
sdfis(s)         States with dedicated finite intermediate storage
                 /s1,s2,s3,s4/
*snis(s)          States with no intermediate storage
*                 /0/
*szw(s)           States with zero wait storage
*                 /0/
*u                Utilities
*                 //
;
Alias
(i,ii),(j,jj),(n,nn,nnn)
;
Positive variables
b(i,n,nn)        Amount of material undertaking task i that starts at event n and ends at event nn
ST_0(s)          Initial amount of state that is required from external resources
*sr?
ST(s,n)          Excess amount of state s that needs to be stored at event point n
Ts(i,n)          Time at which task i starts at event n
Tf(i,n)          Time at which task i ends at event n
*Tut(u,n)         Time at which there is a change in the consumption of utility u at event n
;
Binary variables
w(i,n,nn)        Binary variable for assignment of task i that starts at event n and ends at event nn
;
Free variables
Profit
MS
;
Parameters
alpha(i)         Coefficient of constant term of processing time of task i
                 /i1  1.333
                  i2  1.333
                  i3  1.000
                  i4  0.667
                  i5  0.667/
beta(i)          Coefficient of variable term of processing time of task i
                 /i1  0.01333
                  i2  0.01333
                  i3  0.00500
                  i4  0.00445
                  i5  0.00445/
B_min(i)         Minimum capacity of task i
                 /i1  0
                  i2  0
                  i3  0
                  i4  0
                  i5  0/
B_max(i)         Maximum capacity of task i
                 /i1  100
                  i2  150
                  i3  200
                  i4  150
                  i5  150/
*D(s)             Demand for state s
*                 //
*delta(i,u)       Coefficient of variable term of consumption of utility u by task i
*                 //
*gamma(i,u)       Coefficient of constant term of consumption of utility u by task i
*                 //
p(s)             Price of state s
                 /s1  0
                  s2  0
                  s3  0
                  s4  5/
ST0(s)          Initial amount of state s available
                 /s1  999999999
                  s2  0
                  s3  0
                  s4  0/
ST_max(s)        Maxumum amount of state s
                 /s1  999999999
                  s2  999999999
                  s3  999999999
                  s4  999999999/
*U_max(u)         Maximum availability of utility u
*                 //
;
Scalars
dn               Limit on the maximum number of events over which task i is allowed to continue
                 /0/
H                Short-term time horizon
                 /8/
M                Large positive number in big-M constraints
                 /8/
;
Table rho(i,s) Proportion of state s produced (>0) or consumed (<0) by task i
                s1    s2    s3    s4
        i1      -1    1     0     0
        i2      -1    1     0     0
        i3      0     -1    1     0
        i4      0     0     -1    1
        i5      0     0     -1    1
Equations
a1
*a1_j1,a1_j2,a1_j3,a1_j4,a1_j5
*,a2,a3,a4,a5           Allocation constraints
c1,c2                    Capacity constraints
mb1,mb2                  Mass balance constraints
d1
*,d2,d3,d4              Duration constraints
s1,s3,s4              Sequencing constraints
t1                       Tightening constraints
*r1,r2,r3,r4,r5,r6        Resource constraints
sp1,sp3,sp5      Storage policy constraints
b1,b2                    Variable bounds
of                       Objective function
;
$Ontext
----------------------------Allocation Constraints------------------------------
$Offtext
a1(j,n)..                  sum(i$(ij(i,j)),sum(nn$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn))),w(i,n,nn))) =L= 1;
*a1_j1(n)..                sum(i$(ij1(i)),sum(nn$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn))),w(i,n,nn))) =L= 1;
*a1_j2(n)..                sum(i$(ij2(i)),sum(nn$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn))),w(i,n,nn))) =L= 1;
*a1_j3(n)..                sum(i$(ij3(i)),sum(nn$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn))),w(i,n,nn))) =L= 1;
*a1_j4(n)..                sum(i$(ij4(i)),sum(nn$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn))),w(i,n,nn))) =L= 1;
*a1_j5(n)..                sum(i$(ij5(i)),sum(nn$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn))),w(i,n,nn))) =L= 1;
*a2(j,nn)..               sum(i$(ij(i,j)),sum(n$((ord(n) >= (ord(nn)-dn)) and (ord(n) <= ord(nn))),w(i,n,nn))) =L= 1;
*a2 only if dn>0
*a3(i$(ij(i,j)),j,n)..    sum(ii$(ij(i,j) and (ord(ii) ne ord(i))),sum(nn$((ord(nn) >= (ord(n)-dn)) and (ord(nn) <= ord(n))),w(ii,nn,n))) =L= 1 - sum(nn$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn))),w(i,n,nn));
*a3(ij(i,j),j,n)..    sum(ii$(ij(ii,j) and (ord(ii) ne ord(i))),sum(nn$((ord(nn) >= (ord(n)-dn)) and (ord(nn) <= ord(n))),w(ii,nn,n))) =L= 1 - sum(nn$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn))),w(i,n,nn));
*a3 only if dn>0
*ij(ii,j) or ij(i,j) in first summation?
*a4(i,n)$(ord(n) ne 1)..  sum(nn$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn))),w(i,n,nn)) =L= 1 - sum(nn$(ord(nn) < ord(n)),sum(nnn$((ord(nnn) >= ord(nn)) and (ord(nnn) <= (ord(nn)+dn))),sum(j$(ji(j,i)),sum(ii$(ij(i,j)),w(ii,nn,nnn))))) + sum(nnn,sum(nn$((ord(nn) < ord(n)) and (ord(nn) >= ord(nnn)) and (ord(nn) <= (ord(nnn)+dn))),sum(j$(ji(j,i)),sum(ii$(ij(i,j)),w(ii,nnn,nn))));
*a4 only if dn>0
*Might need additional closing bracket at end of last term
*a5(i,n)$(ord(n) ne 1)..  sum(nn$((ord(nn) >= (ord(n)-dn)) and (ord(nn) <= ord(n))),w(i,nn,n)) =L= sum(nn$(ord(nn) <= ord(n)),sum(nnn$((ord(nnn) >= ord(nn)) and (ord(nnn) <= (ord(nn)+dn))),w(i,nn,nnn))) - sum(nnn,sum(nn$((ord(nn) < ord(n)) and (ord(nn) >= ord(nnn)) and (ord(nn) <= (ord(nnn)+dn))),w(i,nnn,nn)));
*a4 only if dn>0
$Ontext
-----------------------------Capacity Constraints-------------------------------
$Offtext
c1(i,n,nn)$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn)))..  b(i,n,nn) =G= B_min(i)*w(i,n,nn);
c2(i,n,nn)$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn)))..  b(i,n,nn) =L= B_max(i)*w(i,n,nn);
$Ontext
-------------------------Material Balance Constraints---------------------------
$Offtext
mb1(s,n)$(ord(n) ne 1).. ST(s,n) =E= ST(s,n-1) + sum(i$(isp(i,s)),rho(i,s)*sum(nn$((ord(nn) >= (ord(n) - 1 - dn)) and (ord(nn) <= (ord(n) - 1))),b(i,nn,n-1))) + sum(i$(isc(i,s)),rho(i,s)*sum(nn$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn))),b(i,n,nn)));
mb2(s,n)$(ord(n) = 1)..  ST(s,n) =E= ST_0(s) + sum(i$(isc(i,s)),rho(i,s)*sum(nn$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn))),b(i,n,nn)));
$Ontext
-----------------------------Duration Constraints-------------------------------
$Offtext
d1(i,n)..                                                        Tf(i,n) =E= Ts(i,n) + (alpha(i)*w(i,n,n)) + (beta(i)*b(i,n,n));
*d1 only if dn = 0
*d2-d4 only if dn > 0
*d2(i,n)..                                                        Tf(i,n) =G= Ts(i,n);
*d3(i,n,nn)$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn)))..  Tf(i,nn) =G= Ts(i,n) + (alpha(i)*w(i,n,nn)) + (beta(i)*b(i,n,nn)) - M*(1-w(i,n,nn));
*d4(i,n,nn)$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn)))..  Tf(i,nn) =L= Ts(i,n) + (alpha(i)*w(i,n,nn)) + (beta(i)*b(i,n,nn)) + M*(1-w(i,n,nn));
$Ontext
----------------------------Sequencing Constraints------------------------------
$Offtext
* Same Task in the Same Unit
s1(i,n)$(ord(n) < card(n))..                                                                                                             Ts(i,n+1) =G= Tf(i,n);
*s2(i,n)$(ord(n) < card(n))..                                                                                                             Ts(i,n+1) =L= Tf(i,n) + M*(1 - (sum(nn$(ord(nn) <= ord(n))),sum(nnn$((ord(nnn) >= ord(nn)) and (ord(nnn) <= (ord(nn)+dn))),w(i,nn,nnn))) - sum(nnn,sum(nn$((ord(nn) >= ord(nnn)) and (ord(nn) < ord(n)) and (ord(nn) <= (ord(nnn)+dn))),w(i,nnn,nn))))) + M*sum(nn$((ord(nn) >= (ord(n)-dn)) and (ord(nn) <= ord(n))),w(i,nn,n));
* s2 only if dn>0
* Different Tasks in the Same Unit
s3(i,ii,j,n)$((ij(i,j)) and (ij(ii,j)) and (ord(i) ne ord(ii)) and (ord(n) < card(n)))..                                                          Ts(i,n+1) =G= Tf(ii,n);
* Different Tasks in Different units
s4(s,i,ii,j,jj,n)$((isc(i,s)) and (ij(i,j)) and (isp(ii,s)) and (ij(ii,jj)) and (ord(i) ne ord(ii)) and (ord(j) ne ord(jj)) and (ord(n) < card(n)))..  Ts(i,n+1) =G= Tf(ii,n) - M*(1 - sum(nn$((ord(nn) >= (ord(n)-dn)) and (ord(nn) <= ord(n))),w(ii,nn,n)));
$Ontext
----------------------------Tightening Constraints------------------------------
$Offtext
t1(j).. sum(i$(ij(i,j)),sum(n,sum(nn$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn))),(alpha(i)*w(i,n,nn)) + (beta(i)*b(i,n,nn))))) =L= H;
$Ontext
-----------------------------Resource Constraints-------------------------------
$Offtext
*r1(u,n)..                                sum(i$(iu(i,u)),gamma(i,u)*(sum(nn$(ord(nn) <= ord(n)),sum(nnn$((ord(nnn) >= ord(nn)) and (ord(nnn) <= (ord(nn)+dn))),w(i,nn,nnn))) - sum(nnn,sum(nn$((ord(nn) < ord(n)) and (ord(nn) >= ord(nnn)) and (ord(nn) <= (ord(nnn)+dn))),w(i,nnn,nn))))) + sum(i$(iu(i,u)),delta(i,u)*(sum(nn$(ord(nn) <= ord(n)),sum(nnn$((ord(nnn) >= ord(nn)) and (ord(nnn) <= (ord(nn)+dn))),b(i,nn,nnn))) - sum(nnn,sum(nn$((ord(nn) < ord(n)) and (ord(nn) >= ord(nnn)) and (ord(nn) <= (ord(nnn)+dn))),b(i,nnn,nn))))) =L= U_max(u);
*r2(u,n)$(ord(n) < card(n))..             Tut(u,n+1) =G= Tut(u,n);
*r3(u,i$(iu(i,u)),n)..                    Tut(u,n) =G= Ts(i,n) - M*(1 - ((sum(nn$(ord(nn) <= ord(n)),sum(nnn$((ord(nnn) >= ord(nn)) and (ord(nnn) <= (ord(nn)+dn))),w(i,nn,nnn))) - sum(nnn,sum(nn$((ord(nn) < ord(n)) and (ord(nn) >= ord(nnn)) and (ord(nn) <= (ord(nnn)+dn))),w(i,nnn,nn))))));
*r4(u,i$(iu(i,u)),n)..                    Tut(u,n) =L= Ts(i,n) + M*(1 - ((sum(nn$(ord(nn) <= ord(n)),sum(nnn$((ord(nnn) >= ord(nn)) and (ord(nnn) <= (ord(nn)+dn))),w(i,nn,nnn))) - sum(nnn,sum(nn$((ord(nn) < ord(n)) and (ord(nn) >= ord(nnn)) and (ord(nn) <= (ord(nnn)+dn))),w(i,nnn,nn))))));
*r5(u,i$(iu(i,u)),n)$(ord(n) ne 1)..      Tf(i,n-1) =G= Tut(u,n) - M*(1 - (sum(nn$(ord(nn) <= (ord(n)-1)),sum(nnn$((ord(nnn) >= ord(nn)) and (ord(nnn) <= (ord(nn)+dn))),w(i,nn,nnn))) - sum(nnn,sum(nn$((ord(nn) < (ord(n)-1)) and (ord(nn) >= ord(nnn)) and (ord(nn) <= (ord(nnn)+dn))),w(i,nnn,nn))))) - M*sum(nn$((ord(nn) >= (ord(n)-1-dn)) and (ord(nn) <= (ord(n)-1))),w(i,nn,n-1));
*r6(u,i$(iu(i,u)),n)$(ord(n) ne 1)..      Tf(i,n-1) =L= Tut(u,n) + M*(1 - (sum(nn$(ord(nn) <= (ord(n)-1)),sum(nnn$((ord(nnn) >= ord(nn)) and (ord(nnn) <= (ord(nn)+dn))),w(i,nn,nnn))) - sum(nnn,sum(nn$((ord(nn) < (ord(n)-1)) and (ord(nn) >= ord(nnn)) and (ord(nn) <= (ord(nnn)+dn))),w(i,nnn,nn)))));
*Why the difference in r5 and r6?
$Ontext
--------------------------Storage Policy Constraints----------------------------
$Offtext
sp1(s,i,ii,j,jj,n)$((isc(i,s)) and (ij(i,j)) and (isp(ii,s)) and (ij(ii,jj)) and (ord(i) ne ord(ii)) and (ord(j) ne ord(jj)) and (ord(n) < card(n))).. Ts(i,n+1) =L= Tf(ii,n) + M*(2 - sum(nn$((ord(nn) >= (ord(n)-dn)) and (ord(nn) <= ord(n))),w(ii,nn,n)) - sum(nn$((ord(nn) >= (ord(n)+1)) and (ord(nn) <= (ord(n)+1+dn))),w(i,n+1,nn)));
*sp2(s,n)$(szw(s) or snis(s))..                                                                                                           ST(s,n) =E= 0;
sp3(s,n)$(sdfis(s))..                                                                                                                    ST(s,n) =L= ST_max(s);
*sp4(s)$szw(s)..                                                                                                                          sum(n,ST(s,n) + sum(i$(isp(i,s)),sum(nn$((ord(nn) >= (ord(n)-dn)) and (ord(nn) <= ord(n))),b(i,nn,n)))) =E= 0;
sp5(s,i,ii,j,jj,n)$((sdfis(s)) and (isc(i,s)) and (ij(i,j)) and (isp(ii,s)) and (ij(ii,jj)) and (ord(i) ne ord(ii)) and (ord(j) ne ord(jj)))..             Tf(ii,n) =G= Ts(i,n) - M*(1 - sum(nn$((ord(nn) >= (ord(n)-dn)) and (ord(nn) <= ord(n))),w(ii,nn,n)));
$Ontext
--------------------------------Variable Bounds---------------------------------
$Offtext
b1(i,n,nn)$(ord(nn) < ord(n)).. w(i,n,nn) =E= 0;
b2(i,n,nn)$(ord(nn) < ord(n)).. b(i,n,nn) =E= 0;
Ts.UP(i,n) = H;
Tf.UP(i,n) = H;
*Tut.UP(u,n) = H;
b.UP(i,n,nn) = B_max(i);
ST_0.UP(s) = ST0(s);
*Tut.FX(u,'n1') = 0;
ST_0.FX(s)$(not sr(s)) = 0;
$Ontext
-------------------------------Objective Function-------------------------------
$Offtext
* Profit Maximisation
of..  Profit =E= sum(s$(sp(s)),p(s)*sum(n$(ord(n) = card(n)),ST(s,n) + sum(i$(isp(i,s)),rho(i,s)*sum(nn$((ord(nn) >= (ord(n)-dn)) and (ord(nn) <= ord(n))),b(i,nn,n)))));
* Makespan Minimisation
*of(i,n)$(ord(n) = card(n))..  Tf(i,n) =L= MS;
*of2(s$sf(s))..                ST(s,card(n)) + sum(n,sum(i$(isp(i,s)),rho(i,s)*sum(nn$((ord(nn) >= (ord(n)-dn)) and (ord(nn) <= ord(n))),b(i,nn,n)))) =G= D(s);

Model Shaik_Floudas_2009_1 /all/;
Option SYSOUT = ON;
Options LIMROW = 1e9;
Options MIP = CPLEX;
Shaik_Floudas_2009_1.optfile=1
$onecho > cplex.opt
iis              1
$offecho
Solve Shaik_Floudas_2009_1 using MIP maximising Profit;

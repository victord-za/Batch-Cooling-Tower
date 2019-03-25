$Title Shaik_Floudas_2009_1
$Ontext
         Novel unified modeling approach for short-term scheduling (2009)
         M.A. Shaik & C.A. Floudas
         Example 1
$Offtext
Sets
i                Tasks
                 //
ij(i,j)          Tasks which can be performed in unit j
                 //
is(i,s)          Tasks which process state s and either produce or consume
                 //
isc(i,s)         Tasks which consume state s
                 //
isp(i,s)         Tasks which produce state s
                 //
iu(i,u)          Tasks which consume utility u
                 //
j                Units
                 //
ji(j,i)          Units which are suitable for performing task i
                 //
n                Events
                 //
s                States
                 //
sp(s)            States that are final products
                 //
sr(s)            States that are raw materials
                 //
sdfis(s)         States with dedicated finite intermediate storage
                 //
snis(s)          States with no intermediate storage
                 //
szw(s)           States with zero wait storage
                 //
u                Utilities
                 //
;
Alias
(i,ii),(j,jj),(n,nn,nnn)
;
Positive variables
b(i,n,nn)        Amount of material undertaking task i that starts at event n and ends at event nn
ST0(sr)          Initial amount of state that is required from external resources
ST(s,n)          Excess amount of state s that needs to be stored at event point n
Ts(i,n)          Time at which task i starts at event n
Tf(i,n)          Time at which task i ends at event n
Tut(u,n)         Time at which there is a change in the consumption of utility u at event n
;
Binary variables
w(i,n,nn)        Binary variable for assignment of task i that starts at event n and ends at event nn
;
Free variables

;
Parameters
alpha(i)         Coefficient of constant term of processing time of task i
                 //
beta(i)          Coefficient of variable term of processing time of task i
                 //
B_min(i)         Minimum capacity of task i
                 //
B_max(i)         Maximum capacity of task i
                 //
D(s)             Demand for state s
                 //
delta(i,u)       Coefficient of variable term of consumption of utility u by task i
                 //
gamma(i,u)       Coefficient of constant term of consumption of utility u by task i
                 //
p(s)             Price of state s
                 //
rho(i,s)         Proportion of state s produced (>0) or consumed (<0) by task i
                 //
ST_0(s)          Initial amount of state s available
                 //
ST_max(s)        Maxumum amount of state s
                 //
U_max(u)         Maximum availability of utility u
                 //
;
Scalars
dn               Limit on the maximum number of events over which task i is allowed to continue
                 //
H                Short-term time horizon
                 //
M                Large positive number in big-M constraints
                 //
;
Equations
a1,a2,a3,a4,a5           Allocation constraints
c1,c2                    Capacity constraints
mb1,mb2                  Mass balance constraints
d1,d2,d3,d4              Duration constraints
s1,s2,s3,s4              Sequencing constraints
t1                       Tightening constraints
r1,r2,r3,r4,r5,r6        Resource constraints
;
$Ontext
----------------------------Allocation Constraints------------------------------
$Offtext
a1(j,n)..                sum(i$(ij(i,j)),sum(nn$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn))),w(i,n,nn))) =L= 1;
a2(j,nn)..               sum(i$(ij(i,j)),sum(n$((ord(n) >= (ord(nn)-dn)) and (ord(n) <= ord(nn))),w(i,n,nn))) =L= 1;
*a2 only if dn>0
a3(i$(ij(i,j)),j,n)..    sum(ii$(ij(i,j) and (ord(ii) ne ord(i))),sum(nn$((ord(nn) >= (ord(n)-dn)) and (ord(nn) <= ord(n))),w(ii,nn,n))) =L= 1 - sum(nn$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn))),w(i,n,nn));
*a3 only if dn>0
*ij(ii,j) or ij(i,j) in first summation?
a4(i,n)$(ord(n) ne 1)..  sum(nn$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n+dn))),w(i,n,nn)) =L= 1 - sum(nn$(ord(nn) < ord(n)),sum(nnn$((ord(nnn) >= ord(nn)) and (ord(nnn) <= (ord(nn)+dn))),sum(j$(ji(j,i)),sum(ii$(ij(i,j)),w(ii,nn,nnn))))) + sum(nnn,sum(nn$((ord(nn) < ord(n)) and (ord(nn) >= ord(nnn)) and (ord(nn) <= (ord(nnn)+dn))),sum(j$(ji(j,i)),sum(ii$(ij(i,j)),w(ii,nnn,nn))));
*a4 only if dn>0
*Might need additional closing bracket at end of last term
a5(i,n)$(ord(n) ne 1)..  sum(nn$((ord(nn) >= (ord(n)-dn)) and (ord(nn) <= ord(n))),w(i,nn,n)) =L= sum(nn$(ord(nn) <= ord(n)),sum(nnn$((ord(nnn) >= ord(nn)) and (ord(nnn) <= (ord(nn)+dn))),w(i,nn,nnn))) - sum(nnn,sum(nn$((ord(nn) < ord(n)) and (ord(nn) >= ord(nnn)) and (ord(nn) <= (ord(nnn)+dn))),w(i,nnn,nn)));
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
d2(i,n)..                                                        Tf(i,n) =G= Ts(i,n);
d3(i,n,nn)$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn)))..  Tf(i,nn) =G= Ts(i,n) + (alpha(i)*w(i,n,nn)) + (beta(i)*b(i,n,nn)) - M*(1-w(i,n,nn));
d4(i,n,nn)$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn)))..  Tf(i,nn) =L= Ts(i,n) + (alpha(i)*w(i,n,nn)) + (beta(i)*b(i,n,nn)) + M*(1-w(i,n,nn));
$Ontext
----------------------------Sequencing Constraints------------------------------
$Offtext
* Same Task in the Same Unit
s1(i,n)$(ord(n) < card(n))..                                                                                                             Ts(i,n+1) =G= Tf(i,n);
s2(i,n)$(ord(n) < card(n))..                                                                                                             Ts(i,n+1) =L= Tf(i,n) + M*(1 - (sum(nn$(ord(nn) <= ord(n))),sum(nnn$((ord(nnn) >= ord(nn)) and (ord(nnn) <= (ord(nn)+dn))),w(i,nn,nnn))) - sum(nnn,sum(nn$((ord(nn) >= ord(nnn)) and (ord(nn) < ord(n)) and (ord(nn) <= (ord(nnn)+dn))),w(i,nnn,nn))))) + M*sum(nn$((ord(nn) >= (ord(n)-dn)) and (ord(nn) <= ord(n))),w(i,nn,n));
* s2 only if dn>0
* Different Tasks in the Same Unit
s3(i$(ij(i,j)),ii$(ij(i,j)),j,n)$((ord(i) ne ord(ii)) and (ord(n) < card(n)))..                                                          Ts(i,n+1) =G= Tf(ii,n);
* Different Tasks in Different units
s4(s,i$(isc(i,s) and ij(i,j)),ii$(isp(i,s) and ij(i,jj)),j,jj,n)$((ord(i) ne ord(ii)) and (ord(j) ne ord(jj)) and (ord(n) < card(n)))..  Ts(i,n+1) =G= Tf(ii,n) - M*(1 - sum(nn$((ord(nn) >= (ord(n)-dn)) and (ord(nn) <= ord(n))),w(ii,nn,n)));
$Ontext
----------------------------Tightening Constraints------------------------------
$Offtext
t1(j).. sum(i$(ij(i,j)),sum(n,sum(nn$((ord(nn) >= ord(n)) and (ord(nn) <= (ord(n)+dn))),(alpha(i)*w(i,n,nn)) + (beta(i)*b(i,n,nn))))) =L= H;
$Ontext
-----------------------------Resource Constraints-------------------------------
$Offtext
r1(u,n)..                                sum(i$(iu(i,u)),gamma(i,u)*(sum(nn$(ord(nn) <= ord(n)),sum(nnn$((ord(nnn) >= ord(nn)) and (ord(nnn) <= (ord(nn)+dn))),w(i,nn,nnn))) - sum(nnn,sum(nn$((ord(nn) < ord(n)) and (ord(nn) >= ord(nnn)) and (ord(nn) <= (ord(nnn)+dn))),w(i,nnn,nn))))) + sum(i$(iu(i,u)),delta(i,u)*(sum(nn$(ord(nn) <= ord(n)),sum(nnn$((ord(nnn) >= ord(nn)) and (ord(nnn) <= (ord(nn)+dn))),b(i,nn,nnn))) - sum(nnn,sum(nn$((ord(nn) < ord(n)) and (ord(nn) >= ord(nnn)) and (ord(nn) <= (ord(nnn)+dn))),b(i,nnn,nn))))) =L= U_max(u);
r2(u,n)$(ord(n) < card(n))..             Tut(u,n+1) =G= Tut(u,n);
r3(u,i$(iu(i,u)),n)..                    Tut(u,n) =G= Ts(i,n) - M*(1 - ((sum(nn$(ord(nn) <= ord(n)),sum(nnn$((ord(nnn) >= ord(nn)) and (ord(nnn) <= (ord(nn)+dn))),w(i,nn,nnn))) - sum(nnn,sum(nn$((ord(nn) < ord(n)) and (ord(nn) >= ord(nnn)) and (ord(nn) <= (ord(nnn)+dn))),w(i,nnn,nn))))));
r4(u,i$(iu(i,u)),n)..                    Tut(u,n) =L= Ts(i,n) + M*(1 - ((sum(nn$(ord(nn) <= ord(n)),sum(nnn$((ord(nnn) >= ord(nn)) and (ord(nnn) <= (ord(nn)+dn))),w(i,nn,nnn))) - sum(nnn,sum(nn$((ord(nn) < ord(n)) and (ord(nn) >= ord(nnn)) and (ord(nn) <= (ord(nnn)+dn))),w(i,nnn,nn))))));
r5(u,i$(iu(i,u)),n)$(ord(n) ne 1)..      Tf(i,n-1) =G= Tut(u,n) - M*(1 - (sum(nn$(ord(nn) <= (ord(n)-1)),sum(nnn$((ord(nnn) >= ord(nn)) and (ord(nnn) <= (ord(nn)+dn))),w(i,nn,nnn))) - sum(nnn,sum(nn$((ord(nn) < (ord(n)-1)) and (ord(nn) >= ord(nnn)) and (ord(nn) <= (ord(nnn)+dn))),w(i,nnn,nn))))) - M*sum(nn$((ord(nn) >= (ord(n)-1-dn)) and (ord(nn) <= (ord(n)-1))),w(i,nn,n-1));
r6(u,i$(iu(i,u)),n)$(ord(n) ne 1)..      Tf(i,n-1) =L= Tut(u,n) + M*(1 - (sum(nn$(ord(nn) <= (ord(n)-1)),sum(nnn$((ord(nnn) >= ord(nn)) and (ord(nnn) <= (ord(nn)+dn))),w(i,nn,nnn))) - sum(nnn,sum(nn$((ord(nn) < (ord(n)-1)) and (ord(nn) >= ord(nnn)) and (ord(nn) <= (ord(nnn)+dn))),w(i,nnn,nn)))));
*Why the difference in r5 and r6?      
$Title Maravelias_Grossmann_2003_1
$OnEmpty
$Ontext
         New General Continuous-Time State-Task Network Formulation for Short-Term Scheduling of Multipurpose Batch Plants (2003)
         C. T. Maravelias & I. E. Grossmann
         Example 1
$Offtext
Sets
i                Tasks
                 /i1*i8/
j                Equipment units
                 /j1*j4/
*r                Resource categories
*                 //
p                Time points
                 /p1*p8/
s                States
                 /s1*s9/
ij(i,j)          Set of tasks that can be scheduled on equipment unit j
                 /i1.j1,i2.j2,i3.j3,i4.j2,i5.j3,i6.j2,i7.j3,i8.j4/
is(i,s)          Set of tasks that use state s as input
                 /i1.s1,i2.s2,i2.s3,i3.s2,i3.s3,i4.s4,i4.s6,i5.s4,i5.s6,i6.s3,i6.s5,i7.s3,i7.s5,i8.s7/
*jt               Set of shared storage tanks
*                 //
*jts(jt,s)        Set of shared storage tanks in which state s can be stored
*                 //
os(i,s)           Set of tasks that produce state s
                 /i1.s4,i2.s6,i3.s6,i4.s5,i4.s8,i5.s5,i5.s8,i6.s7,i7.s7,i8.s5,i8.s9/
*sj(s,j)          Set of states that can be stored in shared storage tanks j
*                 //
* should this not be jt instead of j?
si(s,i)          Set of states consumed in task i
                 /s1.i1,s2.i2,s2.i3,s3.i2,s3.i3,s3.i6,s3.i7,s4.i4,s4.i5,s5.i6,s5.i7,s6.i4,s6.i5,s7.i8/
so(s,i)          Set of states produced from task i
                 /s4.i1,s5.i4,s5.i5,s5.i8,s6.i2,s6.i3,s7.i6,s7.i7,s8.i4,s8.i5,s9.i8/
zw(i)            Set of task that produce at least one ZW state
                 /i2,i3,i4,i5,i6,i7/
;
Alias
(p,pp)
;
Positive variables
Bs(i,p)          Batch size of task i that starts at time point p
Bp(i,p)          Batch size of task i that is being processed at time point p
Bf(i,p)          Batch size of task i that finishes at or before time point p
BI(i,s,p)        Amount of state s used as input for task i at time point p
BO(i,s,p)        Amount of state s produced from task i at or before time point p
D(i,p)           Duration of task i that starts at time point p
MS               Makespan
*RI(i,r,p)        Amount of utility r consumed at time point p by task i
*RO(i,r,p)        Amount of utility r released at or before time point p by task i
*R(r,p)           Amount of utility r utilized at time point p
SA(s,p)          Amount of state s available at time point p
SS(s,p)          Sales of state s at point p
T(p)             Time that corresponds to time point p
Ts(i,p)          Start time of task i that starts at time point p
Tf(i,p)          Finish time of task i that starts at time point p
;
Binary variables
V(j,s,p)         Binary variable indicating whether state s is stored in shared tank j during time period p
*same
Ws(i,p)          Binary variable indicating whether task i starts at time point p
Wp(i,p)          Binary variable indicating whether task i is being processed at time point p
Wf(i,p)          Binary variable indicating whether task i finishes at or before time point p
Zs(j,p)          Binary variable indicating whether a task in I(j) is assigned to start in unit j at time point p
Zp(j,p)          Binary variable indicating whether a task in I(j) is being processed in unit j at time point p
Zf(j,p)          Binary variable indicating whether a task in I(j) assigned to unit j finishes at or before time point p
;
Free variables
Z
;
Parameters
alpha(i)         Fixed duration of task i
                 /i1     0.667
                  i2     1.334
                  i3     1.334
                  i4     1.334
                  i5     1.334
                  i6     0.667
                  i7     0.667
                  i8     1.3342/
B_L(i)           Lower bound on the batch size of task i
                 /i1     0
                  i2     0
                  i3     0
                  i4     0
                  i5     0
                  i6     0
                  i7     0
                  i8     0/
B_U(i)           Upper bound on the batch size of task i
                 /i1     100
                  i2     50
                  i3     80
                  i4     50
                  i5     80
                  i6     50
                  i7     80
                  i8     200/
beta(i)          Variable duration of task i
                 /i1     0.00667
                  i2     0.02664
                  i3     0.01665
                  i4     0.02664
                  i5     0.01665
                  i6     0.01332
                  i7     0.008325
                  i8     0.00666/
Cs_0(s)          Initial amount of state s
                 /s1     1000
                  s2     1000
                  s3     1000
                  s4     0
                  s5     0
                  s6     0
                  s7     0
                  s8     0
                  s9     0/
Cs(s)            Storage capacity for state s
                 /s1     1000
                  s2     1000
                  s3     1000
                  s4     100
                  s5     200
                  s6     150
                  s7     200
                  s8     1000
                  s9     1000/
Cj(j)            Storage capacity for shared tank j
                 //
* Again, should this not be for jt?
de(s)            Demand of state s at the end of time horizon
                 //
*R_U(r)           Upper bound for utility r
*                 //
zeta(s)          Price of state s
                 /s1     0
                  s2     0
                  s3     0
                  s4     0
                  s5     0
                  s6     0
                  s7     0
                  s8     10
                  s9     10/
;
Scalars
H                Time horizon
                 /12/
;
$Ontext
Table delta(i,r) Variable amount of utility r required for task i
                 r1      r2
         i1
         i2
;
Table gamma(i,r) Fixed amount of utility r required for task i
                 r1      r2
         i1
         i2
;
*$Offtext
Table rho(i,s)   Mass balance coefficient for the consumption or production of state s in task i
                 s1      s2      s3      s4      s5      s6      s7      s8      s9
         i1      -1      0       0       1       0       0       0       0       0
         i2      0       -0.5    -0.5    0       0       1       0       0       0
         i3      0       -0.5    -0.5    0       0       1       0       0       0
         i4      0       0       0       -0.4    0.6     -0.6    0       0.4     0
         i5      0       0       0       -0.4    0.6     -0.6    0       0.4     0
         i6      0       0       -0.2    0       -0.8    0       1       0       0
         i7      0       0       -0.2    0       -0.8    0       1       0       0
         i8      0       0       0       0       0.1     0       -1      0       0.9
;
$Offtext
*$Ontext
Table rho(i,s)   Mass balance coefficient for the consumption or production of state s in task i
                 s1      s2      s3      s4      s5      s6      s7      s8      s9
         i1      1       0       0       1       0       0       0       0       0
         i2      0       0.5     0.5     0       0       1       0       0       0
         i3      0       0.5     0.5     0       0       1       0       0       0
         i4      0       0       0       0.4     0.6     0.6     0       0.4     0
         i5      0       0       0       0.4     0.6     0.6     0       0.4     0
         i6      0       0       0.2     0       0.8     0       1       0       0
         i7      0       0       0.2     0       0.8     0       1       0       0
         i8      0       0       0       0       0.1     0       1       0       0.9
;
*$Offtext
Equations
e1,e2,e3,e4,e5,e6,e7,e8
*,e9,e91
*e10,
e11,e12,e13,e14,e15,e16,e17,e18,e181,e19,e191
e20,e21,e22,e231,e232,e241,e242,e251,e252,e26,e27,e28,e29
e30
*,e31,e32,
e34,e35,e36
e82
;
e1(p)$(ord(p) = 1)..                     T(p) =E= 0;
e2(p)$(ord(p) = card(p))..               T(p) =E= H;
e3(p)$(ord(p) ne card(p))..              T(p+1) =G= T(p);
*e3(p)..                                  T(p+1) =G= T(p);
e4(j,p)..                                sum(i$(ij(i,j)),Ws(i,p)) =L= 1;
e5(j,p)..                                sum(i$(ij(i,j)),Wf(i,p)) =L= 1;
e6(i)..                                  sum(p,Ws(i,p)) =E= sum(p,Wf(i,p));
e7(s,p)$(ord(p) ne 1)..                  SA(s,p) + SS(s,p) =E= SA(s,p-1) + sum(i$(os(i,s)),BO(i,s,p)) - sum(i$(is(i,s)),BI(i,s,p));
e8(s,p)..                                SA(s,p) =L= Cs(s);
*e81(s,p)$(ord(p) = 1)..                  SA(s,p) =L= Cs_0(s);
e82(s,p)$(ord(p) = 1)..                  SA(s,p) + SS(s,p) =E= CS_0(s) + sum(i$(os(i,s)),BO(i,s,p)) - sum(i$(is(i,s)),BI(i,s,p));
*e9(r,p)$(ord(p) ne 1)..                  R(r,p) =E= R(r,p-1) - sum(i,RO(i,r,p-1)) + sum(i,RI(i,r,p));
*e91(r,p)$(ord(p) = 1)..                  R(r,p) =E= sum(i,RI(i,r,p));
*e10(r,p)..                               R(r,p) =L= R_U(r);
e11..                                    Z =E= sum(s,sum(p,zeta(s)*SS(s,p)));
e12(j,p)..                               sum(i$(ij(i,j)),sum(pp$(ord(pp) le ord(p)),Ws(i,pp) - Wf(i,pp))) =L= 1;
e13(i,p)$(ord(p) = 1)..                  Wf(i,p) =E= 0;
*Should this not be for p1?
e14(i,p)$(ord(p) = card(p))..            Ws(i,p) =E= 0;
e15(i,p)..                               D(i,p) =E= (alpha(i)*Ws(i,p)) + (beta(i)*Bs(i,p));
e16(i,p)..                               Tf(i,p) =L= Ts(i,p) + D(i,p) + H*(1-Ws(i,p));
e17(i,p)..                               Tf(i,p) =G= Ts(i,p) + D(i,p) - H*(1-Ws(i,p));
e18(i,p)$(ord(p) ne 1)..                 Tf(i,p) - Tf(i,p-1) =L= H*Ws(i,p);
e181(i,p)$(ord(p) = 1)..                 Tf(i,p) =L= H*Ws(i,p);
e19(i,p)$(ord(p) ne 1)..                 Tf(i,p) - Tf(i,p-1) =G= D(i,p);
e191(i,p)$(ord(p) = 1)..                 Tf(i,p) =G= D(i,p);
e20(i,p)..                               Ts(i,p) =E= T(p);
e21(i,p)$(ord(p) ne 1)..                 Tf(i,p-1) =L= T(p) + H*(1-Wf(i,p));
e22(i,p)$((zw(i)) and (ord(p) ne 1))..   Tf(i,p-1) =G= T(p) - H*(1-Wf(i,p));
e231(i,p)..                              Bs(i,p) =G= B_L(i)*Ws(i,p);
e232(i,p)..                              Bs(i,p) =L= B_U(i)*Ws(i,p);
e241(i,p)..                              Bf(i,p) =G= B_L(i)*Wf(i,p);
e242(i,p)..                              Bf(i,p) =L= B_U(i)*Wf(i,p);
e251(i,p)..                              Bp(i,p) =G= B_L(i)*(sum(pp$(ord(pp) lt ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
e252(i,p)..                              Bp(i,p) =L= B_U(i)*(sum(pp$(ord(pp) lt ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
e26(i,p)$(ord(p) gt 1)..                 Bs(i,p-1) + Bp(i,p-1) =E= Bp(i,p) + Bf(i,p);
e27(i,s,p)$(si(s,i))..                   BI(i,s,p) =E= rho(i,s)*Bs(i,p);
e28(i,s,p)$(si(s,i))..                   BI(i,s,p) =L= B_U(i)*rho(i,s)*Ws(i,p);
e29(i,s,p)$(so(s,i))..                   BO(i,s,p) =E= rho(i,s)*Bf(i,p);
e30(i,s,p)$(so(s,i))..                   BO(i,s,p) =L= B_U(i)*rho(i,s)*Wf(i,p);
*e31(i,r,p)..                             RI(i,r,p) =E= (gamma(i,r)*Ws(i,p)) + (delta(i,r)*Bs(i,p));
*e32(i,r,p)..                             RO(i,r,p) =E= (gamma(i,r)*Wf(i,p)) + (delta(i,r)*Bf(i,p));
* delta(i,r) not (i,r,s)?
e34(j)..                                 sum(i$(ij(i,j)),sum(p,D(i,p))) =L= H;
e35(j,p)..                               sum(i$(ij(i,j)),sum(pp$(ord(pp) ge ord(p)),D(i,pp))) =L= H - T(p);
e36(j,p)..                               sum(i$(ij(i,j)),sum(pp$(ord(pp) le ord(p)),(alpha(i)*Wf(i,pp)) + (beta(i)*Bf(i,pp)))) =L= T(p);

$Ontext
SA.fx('s8','p1') = 0;
SA.fx('s9','p1') = 0;
SS.fx('s8','p1') = 0;
SS.fx('s9','p1') = 0;
SS.fx(s,'p1') = 0;
SS.fx(s,'p2') = 0;
SS.fx(s,'p3') = 0;
SS.fx(s,'p4') = 0;
SS.fx(s,'p5') = 0;
$Offtext
Model Maravelias_Grossmann_2003_1 /all/;
Option SYSOUT = ON;
Options LIMROW = 1e9;
Options MIP = CPLEX;
*Maravelias_Grossmann_2003_1.optfile=1
*$onecho > cplex.opt
*iis              1
*$offecho
Solve Maravelias_Grossmann_2003_1 using MIP maximising Z;



$Title Moodley_Majozi_2008_4
$Ontext
         Simultaneous targeting and design for cooling water systems with multiple cooling water supplies (2008)
         A. Moodley & T. Majozi
         Example 4
         Illustrative Example: Multiple Source Targeting
         Unified Targeting - Maximum Reuse
         Targeting With Cooling Water Return Temperature Limitation
         Includes additional fourth constraint for each of the linearisation variables.
         This formulation works when Tret is defined as a parameter and calculated after the solve
         When Tret is defined as a variable, the solution is obtained when appropriate lower bound is assigned to the cooling water required.
         Solution procedure:
                 1) Solve LP minimising sto0
                 2) Solve LP minimising CW
                 3) Solve MINLP minimising sto and calculating Tc and Th
                 4) Free sto0 and CW
                 5) Solve MINLP minimising CW
                 6) Solve MINLP minimising sto

         Alternatively, solve Tret as a parameter as in Moodley.
         Check errors on Tout, CS and G2
$Offtext
Sets
i                Cooling-water-using operations that complies with a mass and energy balance of a counter current heat exchanger\
                 /i1*i6/
n                Cooling water sources supplying the cooling water network
                 /n1*n3/
p                Time points
                 /p1*p5/
;
Alias
(i,ii)
;
Positive Variables
CR(i,n,p)        Return cooling water flow from cooling-water-using operation i to cooling water source n (t.h^-1)
CS(i,n,p)        Cooling water flow supplied from cooling water source n to cooling-water-using operation i (t.h^-1)
Fin(i,p)         Total cooling water flow into cooling-water-using operation i including supply and reused water (t.h^-1)
Fout(i,p)        Total cooling water flow from cooling-water-using operation i including return and reused water (t.h^-1)
FR(ii,i,p)       Reused cooling water flow from any other cooling-water-using operation ip to cooling-water-using operation i (t.h^-1)
mC0              Initial mass of cold water in storage tank (t)
mC(p)            Mass of cold water in storage tank at the start of time point p (t)
mH0              Initial mass of hot water in storage tank (t)
mH(p)            Mass of hot water in storage tank at the start of time point p (t)
mHf              Maximum Amount of Storage Required for Hot Water Across All Time Points (t)
mCf              Maximum Amount of Storage Required for Cold Water Across All Time Points (t)
OS(n)            Total cooling water flow supplied from cooling water source n (t.h^-1)
QCin(n,p)        Cooling water flow rate from cooling tower n into cold water storage tank at time point p (t.h^-1)
QCout(i,p)       Cooling water flow rate from cold water storage tank into cooling water using operation i at time point p (t.h^-1)
QHin(i,p)        Cooling water flow rate from cooling water using operation i to hot water storage tank at time point p (t.h^-1)
QHout(n,p)       Cooling water flow rate from hot water storage tank to cooling tower n at time point p (t.h^-1)
Tc(p)            Temperature of cold water storage tank (C)
Th(p)            Temperature of hot water storage tank (C)


G1(i,n,p)        Linearisation variable 1 for term CR(i.n.p)*Tout(i.p)
G2(ii,i,p)       Linearisation variable 2 for term FR(ii.i.p)*Tout(ii.p)
G3(i,p)          Linearisation variable 3 for term Fin(i.p)*Tout(i.p)
G4(n,p)          Linearisation variable 4 for term QHout(n.p)*Th(p)
G5(i,p)          Linearisation variable 5 for term QCout(i.p)*Tc(p)
Tin(i,p)         Inlet cooling water temperature to cooling-water-using operation i (C)
Tout(i,p)        Outlet cooling water temperature from cooling-water-using operation i (C)
Tret(n,p)        Return temperature to cooling water source n (C)
;
Binary Variables
yCin(p)          Binary variable controlling inlet of cold storage tank water.
yCout(p)         Binary variable controlling outlet of cold storage tank water.
yHin(p)          Binary variable controlling inlet of hot storage tank water.
yHout(p)         Binary variable controlling outlet of hot storage tank water.
;
Free Variables
CW               Total cooling water flow supplied from all cooling water sources (t.h^-1)
sto              Design capacity of both storage tanks (t)
sto0             Total initial amount of water in storage tanks (t)
;
Parameters
Fin_U(i)         Maximum flowrate through cooling-water-using operation i (t.h^-1)
OS_U(n)          Design capacity of cooling water source n (t.h^-1)
                 /n1     30
                  n2     40
                  n3     40/
Q(i)             Duty of cooling-water-using operation i (kW)
                 /i1     610
                  i2     420
                  i3     800
                  i4     555
                  i5     345
                  i6     700/
T(n)             Cooling water supply temperature from cooling water source n (C)
                 /n1     20
                  n2     22
                  n3     25/
Tau(p)           Duration of time slot p (h)
                 /p1     3
                  p2     1
                  p3     4
                  p4     2
                  p5     1/
Thmax            Maximum temperature of hot storage tank (C)
Tin_U(i)         Limiting inlet temperature to cooling-water-using operation i (C)
                 /i1     30
                  i2     40
                  i3     25
                  i4     45
                  i5     40
                  i6     30/
Tout_U(i)        Limiting outlet temperature from cooling-water-using operation i (C)
                 /i1     45
                  i2     60
                  i3     50
                  i4     53
                  i5     55
                  i6     45/
Tret_U(n)        Maximum return temperature to cooling water source n (C)
                 /n1     52
                  n2     52
                  n3     50/
*Tret(n)
;
Scalars
cp               Specific heat capacity of water (J.(kg.C)^-1)
                 /4187/
M                Large value
                 /999999999/
Tamb             Ambient temperature (C)
                 /25/
Tcse             Estimated cold storage tank temperature (C)
                 /22/
Tout_L           Limiting outlet temperature from cooling-water-using operation i (C)
                 /30/
;
Table    y(i,p)  Binary parameter indicating activity of cooling water using operation i during time slot p
                 p1      p2      p3      p4      p5
         i1      1       1       0       0       0
         i2      1       1       1       1       0
         i3      1       1       1       0       0
         i4      0       1       1       1       1
         i5      0       0       1       1       1
         i6      0       0       0       0       1
;
Fin_U(i) = Q(i)*3600/(cp*(Tout_U(i)-Tin_U(i)));
Thmax = smax(i,Tout_U(i));
CW.l =40;
Equations
e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19,e20,e21,e22,e23,e24,e25       General Model
e26,e27,e28,e29,e30,e31,e32,e33,e34,e35,e36,e37,e38,e39,e40,e41,e42,e43,e44,e45,e46,e47          Linear Model
e48,e49,e50,e51,e52,e53,e54,e55,e56,e57,e58,e59                                                  Nonlinear Model
e401,e411,e441,e451
;
$Ontext
---------------------------------General Model----------------------------------
$Offtext

e1..                              CW =E= sum(n,OS(n));
e2(n,p)..                         OS(n) =E= sum(i,CS(i,n,p)) + QCin(n,p);
e3(n,p)..                         OS(n) =E= sum(i,CR(i,n,p)) + QHout(n,p);
e4(i,p)..                         Fin(i,p) =E= y(i,p)*(sum(n,CS(i,n,p)) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i,p)) + QCout(i,p));
e5(i,p)..                         Fout(i,p) =E= y(i,p)*(sum(n,CR(i,n,p)) + sum(ii$(ord(ii) ne ord(i)),FR(i,ii,p)) + QHin(i,p));
e6(i,p)..                         Fin(i,p) =E= Fout(i,p);
e7(n)..                           OS(n) =L= OS_U(n);
e8(i,p)..                         Tout(i,p) =L= Tout_U(i)*y(i,p);
e9(i,p)..                         Fin(i,p) =L= Fin_U(i)*y(i,p);
e10(p)$(ord(p) ne 1)..            mC(p) =E= mC(p-1) + sum(n,Tau(p)*QCin(n,p)) - sum(i,Tau(p)*QCout(i,p));
e11(p)$(ord(p) ne 1)..            mH(p) =E= mH(p-1) + sum(i,Tau(p)*QHin(i,p)) - sum(n,Tau(p)*QHout(n,p));
e12(p)$(ord(p) = 1)..             mC(p) =E= mC0 + sum(n,Tau(p)*QCin(n,p)) - sum(i,Tau(p)*QCout(i,p));
e13(p)$(ord(p) = 1)..             mH(p) =E= mH0 + sum(i,Tau(p)*QHin(i,p)) - sum(n,Tau(p)*QHout(n,p));
e14(ii,i,p)$(ord(ii) ne ord(i)).. FR(ii,i,p) =L= Fin_U(i)*y(i,p)*y(ii,p);
e15(i,p)..                        QCout(i,p) =L= Fin_U(i)*y(i,p);
e16(i,p)..                        QHin(i,p) =L= Fin_U(i)*y(i,p);
e17(i,n,p)..                      CR(i,n,p) =L= OS(n)*y(i,p);
e18(i,n,p)..                      CS(i,n,p) =L= OS(n)*y(i,p);
e19..                             sto0 =E= mC0 + mH0;
*e20(i,p)..                        QHin(i,p) =L= M*yHin(p);
*e21(n,p)..                        QHout(n,p) =L= M*yHout(p);
*e22(n,p)..                        QCin(n,p) =L= M*yCin(p);
*e23(i,p)..                        QCout(i,p) =L= M*yCout(p);
*e24(p)..                          yCin(p) + yCout(p) =L= 1;
*e25(p)..                          yHin(p) + yHout(p) =L= 1;

$Ontext
-------------------------------Linear Subproblem--------------------------------
$Offtext

e26(n,p)..                        sum(i,G1(i,n,p)) + G4(n,p) =L= Tret_U(n)*OS(n);
e27(i,p)..                        (Q(i)*3600/cp) + sum(n,CS(i,n,p)*T(n)) + sum(ii$(ord(ii) ne ord(i)),G2(ii,i,p)) + G5(i,p) =E= G3(i,p);

e28(i,n,p)..                      G1(i,n,p) =G= y(i,p)*((Fin_U(i)*Tout(i,p)) + (CR(i,n,p)*Tout_U(i)) - (Fin_U(i)*Tout_U(i)));
*e29(i,n,p)..                      G1(i,n,p) =L= Fin_U(i)*Tout(i,p) + CR(i,n,p)*Tout_L - Fin_U(i)*Tout_L;
e29(i,n,p)..                      G1(i,n,p) =L= y(i,p)*(Fin_U(i)*Tout(i,p) + CR(i,n,p)*Tout_L - Fin_U(i)*Tout_L);
*e29(i,n,p)..                      G1(i,n,p) =L= Fin_U(i)*Tout(i,p);
e30(i,n,p)..                      G1(i,n,p) =L= y(i,p)*CR(i,n,p)*Tout_U(i);
e31(i,n,p)..                      G1(i,n,p) =G= y(i,p)*CR(i,n,p)*Tout_L;

e32(ii,i,p)$(ord(ii) ne ord(i)).. G2(ii,i,p) =G= y(i,p)*y(ii,p)*((Fin_U(i)*Tout(ii,p)) + (FR(ii,i,p)*Tout_U(ii)) - (Fin_U(i)*Tout_U(ii)));
e33(ii,i,p)$(ord(ii) ne ord(i)).. G2(ii,i,p) =L= y(i,p)*y(ii,p)*(Fin_U(i)*Tout(ii,p) + FR(ii,i,p)*Tout_L - Fin_U(i)*Tout_L);
e34(ii,i,p)$(ord(ii) ne ord(i)).. G2(ii,i,p) =L= y(i,p)*y(ii,p)*FR(ii,i,p)*Tout_U(ii);
e35(ii,i,p)$(ord(ii) ne ord(i)).. G2(ii,i,p) =G= y(i,p)*y(ii,p)*FR(ii,i,p)*Tout_L;
*Tout_L*y(i,p)???
*Perhap G2 =G= RHS should always be 0
e36(i,p)..                        G3(i,p) =G= y(i,p)*((Fin_U(i)*Tout(i,p)) + (Fin(i,p)*Tout_U(i)) - (Fin_U(i)*Tout_U(i)));
e37(i,p)..                        G3(i,p) =L= y(i,p)*((Fin_U(i)*Tout(i,p)) + (Fin(i,p)*Tout_L) - (Fin_U(i)*Tout_L));
e38(i,p)..                        G3(i,p) =L= y(i,p)*Fin(i,p)*Tout_U(i);
e39(i,p)..                        G3(i,p) =G= y(i,p)*Fin(i,p)*Tout_L;
*Same
e40(n,p)$(ord(p) ne 1)..          G4(n,p) =G= (OS_U(n)*Th(p-1)) + (QHout(n,p)*Thmax) - (OS_U(n)*Thmax);
e401(n,p)$(ord(p) = 1)..          G4(n,p) =G= (OS_U(n)*Tamb) + (QHout(n,p)*Thmax) - (OS_U(n)*Thmax);
e41(n,p)$(ord(p) ne 1)..          G4(n,p) =L= (OS_U(n)*Th(p-1)) + (QHout(n,p)*0) - (OS_U(n)*0);
e411(n,p)$(ord(p) = 1)..          G4(n,p) =L= (OS_U(n)*Tamb) + (QHout(n,p)*0) - (OS_U(n)*0);
e42(n,p)..                        G4(n,p) =L= QHout(n,p)*Thmax;
e43(n,p)..                        G4(n,p) =G= QHout(n,p)*0;
* p-1?
e44(i,p)$(ord(p) ne 1)..          G5(i,p) =G= (Fin_U(i)*Tc(p-1)) + (QCout(i,p)*Tamb) - (Fin_U(i)*Tamb);
e441(i,p)$(ord(p) = 1)..          G5(i,p) =G= (Fin_U(i)*Tamb) + (QCout(i,p)*Tamb) - (Fin_U(i)*Tamb);
e45(i,p)$(ord(p) ne 1)..          G5(i,p) =L= (Fin_U(i)*Tc(p-1)) + (QCout(i,p)*0) - (Fin_U(i)*0);
e451(i,p)$(ord(p) = 1)..          G5(i,p) =L= (Fin_U(i)*Tamb) + (QCout(i,p)*0) - (Fin_U(i)*0);
e46(i,p)..                        G5(i,p) =L= QCout(i,p)*Tamb;
*e47(i,p)..                        G5(i,p) =G= QCout(i,p)*0;
*Try this linearisation, otherwise use estimated paramters for Tc and Th

$Ontext
------------------------------Nonlinear Subproblem------------------------------
$Offtext
$Ontext
e48..                             mHf =E= smax(p,mH(p));
e49..                             mCf =E= smax(p,mC(p));
e50..                             sto =E= mHf + mCf;
e51(p)$(ord(p) ne 1)..            0.1*(Tc(p)*(mC(p-1) + Tau(p)*(sum(n,QCin(n,p)) - sum(i,QCout(i,p))))) =E= 0.1*(mC(p-1)*Tc(p-1) + sum(n,QCin(n,p)*T(n))*Tau(p) - sum(i,QCout(i,p)*Tau(p)*Tc(p-1)));
e52(p)$(ord(p) = 1)..             Tc(p)*(mC0 + Tau(p)*(sum(n,QCin(n,p)) - sum(i,QCout(i,p)))) =E= mC0*Tamb + sum(n,QCin(n,p)*T(n))*Tau(p) - sum(i,QCout(i,p))*Tau(p)*Tamb;
e53(p)$(ord(p) ne 1)..            Th(p)*(mH(p-1) + Tau(p)*(sum(i,QHin(i,p)) - sum(n,QHout(n,p)))) =E= mH(p-1)*Th(p-1) + sum(i,QHin(i,p)*Tau(p)*Tout_U(i)) - sum(n,QHout(n,p))*Tau(p)*Th(p-1);
e54(p)$(ord(p) = 1)..             Th(p)*(mH0 + Tau(p)*(sum(i,QHin(i,p)) - sum(n,QHout(n,p)))) =E= mH0*Tamb + sum(i,QHin(i,p)*Tau(p)*Tout_U(i)) - sum(n,QHout(n,p))*Tau(p)*Tamb;

e55(i,p)$(ord(p) ne 1)..          0.1*((y(i,p)*Q(i)*3600/cp) + sum(n,CS(i,n,p)*T(n)) + (QCout(i,p)*Tc(p-1)) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i,p)*Tout_U(ii))) =E= 0.1*Fout(i,p)*Tout_U(i);
e56(i,p)$(ord(p) = 1)..           (y(i,p)*Q(i)*3600/cp) + sum(n,CS(i,n,p)*T(n)) + (QCout(i,p)*Tamb) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i,p)*Tout_U(ii)) =E= Fout(i,p)*Tout_U(i);

e57(n,p)..                        Tret(n,p)*OS(n) =E= sum(i, CR(i,n,p)*Tout(i,p)) + (QHout(n,p)*Th(p));
e58(n,p)..                        Tret(n,p) =L= Tret_U(n);
e59(i,p)..                        Tout(i,p) =G= Tout_L*y(i,p);

*$Ontext
-----------------------------------Boundaries-----------------------------------
*$Offtext

Tout.LO(i,p) = Tout_L;
Fin.UP(i,p) = Fin_U(i);
Tin.UP(i,p) = Tin_U(i);
Tout.UP(i,p) = Tout_U(i);
Tret.UP(n,p) = Tret_U(n);
OS.UP(n) = OS_U(n);
CW.LO = 40;
* The lower bound makes the problem solvable.

*$Ontext
Model Moodley_Majozi_2008_4_LP /e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19,e20,e21,e22,e23/;
Model Moodley_Majozi_2008_4_NLP /e1,e2,e3,e4,e5,e6,e7,e8,e9,e24,e25,e26,e27/;
Solve Moodley_Majozi_2008_4_LP using LP minimizing CW;
Solve Moodley_Majozi_2008_4_NLP using NLP minimizing CW;
$Offtext

Model Moodley_Majozi_2008_4a /e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19,e26,e27,e28,e29,e30,e31,e32,e33,e34,e35,e36,e37,e38,e39,e40,e41,e42,e43,e44,e45,e46,e401,e411,e441,e451/;
Option SYSOUT = ON;
Options LIMROW = 1e9
Options LP = CPLEX;
Moodley_Majozi_2008_4a.optfile=1
$onecho > cplex.opt
iis              1
$offecho
Solve Moodley_Majozi_2008_4a using MIP minimising sto0;
$Ontext
mC0.fx = mC0.l;
mH0.fx = mH0.l;

Model Moodley_Majozi_2008_4b /e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19,e20,e21,e22,e23,e24,e25,e26,e27,e28,e29,e30,e31,e32,e33,e34,e35,e36,e37,e38,e39,e40,e41,e42,e43,e44,e45,e46,e47/;
Option SYSOUT = ON;
Options LIMROW = 1e9
Options MIP = CPLEX;
Moodley_Majozi_2008_4b.optfile=1
*$onecho > cplex.opt
iis              1
*$offecho
Solve Moodley_Majozi_2008_4b using MIP minimising CW;

CW.fx = CW.l;

Model Moodley_Majozi_2008_4c /e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19,e20,e21,e22,e23,e24,e25,e26,e27,e28,e29,e30,e31,e32,e33,e34,e35,e36,e37,e38,e39,e40,e41,e42,e43,e44,e45,e46,e47,e48,e49,e50,e51,e52,e53,e54/;
*Include all equations?
Options SYSOUT = ON;
Options LIMROW = 1e9
Options MIP = CPLEX;
Moodley_Majozi_2008_4c.optfile=1
*$onecho > cplex.opt
iis              1
*$offecho
*$onecho > dicopt.opt
maxcycles        10000
*$offecho
Solve Moodley_Majozi_2008_4c using MINLP minimising sto;

* Freeing the fixed variables
CW.lo = -inf;
CW.up = inf;
mC0.lo = -inf;
mC0.up = inf;
mH0.lo = -inf;
mH0.up = inf;

Model Moodley_Majozi_2008_4d /e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19,e20,e21,e22,e23,e24,e25,e48,e49,e50,e51,e52,e53,e54,e55,e56,e57,e58,e59/;
Option SYSOUT = ON;
Options LIMROW = 1e9
Options MINLP = DICOPT;
Options MIP = CPLEX;
Moodley_Majozi_2008_4d.optfile=1
*$onecho > cplex.opt
iis              1
*$offecho
*$onecho > dicopt.opt
maxcycles        10000
*$offecho
Solve Moodley_Majozi_2008_4d using MINLP minimising CW;

CW.fx = CW.l;

Model Moodley_Majozi_2008_4e /e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19,e20,e21,e22,e23,e24,e25,e48,e49,e50,e51,e52,e53,e54,e55,e56,e57,e58,e59/;
Options SYSOUT = ON;
Options LIMROW = 1e9
Options MINLP = DICOPT;
Options MIP = CPLEX;
Moodley_Majozi_2008_4e.optfile=1
*$onecho > cplex.opt
iis              1
*$offecho
*$onecho > dicopt.opt
maxcycles        10000
*$offecho
Solve Moodley_Majozi_2008_4e using MINLP minimising sto;
$Offtext

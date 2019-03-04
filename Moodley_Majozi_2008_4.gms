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
                 1) Solve LP minimising CW
                 2) Solve LP minimising DC
                 3) Solve LP minimising R
                 4) Free sto0 and CW
                 5) Solve MINLP minimising sto0
                 6) Solve MINLP minimising CW
                 7) Solve MINLP minimising sto

         Alternatively, solve Tret as a parameter as in Moodley.
         Check if this formulation allows for back-recycling loops
         Check whether CW could not have been reduced by making use of storage?
         Check why cold blowdown outperformes hot blowdown
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
(i,ii),(n,nn)
;
Positive Variables
B(n,p)           Blowdown flow from cooling tower n at time point p (t.h^-1)
CR(n,i,p)        Return cooling water flow to cooling water source n from cooling-water-using operation i at time point p (t.h^-1)
CS(n,i,p)        Cooling water flow supplied from cooling water source n to cooling-water-using operation i at time point p (t.h^-1)
D(n,p)           Drift loss in cooling tower n at time point p (t.h^-1)
E(n,p)           Evaporation loss in cooling tower n at time point p (t.h^-1)
Fin(i,p)         Total cooling water flow into cooling-water-using operation i including supply and reused water at time point p(t.h^-1)
Fout(i,p)        Total cooling water flow from cooling-water-using operation i including return and reused water at time point p (t.h^-1)
FR(ii,i,p)       Reused cooling water flow from any other cooling-water-using operation ii to cooling-water-using operation i at time point p (t.h^-1)
M(n,p)           Makeup water flow to cooling tower n at time point p (t.h^-1)
OS(n,p)          Total cooling water flow supplied from cooling water source n (t.h^-1)
R(nn,n,p)        Cooling water recycled directly from cooling tower nn to cooling tower n at time point p
Ts(n,p)          Supply temperature from cooling tower n at time point p to cooling water network (C)
y1(n,i,p)        Linearisation variable 1 for term CR(n.i.p)*Tout(i.p)
y2(ii,i,p)       Linearisation variable 2 for term FR(ii.i.p)*Tout(ii.p)
y3(i,p)          Linearisation variable 3 for term Fin(i.p)*Tout(i.p)
y4(n,i,p)        Linearisation variable 4 for term CS(n.i.p)*Ts(n.p)
Tout(i,p)        Outlet cooling water temperature from cooling-water-using operation i at time point p(C)
TWin(n,p)        Return temperature to cooling water source n at time point p (C)
;
Free Variables
CW               Total cooling water flow supplied from all cooling water sources (t.h^-1)
DC               Total design capacity of all cooling towers (t.h^-1)
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
TWout(n)         Cooling water supply temperature from cooling water source n (C)
                 /n1     20
                  n2     22
                  n3     25/
Tau(p)           Duration of time slot p (h)
                 /p1     3
                  p2     1
                  p3     4
                  p4     2
                  p5     2/
Tcmin
Tin(i,p)         Inlet cooling water temperature to cooling-water-using operation i at time point p (C)
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
TWin_U(n)        Maximum return temperature to cooling water source n (C)
                 /n1     52
                  n2     52
                  n3     50/
*Tret(n)
;
Scalars
CC               Cycles of concentration
                 /4/
cp               Specific heat capacity of water (J.(kg.C)^-1)
                 /4187/
Tamb             Ambient temperature (C)
                 /25/
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
Tcmin = smin(n,TWout(n));
Equations
g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16                   General CWS Model
l1,l2,l3,l4,l5,l6,l7,l8,l9,l10,l11,l12,l13,l14,l15,l16,l17,l18,l19,l20   Linear CWS Model
n1,n2,n3,n4,n5,n6,n7,n8,n9,n10                                           Nonlinear CWS Model
;
$Ontext
---------------------------------General Model----------------------------------
$Offtext

g1(p)..                           CW =E= sum(n,OS(n,p));
g2(n,p)..                         OS(n,p) =E= sum(i,CS(n,i,p)) - M(n,p) + B(n,p);
g3(n,p)..                         OS(n,p) =E= sum(i,CR(n,i,p)) + sum(nn,R(nn,n,p)) - D(n,p) - E(n,p);
g4(i,p)..                         Fin(i,p) =E= y(i,p)*(sum(n,CS(n,i,p)) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i,p)));
g5(i,p)..                         Fout(i,p) =E= y(i,p)*(sum(n,CR(n,i,p)) + sum(ii$(ord(ii) ne ord(i)),FR(i,ii,p)));
g6(i,p)..                         Fin(i,p) =E= Fout(i,p);
g7(n,p)..                         OS(n,p) =L= OS_U(n);
g8(i,p)..                         Tout(i,p) =L= Tout_U(i)*y(i,p);
g9(i,p)..                         Fin(i,p) =L= (Fin_U(i))*y(i,p);
g10(ii,i,p)$(ord(ii) ne ord(i)).. FR(ii,i,p) =L= Fin_U(i)*y(i,p)*y(ii,p);
g11(n,i,p)..                      CR(n,i,p) =L= (OS(n,p) + D(n,p) + E(n,p))*y(i,p);
g12(n,i,p)..                      CS(n,i,p) =L= (OS(n,p) + M(n,p) - B(n,p))*y(i,p);
g13(n,p)..                        sum(nn,R(nn,n,p)) =L= OS_U(n);
g14(n,p)..                        D(n,p) =E= 0.002*sum(i,CR(n,i,p));
*g26(n,p)..                        B(n,p) =E= (B(n,p) + D(n) + E(n,p)/CC) - D(n);
g15(n,p)..                        B(n,p) =E= E(n,p)/(CC-1);
g16(n,p)..                        M(n,p) =E= D(n,p) + E(n,p) + B(n,p);

$Ontext
-------------------------------Linear Subproblem--------------------------------
$Offtext

l1(n,p)..                         E(n,p) =E= 0.00085*1.8*OS(n,p)*(TWin_U(n)-TWout(n));

l2(n,p)..                         sum(i,y1(n,i,p)) + sum(nn,R(nn,n,p)*TWout(nn)) =L= TWin_U(n)*OS(n,p);
* include ct losses
* linearise E
l3(i,p)..                         (y(i,p)*Q(i)*3600/cp) + sum(n,y4(n,i,p)) + sum(ii$(ord(ii) ne ord(i)),y2(ii,i,p)) =E= y3(i,p);
l4(n,p)..                         sum(i,y4(n,i,p)) =E= M(n,p)*Tamb + (OS(n,p) - B(n,p))*TWout(n);

* Should I multiply these by the binary paramter?
l5(n,i,p)..                       y1(n,i,p) =G= y(i,p)*((Fin_U(i)*Tout(i,p)) + (CR(n,i,p)*Tout_U(i)) - (Fin_U(i)*Tout_U(i)));
*l5(n,i,p)..                      y1(n,i,p) =L= Fin_U(i)*Tout(i,p) + CR(n,i,p)*Tout_L - Fin_U(i)*Tout_L;
l6(n,i,p)..                       y1(n,i,p) =L= y(i,p)*(Fin_U(i)*Tout(i,p) + CR(n,i,p)*Tout_L - Fin_U(i)*Tout_L);
*l6(n,i,p)..                      y1(n,i,p) =L= Fin_U(i)*Tout(i,p);
l7(n,i,p)..                       y1(n,i,p) =L= y(i,p)*CR(n,i,p)*Tout_U(i);
l8(n,i,p)..                       y1(n,i,p) =G= y(i,p)*CR(n,i,p)*Tout_L;

l9(ii,i,p)$(ord(ii) ne ord(i)).. y2(ii,i,p) =G= y(i,p)*y(ii,p)*((Fin_U(i)*Tout(ii,p)) + (FR(ii,i,p)*Tout_U(ii)) - (Fin_U(i)*Tout_U(ii)));
l10(ii,i,p)$(ord(ii) ne ord(i)).. y2(ii,i,p) =L= y(i,p)*y(ii,p)*(Fin_U(i)*Tout(ii,p) + FR(ii,i,p)*Tout_L - Fin_U(i)*Tout_L);
l11(ii,i,p)$(ord(ii) ne ord(i)).. y2(ii,i,p) =L= y(i,p)*y(ii,p)*FR(ii,i,p)*Tout_U(ii);
l12(ii,i,p)$(ord(ii) ne ord(i)).. y2(ii,i,p) =G= y(i,p)*y(ii,p)*FR(ii,i,p)*Tout_L;
*Tout_L*y(i,p)???
*Perhap y2 =G= RHS should always be 0
l13(i,p)..                        y3(i,p) =G= y(i,p)*((Fin_U(i)*Tout(i,p)) + (Fin(i,p)*Tout_U(i)) - (Fin_U(i)*Tout_U(i)));
l14(i,p)..                        y3(i,p) =L= y(i,p)*((Fin_U(i)*Tout(i,p)) + (Fin(i,p)*Tout_L) - (Fin_U(i)*Tout_L));
l15(i,p)..                        y3(i,p) =L= y(i,p)*Fin(i,p)*Tout_U(i);
l16(i,p)..                        y3(i,p) =G= y(i,p)*Fin(i,p)*Tout_L;
*Same

l17(n,i,p)..                      y4(n,i,p) =G= y(i,p)*(Fin_U(i)*Ts(n,p) + CS(n,i,p)*Tamb - Fin_U(i)*Tamb);
l18(n,i,p)..                      y4(n,i,p) =L= y(i,p)*(Fin_U(i)*Ts(n,p) + CS(n,i,p)*Tcmin - Fin_U(i)*Tcmin);
l19(n,i,p)..                      y4(n,i,p) =L= y(i,p)*CS(n,i,p)*Tamb;
l20(n,i,p)..                      y4(n,i,p) =G= y(i,p)*CS(n,i,p)*Tcmin;

*Try this linearisation, otherwise use estimated paramters for Tc and Th
*$Offtext
$Ontext
------------------------------Nonlinear Subproblem------------------------------
$Offtext

n1(i,p)..                        0.1*((y(i,p)*Q(i)*3600/cp) + sum(n,CS(n,i,p)*Ts(n,p)) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i,p)*Tout(ii,p))) =E= 0.1*Fout(i,p)*Tout(i,p);
n2(i,p)$(ord(p) = 1)..           (y(i,p)*Q(i)*3600/cp) + sum(n,CS(n,i,p)*Ts(n,p)) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i,p)*Tout(ii,p)) =E= Fout(i,p)*Tout(i,p);

n3(n,p)..                        TWin(n,p)*OS(n,p) =E= sum(i,(CR(n,i,p) - D(n,p) - E(n,p))*Tout(i,p)) + sum(nn,R(nn,n,p)*TWout(nn));
n4(n,p)..                        TWin(n,p) =L= TWin_U(n);
n5(i,p)..                        Tout(i,p) =G= Tout_L*y(i,p);

n6(i,p)$(ord(p) ne 1)..          Fin(i,p)*Tin(i,p) =E= (sum(n,CS(n,i,p)*Ts(n,p)) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i,p)*Tout(ii,p)));
n7(i,p)$(ord(p) = 1)..           Fin(i,p)*Tin(i,p) =E= (sum(n,CS(n,i,p)*Ts(n,p)) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i,p)*Tout(ii,p)));

n8(n,p)..                        E(n,p) =E= 0.00085*1.8*sum(i,CR(n,i,p))*(TWin(n,p)-TWout(n));
n9(n,p)..                        Ts(n,p)*sum(i,CS(n,i,p)) =E= M(n,p)*Tamb + (OS(n,p) - B(n,p))*TWout(n);

n10..                            DC =E= sum(n,smax(p,OS(n,p)));

$Ontext
-----------------------------------Boundaries-----------------------------------
$Offtext

Fin.UP(i,p) = Fin_U(i);
Tout.UP(i,p) = Tout_U(i);
TWin.UP(n,p) = TWin_U(n);
OS.UP(n,p) = OS_U(n);
*FR.FX(i,ii,p) = 0;
*Remove above comment to compare when recycle is not allowed.

Model Moodley_Majozi_2008_4a /g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,l1,l2,l3,l4,l5,l6,l7,l8,l9,l10,l11,l12,l13,l14,l15,l16,l17,l18,l19,l20/;
Option SYSOUT = ON;
Options LIMROW = 1e9;
Options LP = CPLEX;
Moodley_Majozi_2008_4a.optfile=1
$onecho > cplex.opt
iis              1
$offecho
Solve Moodley_Majozi_2008_4a using LP minimising CW;

CW.LO = CW.L;

Model Moodley_Majozi_2008_4b /g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,n1,n2,n3,n4,n5,n8,n9/;
Option SYSOUT = ON;
Options LIMROW = 1e9;
Options MINLP = DICOPT;
*Options MIP = CPLEX;
*Moodley_Majozi_2008_4b.optfile=1
*$onecho > cplex.opt
*iis              1
*$offecho
*$onecho > dicopt.opt
*maxcycles        10000
*$offecho
Solve Moodley_Majozi_2008_4b using MINLP minimising CW;

CW.FX = CW.L;

Model Moodley_Majozi_2008_4c /g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,n1,n2,n3,n4,n5,n8,n9,n10/;
*Include all equations?
Options SYSOUT = ON;
Options LIMROW = 1e9;
Options MIP = CPLEX;
Moodley_Majozi_2008_4c.optfile=1
$onecho > cplex.opt
iis              1
$offecho
$onecho > dicopt.opt
maxcycles        10000
$offecho
Solve Moodley_Majozi_2008_4c using MINLP minimising DC;

DC.FX = DC.L;

Model Moodley_Majozi_2008_4d /g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,n1,n2,n3,n4,n5,n8,n9,n10/;
Option SYSOUT = ON;
Options LIMROW = 1e9;
Options MINLP = DICOPT;
Options MIP = CPLEX;
Moodley_Majozi_2008_4d.optfile=1
$onecho > cplex.opt
*iis              1
$offecho
$onecho > dicopt.opt
maxcycles        100000
$offecho
Solve Moodley_Majozi_2008_4d using MINLP minimising CW;
Tin(i,p)$(ord(p) ne 1) = (sum(n,CS.L(n,i,p)*Ts.L(n,p)) + sum(ii$(ord(ii) ne ord(i)),FR.L(ii,i,p)*Tout.L(ii,p)))/Fin.L(i,p);
Tin(i,p)$(ord(p) = 1) = (sum(n,CS.L(n,i,p)*Ts.L(n,p)) + sum(ii$(ord(ii) ne ord(i)),FR.L(ii,i,p)*Tout.L(ii,p)))/Fin.L(i,p);
Display Tin,Fin_U;

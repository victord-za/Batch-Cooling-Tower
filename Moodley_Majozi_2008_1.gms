$Title Moodley_Majozi_2008_1
$Ontext
         Adapted from Simultaneous targeting and design for cooling water systems with multiple cooling water supplies (2008)
         A. Moodley & T. Majozi
         Example 1
         Illustrative Example � Single Source Targeting
         Unrestricted return temperature
         Since this formulation considers a single cooling tower, there is no need for a set n.
$Offtext
Sets
i                Cooling-water-using operations that complies with a mass and energy balance of a counter current heat exchanger\
                 /i1*i4/
p                Time points
                 /p1*p3/
;
Alias
(i,ii)
;
Positive Variables
CR(i,p)          Return cooling water flow from cooling-water-using operation i to cooling water source n at time point p (t.h^-1)
CS(i,p)          Cooling water flow supplied from cooling water source n to cooling-water-using operation i at time point p (t.h^-1)
Fin(i,p)         Total cooling water flow into cooling-water-using operation i including supply and reused water at time point p (t.h^-1)
Fout(i,p)        Total cooling water flow from cooling-water-using operation i including return and reused water at time point p(t.h^-1)
FR(ii,i,p)       Reused cooling water flow from any other cooling-water-using operation ip to cooling-water-using operation i at time point p (t.h^-1)
mC(p)            Mass of cold water in storage tank at the start of time point p (t)
mH(p)            Mass of hot water in storage tank at the start of time point p (t)
QCin(p)          Cooling water flow rate from cooling tower n into cold water storage tank at time point p (t.h^-1)
QCout(i,p)       Cooling water flow rate from cold water storage tank into cooling water using operation i at time point p (t.h^-1)
QHin(i,p)        Cooling water flow rate from cooling water using operation i to hot water storage tank at time point p (t.h^-1)
QHout(p)         Cooling water flow rate from hot water storage tank to cooling tower n at time point p (t.h^-1)
Tin(i,p)         Inlet cooling water temperature to cooling-water-using operation i at time point p (C)
Tout(i,p)        Outlet cooling water temperature from cooling-water-using operation i at time point p (C)
;
Free Variables
CW               Total cooling water flow supplied from all cooling water sources (t.h^-1)
;
Parameters
Fin_U(i)         Maximum flowrate through cooling-water-using operation i (t.h^-1)
Q(i)             Duty of cooling-water-using operation i (kW)
                 /i1     400
                  i2     1000
                  i3     1800
                  i4     200/
Tau(p)           Duration of time slot p (h)
                 /p1     1
                  p2     1
                  p3     1/
Tin_L(i)         Limiting inlet temperature to cooling-water-using operation i (C)
                 /i1     20
                  i2     30
                  i3     30
                  i4     55/
Tout_U(i)        Limiting outlet temperature from cooling-water-using operation i (C)
                 /i1     40
                  i2     40
                  i3     75
                  i4     75/
Tret(p)          Return temperature to cooling water source n (C)
;
Scalars
cp               Specific heat capacity of water (J.(kg.C)^-1)
                 /4187/
mC0              Initial amount of mass in cold storage tank (t)
                 /0/
mH0              Initial amount of mass in hot storage tank (t)
                 /0/
T                Cooling water supply temperature from cooling water source n (C)
                 /20/
;
Table    y(i,p)  Binary parameter indicating activity of cooling water using operation i during time slot p
                 p1      p2      p3
         i1      0       1       0
         i2      1       0       0
         i3      1       1       0
         i4      0       0       1
;
Fin_U(i) = Q(i)*3600/(cp*(Tout_U(i)-Tin_L(i)))
;
Equations
e1,e2,e3,e4,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18
;
e1(p)..                           CW =E= sum(i,CS(i,p)) + QHout(p);
e2(p)..                           CW =E= sum(i,CR(i,p)) + QCin(p);
e3(i,p)..                         Fin(i,p) =E= y(i,p)*(CS(i,p) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i,p)*y(ii,p)) + QCout(i,p));
e4(i,p)..                         Fout(i,p) =E= y(i,p)*(CR(i,p) + sum(ii$(ord(ii) ne ord(i)),FR(i,ii,p)*y(ii,p)) + QHin(i,p));
e7(i,p)..                         Fin(i,p) =E= Fout(i,p);
e8(i,p)..                         (Q(i)*3600/cp) + sum(ii$(ord(ii) ne ord(i)),y(ii,p)*FR(ii,i,p)*Tout_U(ii)) + ((CS(i,p) + QCout(i,p))*T) =E= Fin(i,p)*Tout_U(i);
e9(i,p)..                         Fin(i,p) =L= Fin_U(i);
e10(p)$(ord(p) ne 1)..            mC(p) =E= mC(p-1) + Tau(p-1)*QCin(p-1) - sum(i,(Tau(p-1)*QCout(i,p-1)));
e11(p)$(ord(p) ne 1)..            mH(p) =E= mH(p-1) + sum(i,Tau(p-1)*QHin(i,p-1)) - Tau(p-1)*QHout(p-1);
e12(p)$(ord(p) = 1)..             mC(p) =E= mC0;
e13(p)$(ord(p) = 1)..             mH(p) =E= mH0;
e14(ii,i,p)$(ord(ii) ne ord(i)).. FR(ii,i,p) =L= Fin_U(i)*y(i,p)*y(ii,p);
e15(i,p)..                        QCout(i,p) =L= Fin_U(i)*y(i,p);
e16(i,p)..                        QHin(i,p) =L= Fin_U(i)*y(i,p);
e17(i,p)..                        CR(i,p) =L= CW*y(i,p);
e18(i,p)..                        CS(i,p) =L= CW*y(i,p)

Model Moodley_Majozi_2008_1 /all/;
Option SYSOUT = ON;
Options LIMROW = 1e9;
Options LP = CPLEX;
Moodley_Majozi_2008_1.optfile=1
$onecho > cplex.opt
iis      1
$offecho
Solve Moodley_Majozi_2008_1 using LP minimizing CW;
Tret(p) = sum(i, CR.l(i,p)*Tout_U(i))/CW.l;
Display CS.l, CR.l, Tret, Fin_U;

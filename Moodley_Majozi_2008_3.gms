$Title Moodley_Majozi_2008_3
$Ontext
         Adapted from Simultaneous targeting and design for cooling water systems with multiple cooling water supplies (2008)
         A. Moodley & T. Majozi
         Example 3
         Illustrative Example: Multiple Source Targeting
         Unified Targeting - Maximum Reuse
         Targeting Without Cooling Water Return Temperature Limitation
         NB! The cooling water storage tank temperature is estimated, not calculated
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
;
Binary Variables
yC(p)            Binary variable controlling inlet and outlet of cold storage tank water.
yH(p)            Binary variable controlling inlet and outlet of hot storage tank water.
;
Free Variables
CW               Total cooling water flow supplied from all cooling water sources (t.h^-1)
sto
sto0             Total initial amount of water in storage tanks (t)
obj
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
*Tret_U(n)        Maximum return temperature to cooling water source n (C)
*                 /n1     52
*                  n2     52
*                  n3     50/
*Tret(n,p)
;
Scalars
cp               Specific heat capacity of water (J.(kg.C)^-1)
                 /4187/
M                Large value
                 /999999999/
Tamb
                 /25/
Tcse             Estimated
                 /22/
;
Table    y(i,p)  Binary parameter indicating activity of cooling water using operation i during time slot p
*                 p1      p2      p3      p4      p5
*         i1      1       1       0       0       0
*         i2      1       0       0       0       0
*         i3      1       1       1       1       0
*         i4      1       1       1       1       0
*         i5      0       0       0       1       1
*         i6      0       0       0       1       1
                 p1      p2      p3      p4      p5
         i1      1       1       0       0       0
         i2      1       1       1       1       0
         i3      1       1       1       0       0
         i4      0       1       1       1       1
         i5      0       0       1       1       1
         i6      0       0       0       0       1
;
Fin_U(i) = Q(i)*3600/(cp*(Tout_U(i)-Tin_U(i)))
;
Equations
e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19,e20,e21,e22,e23
;

e1..                              CW =E= sum(n,OS(n));
e2(n,p)..                         OS(n) =E= sum(i,CS(i,n,p)) + QCin(n,p);
e3(n,p)..                         OS(n) =E= sum(i,CR(i,n,p)) + QHout(n,p);
e4(i,p)..                         Fin(i,p) =E= y(i,p)*(sum(n,CS(i,n,p)) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i,p)) + QCout(i,p));
e5(i,p)..                         Fout(i,p) =E= y(i,p)*(sum(n,CR(i,n,p)) + sum(ii$(ord(ii) ne ord(i)),FR(i,ii,p)) + QHin(i,p));
e6(i,p)..                         Fin(i,p) =E= Fout(i,p);
e7(n)..                           OS(n) =L= OS_U(n);
e8(i,p)..                         (y(i,p)*Q(i)*3600/cp) + sum(n,CS(i,n,p)*T(n)) + (QCout(i,p)*Tcse) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i,p)*Tout_U(ii)) =E= Fout(i,p)*Tout_U(i);
e9(i,p)..                         Fin(i,p) =L= Fin_U(i);
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
e20(i,p)..       QHin(i,p) =L= M*yH(p);
e21(n,p)..       QHout(n,p) =L= M*(1-yh(p));
e22(n,p)..       QCin(n,p) =L= M*yC(p);
e23(i,p)..       QCout(i,p) =L= M*(1-yC(p));

*FR.fx(i,ii,p) = 0;
*Remove above comment to compare when recycle is not allowed.
Model Moodley_Majozi_2008_3a /e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19,e20,e21,e22,e23/;
Option SYSOUT = ON;
Options LIMROW = 1e9
Options LP = CPLEX;
Moodley_Majozi_2008_3a.optfile=1
$onecho > cplex.opt
iis      1
$offecho
Solve Moodley_Majozi_2008_3a using MIP minimising sto0;

mC0.fx = mC0.l;
mH0.fx = mH0.l;

Model Moodley_Majozi_2008_3b /e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19,e20,e21,e22,e23/;
Option SYSOUT = ON;
Options LIMROW = 1e9
Options MIP = CPLEX;
Moodley_Majozi_2008_3b.optfile=1
$onecho > cplex.opt
iis      1
$offecho
Solve Moodley_Majozi_2008_3b using MIP minimising CW;
*Tret(p) = sum(i, CR.l(i,p)*Tout_U(i))/CW.l;
*Tret(n,p) = sum(i, CR.l(i,n,p)*Tout_U(i))/sum(i,CR.l(i,n,p));
*Display CS.l, CR.l, Fin_U, Tret;
* Solution method: perhaps let Tcs be a scalar and solve for lp before making it a variable

CW.fx = CW.l;
Equations
e24,e25,e26,e27,e28,e29,e30
;
e24..                    mHf =E= smax(p,mH(p));
e25..                    mCf =E= smax(p,mC(p));
e26..                    sto =E= mHf + mCf;
e27(p)$(ord(p) ne 1)..  Tc(p)*(mC(p-1) + Tau(p)*(sum(n,QCin(n,p)) - sum(i,QCout(i,p)))) =E= mC(p-1)*Tc(p-1) + sum(n,QCin(n,p)*T(n))*Tau(p) - sum(i,QCout(i,p)*Tau(p)*Tc(p-1));
e28(p)$(ord(p) = 1)..   Tc(p)*(mC0 + Tau(p)*(sum(n,QCin(n,p)) - sum(i,QCout(i,p)))) =E= mC0*Tamb + sum(n,QCin(n,p)*T(n))*Tau(p) - sum(i,QCout(i,p))*Tau(p)*Tamb;
e29(p)$(ord(p) ne 1)..  Th(p)*(mH(p-1) + Tau(p)*(sum(i,QHin(i,p)) - sum(n,QHout(n,p)))) =E= mH(p-1)*Th(p-1) + sum(i,QHin(i,p)*Tau(p)*Tout_U(i)) - sum(n,QHout(n,p))*Tau(p)*Th(p-1);
e30(p)$(ord(p) = 1)..   Th(p)*(mH0 + Tau(p)*(sum(i,QHin(i,p)) - sum(n,QHout(n,p)))) =E= mH0*Tamb + sum(i,QHin(i,p)*Tau(p)*Tout_U(i)) - sum(n,QHout(n,p))*Tau(p)*Tamb;
Model Moodley_Majozi_2008_3c /e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19,e20,e21,e22,e23,e24,e25,e26,e27,e28,e29,e30/;
Option SYSOUT = ON;
Options LIMROW = 1e9
Options MIP = CPLEX;
Moodley_Majozi_2008_3c.optfile=1
$onecho > cplex.opt
iis      1
$offecho
Solve Moodley_Majozi_2008_3c using MINLP minimising sto;

*QHin.fx(i,p) = QHin.l(i,p);
*QHout.fx(n,p) = QHout.l(n,p);
*QCin.fx(n,p) = QCin.l(n,p);
*QCout.fx(i,p) = QCout.l(i,p);

*Positive Variables
*mHf               Maximum Amount of Storage Required for Hot Water Across All Time Points (t)
*mCf               Maximum Amount of Storage Required for Cold Water Across All Time Points (t)
*;
*Free Variables
*sto               Total Amount of Water Storage Required (t)
*;
*Equations
*e24,e25,e26
*,e27,e28,e29,e30
*;
*e24..    mHf =E= smax(p,mH(p));
*e25..    mCf =E= smax(p,mC(p));
*e26..    sto =E= mHf + mCf;
*e27(p)$(ord(p) ne 1)..  Tc(p)*(mC(p-1) + Tau(p)*(sum(n,QCin(n,p)) - sum(i,QCout(i,p)))) =E= mC(p-1)*Tc(p-1) + sum(n,QCin(n,p)*T(n))*Tau(p) - sum(i,QCout(i,p)*Tau(p)*Tc(p-1));
*e28(p)$(ord(p) = 1)..   Tc(p)*(mC0 + Tau(p)*(sum(n,QCin(n,p)) - sum(i,QCout(i,p)))) =E= mC0*Tamb + sum(n,QCin(n,p)*T(n))*Tau(p) - sum(i,QCout(i,p))*Tau(p)*Tamb;
*e29(p)$(ord(p) ne 1)..  Th(p)*(mH(p-1) + Tau(p)*(sum(i,QHin(i,p)) - sum(n,QHout(n,p)))) =E= mH(p-1)*Th(p-1) + sum(i,QHin(i,p)*Tau(p)*Tout_U(i)) - sum(n,QHout(n,p))*Tau(p)*Th(p-1);
*e30(p)$(ord(p) = 1)..   Th(p)*(mH0 + Tau(p)*(sum(i,QHin(i,p)) - sum(n,QHout(n,p)))) =E= mH0*Tamb + sum(i,QHin(i,p)*Tau(p)*Tout_U(i)) - sum(n,QHout(n,p))*Tau(p)*Tamb;

*Model Moodley_Majozi_2008_3d /all/;
*Solve Moodley_Majozi_2008_3d using MINLP minimising sto;

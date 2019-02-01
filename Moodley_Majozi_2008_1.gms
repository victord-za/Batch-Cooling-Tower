$Title Moodley_Majozi_2008_1
$Ontext
        Adapted from Simultaneous targeting and design for cooling water systems with multiple cooling water supplies (2008)
        A. Moodley & T. Majozi
        Example 1
        Illustrative Example � Single Source Targeting
        Unrestricted return temperature
        Since this formulation considers a single cooling tower, there is no need for a set n.
        Steady state continuous operation over cooling tower, using buffer tanks to ensure steady state.
        Solution procedure:
          1) Minimise intial amount of cooling water required in storage.
          2) Minimise amount of recirculating cooling water.
          3) Ensure that cooling water is not allowed to go in and out of storage tank at the same time point.
          4) Minimise size of storage tanks.
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
mC0              Initial mass of cold water in storage tank (t)
mC(p)            Mass of cold water in storage tank at the start of time point p (t)
mH0              Initial mass of hot water in storage tank (t)
mH(p)            Mass of hot water in storage tank at the start of time point p (t)
QCin(p)          Cooling water flow rate from cooling tower n into cold water storage tank at time point p (t.h^-1)
QCout(i,p)       Cooling water flow rate from cold water storage tank into cooling water using operation i at time point p (t.h^-1)
QHin(i,p)        Cooling water flow rate from cooling water using operation i to hot water storage tank at time point p (t.h^-1)
QHout(p)         Cooling water flow rate from hot water storage tank to cooling tower n at time point p (t.h^-1)
Tc(p)            Temperature of cold water storage tank (C)
Th(p)            Temperature of hot water storage tank (C)
Tin(i,p)         Inlet cooling water temperature to cooling-water-using operation i at time point p (C)
Tout(i,p)        Outlet cooling water temperature from cooling-water-using operation i at time point p (C)
;
Binary Variables
yC(p)            Binary variable controlling inlet and outlet of cold storage tank water.
yH(p)            Binary variable controlling inlet and outlet of hot storage tank water.
;
Free Variables
CW               Total cooling water flow supplied from all cooling water sources (t.h^-1)
sto0             Total initial amount of water in storage tanks (t)
;
Parameters
Fin_U(i)         Maximum flowrate through cooling-water-using operation i (t.h^-1)
Q(i)             Duty of cooling-water-using operation i (kW)
                 /i1     400
                  i2     1000
                  i3     1800
                  i4     200/
Tau(p)           Duration of time slot p (h)
                 /p1     3
                  p2     1
                  p3     4/
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
M                Large value
                 /999999999/
T                Cooling water supply temperature from cooling water source n (C)
                 /20/
Tamb             Ambient temperature (C)
                 /25/
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
e1,e2,e3,e4,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19
;
e1(p)..                           CW =E= sum(i,CS(i,p)) + QCin(p);
e2(p)..                           CW =E= sum(i,CR(i,p)) + QHout(p);
e3(i,p)..                         Fin(i,p) =E= y(i,p)*(CS(i,p) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i,p)*y(ii,p)) + QCout(i,p));
e4(i,p)..                         Fout(i,p) =E= y(i,p)*(CR(i,p) + sum(ii$(ord(ii) ne ord(i)),FR(i,ii,p)*y(ii,p)) + QHin(i,p));
e7(i,p)..                         Fin(i,p) =E= Fout(i,p);
e8(i,p)..                         (y(i,p)*Q(i)*3600/cp) + sum(ii$(ord(ii) ne ord(i)),y(ii,p)*FR(ii,i,p)*Tout_U(ii)) + ((CS(i,p) + QCout(i,p))*T) =E= Fin(i,p)*Tout_U(i);
e9(i,p)..                         Fin(i,p) =L= Fin_U(i);
e10(p)$(ord(p) ne 1)..            mC(p) =E= mC(p-1) + Tau(p)*QCin(p) - sum(i,(Tau(p)*QCout(i,p)));
e11(p)$(ord(p) ne 1)..            mH(p) =E= mH(p-1) + sum(i,Tau(p)*QHin(i,p)) - Tau(p)*QHout(p);
e12(p)$(ord(p) = 1)..             mC(p) =E= mC0 + Tau(p)*QCin(p) - sum(i,(Tau(p)*QCout(i,p)));
e13(p)$(ord(p) = 1)..             mH(p) =E= mH0 + sum(i,Tau(p)*QHin(i,p)) - Tau(p)*QHout(p);
e14(ii,i,p)$(ord(ii) ne ord(i)).. FR(ii,i,p) =L= Fin_U(i)*y(i,p)*y(ii,p);
e15(i,p)..                        QCout(i,p) =L= Fin_U(i)*y(i,p);
e16(i,p)..                        QHin(i,p) =L= Fin_U(i)*y(i,p);
e17(i,p)..                        CR(i,p) =L= CW*y(i,p);
e18(i,p)..                        CS(i,p) =L= CW*y(i,p);
e19..                             sto0 =E= mC0 + mH0;

*FR.fx(i,ii,p) = 0;
*Remove above comment to compare when recycle is not allowed.
Model Moodley_Majozi_2008_1a /e1,e2,e3,e4,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19/;
Option SYSOUT = ON;
Options LIMROW = 1e9;
Options LP = CPLEX;
Moodley_Majozi_2008_1a.optfile=1
$onecho > cplex.opt
iis      1
$offecho
Solve Moodley_Majozi_2008_1a using LP minimizing sto0;

mC0.fx = mC0.l;
mH0.fx = mH0.l;

Model Moodley_Majozi_2008_1b /e1,e2,e3,e4,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19/;
Option SYSOUT = ON;
Options LIMROW = 1e9;
Options LP = CPLEX;
Moodley_Majozi_2008_1b.optfile=1
$onecho > cplex.opt
iis      1
$offecho
Solve Moodley_Majozi_2008_1b using LP minimizing CW;
Tret(p) = sum(i, CR.l(i,p)*Tout_U(i))/CW.l;
Display CS.l, CR.l, Tret, Fin_U;

CW.fx = CW.l;

Positive Variables
mHf               Maximum amount of storage required for hot water across all time points (t)
mCf               Maximum amount of storage required for cold water across all time points (t)
;
Free Variables
sto               Total amount of water storage required (t)
;
Equations
e20,e21,e22,e23
;
e20(i,p)..       QHin(i,p) =L= M*yH(p);
e21(p)..         QHout(p) =L= M*(1-yh(p));
e22(p)..         QCin(p) =L= M*yC(p);
e23(i,p)..       QCout(i,p) =L= M*(1-yC(p));
Model Moodley_Majozi_2008_1c /e1,e2,e3,e4,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19,e20,e21,e22,e23/;
Solve Moodley_Majozi_2008_1c using MIP minimising CW;

QHin.fx(i,p) = QHin.l(i,p);
QHout.fx(p) = QHout.l(p);
QCin.fx(p) = QCin.l(p);
QCout.fx(i,p) = QCout.l(i,p);
Equations
e24,e25,e26,e27,e28,e29,e30
;
e24..                   mHf =E= smax(p,mH(p));
e25..                   mCf =E= smax(p,mC(p));
e26..                   sto =E= mHf + mCf;
e27(p)$(ord(p) ne 1)..  Tc(p)*(mC(p-1) + Tau(p)*(QCin(p) - sum(i,QCout(i,p)))) =E= mC(p-1)*Tc(p-1) + QCin(p)*Tau(p)*T - sum(i,QCout(i,p)*Tau(p)*Tc(p-1));
e28(p)$(ord(p) = 1)..   Tc(p)*(mC0 + Tau(p)*(QCin(p) - sum(i,QCout(i,p)))) =E= mC0*Tamb + QCin(p)*Tau(p)*T - sum(i,QCout(i,p))*Tau(p)*Tamb;
e29(p)$(ord(p) ne 1)..  Th(p)*(mH(p-1) + Tau(p)*(sum(i,QHin(i,p)) - QHout(p)) =E= mH(p-1)*Th(p-1) + sum(i,QHin(i,p)*Tau(p)*Tout_U(i)) - QHout(p)*Tau(p)*Th(p-1);
e30(p)$(ord(p) = 1)..   Th(p)*(mH0 + Tau(p)*(sum(i,QHin(i,p)) - QHout(p)) =E= mH0*Tamb + sum(i,QHin(i,p)*Tau(p)*Tout_U(i)) - QHout(p)*Tau(p)*Tamb;

Model Moodley_Majozi_2008_1d /all/;
Solve Moodley_Majozi_2008_1d using MINLP minimising sto;

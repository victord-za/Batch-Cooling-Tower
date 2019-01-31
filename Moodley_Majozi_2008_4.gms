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
$Offtext
Sets
i                Cooling-water-using operations that complies with a mass and energy balance of a counter current heat exchanger\
                 /i1*i6/
n                Cooling water sources supplying the cooling water network
                 /n1*n3/
;
Alias
(i,ii)
;
Positive Variables
CR(i,n)          Return cooling water flow from cooling-water-using operation i to cooling water source n (t.h^-1)
CS(i,n)          Cooling water flow supplied from cooling water source n to cooling-water-using operation i (t.h^-1)
Fin(i)           Total cooling water flow into cooling-water-using operation i including supply and reused water (t.h^-1)
Fout(i)          Total cooling water flow from cooling-water-using operation i including return and reused water (t.h^-1)
FR(ii,i)         Reused cooling water flow from any other cooling-water-using operation ip to cooling-water-using operation i (t.h^-1)
G1(i,n)          Linearisation variable 1 for term CR(i.n)*Tout(i)
G2(ii,i)         Linearisation variable 2 for term FR(ii.i)*Tout(ii)
G3(i)            Linearization variable 3 for term Fin(i)*Tout(i)
OS(n)            Total cooling water flow supplied from cooling water source n (t.h^-1)
Tin(i)           Inlet cooling water temperature to cooling-water-using operation i (C)
Tout(i)          Outlet cooling water temperature from cooling-water-using operation i (C)
Tret(n)          Return temperature to cooling water source n (C)
;
Free Variables
CW               Total cooling water flow supplied from all cooling water sources (t.h^-1)
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
Tout_L           /30/
;
Fin_U(i) = Q(i)*3600/(cp*(Tout_U(i)-Tin_U(i)))
;
Equations
e1, e2, e3, e4, e5, e6, e7, e8, e9                                      General Model
e10, e11, e12, e13, e14, e15, e16, e17, e18, e19, e20, e21, e22, e23    Linear Model
e24, e25, e26, e27                                                      Nonlinear Model
;
$Ontext
---------------------------------General Model----------------------------------
$Offtext

e1..                            CW =E= sum(n,OS(n));
e2(n)..                         OS(n) =E= sum(i,CS(i,n));
e3(n)..                         OS(n) =E= sum(i,CR(i,n));
e4(i)..                         Fin(i) =E= sum(n,CS(i,n)) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i));
e5(i)..                         Fout(i) =E= sum(n,CR(i,n)) + sum(ii$(ord(ii) ne ord(i)),FR(i,ii));
e6(i)..                         Fin(i) =E= Fout(i);
e7(n)..                         OS(n) =L= OS_U(n);
e8(i)..                         Tout(i) =L= Tout_U(i);
e9(i)..                         Fin(i) =L= Fin_U(i);

$Ontext
-------------------------------Linear Subproblem--------------------------------
$Offtext

e10(n)..                        sum(i,G1(i,n)) =L= Tret_U(n)*OS(n);
e11(i)..                        (Q(i)*3600/cp) + sum(n,CS(i,n)*T(n)) + sum(ii$(ord(ii) ne ord(i)),G2(ii,i)) =E= G3(i);
e12(i,n)..                      G1(i,n) =G= (Fin_U(i)*Tout(i)) + (CR(i,n)*Tout_U(i)) - (Fin_U(i)*Tout_U(i));
e12(i,n)..                      G1(i,n) =L= Fin_U(i)*Tout(i) + CR(i,n)*Tout_L - Fin_U(i)*Tout_L;
e14(i,n)..                      G1(i,n) =L= CR(i,n)*Tout_U(i);
e15(i,n)..                      G1(i,n) =G= CR(i,n)*Tout_L;
e16(ii,i)$(ord(ii) ne ord(i)).. G2(ii,i) =G= (Fin_U(i)*Tout(ii)) + (FR(ii,i)*Tout_U(ii)) - (Fin_U(i)*Tout_U(ii));
e17(ii,i)$(ord(ii) ne ord(i)).. G2(ii,i) =L= Fin_U(i)*Tout(ii) + FR(ii,i)*Tout_L - Fin_U(i)*Tout_L ;
e18(ii,i)$(ord(ii) ne ord(i)).. G2(ii,i) =L= FR(ii,i)*Tout_U(ii);
e19(ii,i)$(ord(ii) ne ord(i)).. G2(ii,i) =G= FR(ii,i)*Tout_L;
e20(i)..                        G3(i) =G= (Fin_U(i)*Tout(i)) + (Fin(i)*Tout_U(i)) - (Fin_U(i)*Tout_U(i));
e21(i)..                        G3(i) =L= (Fin_U(i)*Tout(i)) + (Fin(i)*Tout_L) - (Fin_U(i)*Tout_L);
e22(i)..                        G3(i) =L= Fin(i)*Tout_U(i);
e23(i)..                        G3(i) =G= Fin(i)*Tout_L;

$Ontext
------------------------------Nonlinear Subproblem------------------------------
$Offtext

e24(n)..                        Tret(n)*OS(n) =E= sum(i, CR(i,n)*Tout(i));
e25(n)..                        Tret(n) =L= Tret_U(n);
e26(i)..                        (Q(i)*3600/cp) + sum(n,CS(i,n)*T(n)) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i)*Tout(ii)) =E= Fout(i)*Tout(i);
e27(i)..                        Tout(i) =G= Tout_L;


$Ontext
-----------------------------------Boundaries-----------------------------------
$Offtext

Tout.LO(i) = Tout_L;
Fin.UP(i) = Fin_U(i);
Tin.UP(i) = Tin_U(i);
Tout.UP(i) = Tout_U(i);
Tret.UP(n) = Tret_U(n);
OS.UP(n) = OS_U(n);
CW.LO = 90;
* The lower bound makes the problem solvable.

Model Moodley_Majozi_2008_4_LP /e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12, e13, e14, e15, e16, e17, e18, e19, e20, e21, e22, e23/;
Model Moodley_Majozi_2008_4_NLP /e1, e2, e3, e4, e5, e6, e7, e8, e9, e24, e25, e26, e27/;
Solve Moodley_Majozi_2008_4_LP using LP minimizing CW;
Solve Moodley_Majozi_2008_4_NLP using NLP minimizing CW;
Display CS.l, CR.l, Fin_U, Tret.l;

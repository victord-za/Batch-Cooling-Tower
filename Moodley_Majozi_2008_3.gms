$Title Moodley_Majozi_2008_3
$Ontext
         Simultaneous targeting and design for cooling water systems with multiple cooling water supplies (2008)
         A. Moodley & T. Majozi
         Example 3
         Illustrative Example: Multiple Source Targeting
         Unified Targeting - Maximum Reuse
         Targeting Without Cooling Water Return Temperature Limitation
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
OS(n)            Total cooling water flow supplied from cooling water source n (t.h^-1)
Tin(i)           Inlet cooling water temperature to cooling-water-using operation i (C)
Tout(i)          Outlet cooling water temperature from cooling-water-using operation i (C)
;
Binary Variables
ys(i,n)          Existance of a direct cooling water stream from cooling water source n to operation i
yv(i,n)          Existance of a return cooling water stream from operation i direct to cooling water source n
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
Tret(n)
;
Scalars
cp               Specific heat capacity of water (J.(kg.C)^-1)
                 /4187/
;
Fin_U(i) = Q(i)*3600/(cp*(Tout_U(i)-Tin_U(i)))
;
Equations
e1,e2,e3,e4,e5,e6,e7,e8,e9
;

e1..            CW =E= sum(n,OS(n));
e2(n)..         OS(n) =E= sum(i,CS(i,n));
e3(n)..         OS(n) =E= sum(i,CR(i,n));
e4(i)..         Fin(i) =E= sum(n,CS(i,n)) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i));
e5(i)..         Fout(i) =E= sum(n,CR(i,n)) + sum(ii$(ord(ii) ne ord(i)),FR(i,ii));
e6(i)..         Fin(i) =E= Fout(i);
e7(n)..         OS(n) =L= OS_U(n);
e8(i)..         (Q(i)*3600/cp) + sum(n,CS(i,n)*T(n)) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i)*Tout_U(ii)) =E= Fout(i)*Tout_U(i);
e9(i)..         Fin(i) =L= Fin_U(i);

Model Moodley_Majozi_2008_3 /all/;
Solve Moodley_Majozi_2008_3 using LP minimizing CW;
Tret(n) = sum(i, CR.l(i,n)*Tout_U(i))/sum(i,CR.l(i,n));
Display CS.l, CR.l, Fin_U, Tret;

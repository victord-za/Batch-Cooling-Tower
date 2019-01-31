$Title Moodley_Majozi_2008_1
$Ontext
         Simultaneous targeting and design for cooling water systems with multiple cooling water supplies (2008)
         A. Moodley & T. Majozi
         Example 1
         Illustrative Example � Single Source Targeting
         Unrestricted return temperature
         Since this formulation considers a single cooling tower, there is no need for a set n.
$Offtext
Sets
i                Cooling-water-using operations that complies with a mass and energy balance of a counter current heat exchanger\
                 /i1*i4/
;
Alias
(i,ii)
;
Positive Variables
CR(i)            Return cooling water flow from cooling-water-using operation i to cooling water source n (t.h^-1)
CS(i)            Cooling water flow supplied from cooling water source n to cooling-water-using operation i (t.h^-1)
Fin(i)           Total cooling water flow into cooling-water-using operation i including supply and reused water (t.h^-1)
Fout(i)          Total cooling water flow from cooling-water-using operation i including return and reused water (t.h^-1)
FR(ii,i)         Reused cooling water flow from any other cooling-water-using operation ip to cooling-water-using operation i (t.h^-1)
Tin(i)           Inlet cooling water temperature to cooling-water-using operation i (C)
Tout(i)          Outlet cooling water temperature from cooling-water-using operation i (C)
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
Tret             Return temperature to cooling water source n (C)
;
Scalars
cp               Specific heat capacity of water (J.(kg.C)^-1)
                 /4187/
T                Cooling water supply temperature from cooling water source n (C)
                 /20/
;
Fin_U(i) = Q(i)*3600/(cp*(Tout_U(i)-Tin_L(i)))
;
Equations
e1,e2,e3,e4,e7,e8,e9
;
e1..             CW =E= sum(i,CS(i));
e2..             CW =E= sum(i,CR(i));
e3(i)..          Fin(i) =E= CS(i) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i));
e4(i)..          Fout(i) =E= CR(i) + sum(ii$(ord(ii) ne ord(i)),FR(i,ii));
e7(i)..          Fin(i) =E= Fout(i);
e8(i)..          (Q(i)*3600/cp) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i)*Tout_U(ii)) + CS(i)*T =E= Fin(i)*Tout_U(i);
e9(i)..          Fin(i) =L= Fin_U(i);

Model Moodley_Majozi_2008_1 /all/;
Solve Moodley_Majozi_2008_1 using LP minimizing CW;
Tret = sum(i, CR.l(i)*Tout_U(i))/CW.l;
Display CS.l, CR.l, Tret, Fin_U;

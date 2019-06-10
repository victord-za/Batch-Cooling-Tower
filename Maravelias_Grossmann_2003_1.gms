$Title Maravelias_Grossmann_2003_1
$OnEmpty
$Ontext
         New General Continuous-Time State-Task Network Formulation for Short-Term Scheduling of Multipurpose Batch Plants (2003)
         C. T. Maravelias & I. E. Grossmann
         Example 1
         &
         Simultaneous targeting and design for cooling water systems with multiple cooling water supplies (2008)
         A. Moodley & T. Majozi
         Example 4
$Offtext
Sets
i                Tasks
                 /i1*i8/
j                Equipment units
                 /j1*j4/
n                Cooling water sources supplying the cooling water network
                 /n1*n3/
p                Time points
                 /p1*p7/
s                States
                 /s1*s9/
ij(i,j)          Set of tasks that can be scheduled on equipment unit j
                 /i1.j1,i2.j2,i3.j3,i4.j2,i5.j3,i6.j2,i7.j3,i8.j4/
is(i,s)          Set of tasks that use state s as input
                 /i1.s1,i2.s2,i2.s3,i3.s2,i3.s3,i4.s4,i4.s6,i5.s4,i5.s6,i6.s3,i6.s5,i7.s3,i7.s5,i8.s7/
ps(i,s)           Set of tasks that produce state s
                 /i1.s4,i2.s6,i3.s6,i4.s5,i4.s8,i5.s5,i5.s8,i6.s7,i7.s7,i8.s5,i8.s9/
si(s,i)          Set of states consumed in task i
                 /s1.i1,s2.i2,s2.i3,s3.i2,s3.i3,s3.i6,s3.i7,s4.i4,s4.i5,s5.i6,s5.i7,s6.i4,s6.i5,s7.i8/
so(s,i)          Set of states produced from task i
                 /s4.i1,s5.i4,s5.i5,s5.i8,s6.i2,s6.i3,s7.i6,s7.i7,s8.i4,s8.i5,s9.i8/
zw(i)            Set of task that produce at least one ZW state or require CW
                 /i2,i3,i4,i5,i6,i7/
;
Alias
(p,pp),(i,ii),(n,nn)
;
Positive variables
B(n,p)           Blowdown flow from cooling tower n at time point p (t.h^-1)
Bs(i,p)          Batch size of task i that starts at time point p
Bp(i,p)          Batch size of task i that is being processed at time point p
Bf(i,p)          Batch size of task i that finishes at or before time point p
BI(i,s,p)        Amount of state s used as input for task i at time point p
BO(i,s,p)        Amount of state s produced from task i at or before time point p
CR(n,i,p)        Return cooling water flow to cooling water source n from cooling-water-using operation i at time point p (t.h^-1)
CS(n,i,p)        Cooling water flow supplied from cooling water source n to cooling-water-using operation i at time point p (t.h^-1)
CW(p)            Total cooling water flow supplied from all cooling water sources (t.h^-1)
CT               Total number of active cooling towers
D(n,p)           Drift loss in cooling tower n at time point p (t.h^-1)
DC               Total design capacity of all cooling towers (t.h^-1)
E(n,p)           Evaporation loss in cooling tower n at time point p (t.h^-1)
Fin(i,p)         Total cooling water flow into cooling-water-using operation i including supply and reused water at time point p(t.h^-1)
Fout(i,p)        Total cooling water flow from cooling-water-using operation i including return and reused water at time point p (t.h^-1)
FR(ii,i,p)       Reused cooling water flow from any other cooling-water-using operation ii to cooling-water-using operation i at time point p (t.h^-1)
M(n,p)           Makeup water flow to cooling tower n at time point p (t.h^-1)
MS               Makespan
OS(n,p)          Total cooling water flow supplied from cooling water source n (t.h^-1)
Qi(i,p)          Amount of cooling duty provided to task i from time point p (kW)
Qo(i,p)          Amount of cooling duty provided to task i until time point p (kW)
Qu(i,p)          Amount of cooling duty utilized at time point p (kW)
R(nn,n,p)        Cooling water recycled directly from cooling tower nn to cooling tower n at time point p
SA(s,p)          Amount of state s available at time point p
SS(s,p)          Sales of state s at point p
T(p)             Time that corresponds to time point p
Tau(i,p)         Duration of task i that starts at time point p
Tsup(n,p)        Supply temperature from cooling tower n at time point p to cooling water network (C)
Ts(i,p)          Start time of task i that starts at time point p
Tf(i,p)          Finish time of task i that starts at time point p
y1(n,i,p)        Linearisation variable 1 for term CR(n.i.p)*Tout(i.p)
y2(ii,i,p)       Linearisation variable 2 for term FR(ii.i.p)*Tout(ii.p)
y3(i,p)          Linearisation variable 3 for term Fin(i.p)*Tout(i.p)
y4(n,i,p)        Linearisation variable 4 for term CS(n.i.p)*Tsup(n.p)
y5(n,i,p)        Linearisation variable 5 for term CR(n.i.p)*TWin(n.p)
y6(nn,n,p)       Linearisation variable 5 for term R(nn.n.p)*TWin(n.p)
Tout(i,p)        Outlet cooling water temperature from cooling-water-using operation i at time point p(C)
TWin(n,p)        Return temperature to cooling water source n at time point p (C)
;
Binary variables
Wr(ii,i,p)       Binary variable indicating whether tasks ii and i both take place during time point p
Ws(i,p)          Binary variable indicating whether task i starts at time point p
Wp(i,p)          Binary variable indicating whether task i is being processed at time point p
Wf(i,p)          Binary variable indicating whether task i finishes at or before time point p
Zs(j,p)          Binary variable indicating whether a task in I(j) is assigned to start in unit j at time point p
Zp(j,p)          Binary variable indicating whether a task in I(j) is being processed in unit j at time point p
Zf(j,p)          Binary variable indicating whether a task in I(j) assigned to unit j finishes at or before time point p
yCT(n)           Binary variable indicating activity of cooling tower n
yr(ii,i,p)       Binary variable indicating whether cooling water is reused by task i from task ii during time point p
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
C_U(n)
de(s)            Demand of state s at the end of time horizon
                 //
Fin_U(i)         Maximum flowrate through cooling-water-using operation i (t.h^-1)
OS_U(n)          Design capacity of cooling water source n (t.h^-1)
                 /n1     30
                  n2     40
                  n3     40/
Q(i)             Duty of cooling-water-using operation i (kW)
                 /i1     0
                  i2     610
                  i3     420
                  i4     800
                  i5     555
                  i6     345
                  i7     700
                  i8     0/
Sc_0(s)          Initial amount of state s
                 /s1     1000
                  s2     1000
                  s3     1000
                  s4     0
                  s5     0
                  s6     0
                  s7     0
                  s8     0
                  s9     0/
Sc(s)            Storage capacity for state s
                 /s1     1000
                  s2     1000
                  s3     1000
                  s4     100
                  s5     200
                  s6     150
                  s7     200
                  s8     1000
                  s9     1000/
Tcmin            Minimum cooling water temperature (C)
Tin(i,p)         Cooling water temperature into task i at time point p (C)
Tin_U(i)         Limiting inlet temperature to cooling-water-using operation i (C)
                 /i1     30
                  i2     30
                  i3     40
                  i4     25
                  i5     45
                  i6     40
                  i7     30
                  i8     25/
Tout_U(i)        Limiting outlet temperature from cooling-water-using operation i (C)
                 /i1     45
                  i2     45
                  i3     60
                  i4     50
                  i5     53
                  i6     45
                  i7     45
                  i8     40/
TWin_U(n)        Maximum return temperature to cooling water source n (C)
                 /n1     52
                  n2     52
                  n3     50/
TWout(n)         Cooling water supply temperature from cooling water source n (C)
                 /n1     20
                  n2     22
                  n3     25/
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
CC               Cycles of concentration
                 /4/
cp               Specific heat capacity of water (J.(kg.C)^-1)
                 /4187/
H                Time horizon
                 /12/
Tamb             Ambient temperature (C)
                 /25/
Tout_L           Limiting outlet temperature from cooling-water-using operation i (C)
                 /30/
Twb              Wet bulb temperature (C)
                 /17/
;
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
C_U(n) = OS_U(n)*(1.002+(0.00153*(TWin_U(n)-TWout(n))));
Fin_U(i) = Q(i)*3600/(cp*(Tout_U(i)-Tin_U(i)));
Tcmin = smin(n,TWout(n));
Equations
s1,s2,s3,s4,s5,s6,s7,s8,s9,s10
s11,s12,s13,s14,s15,s16,s17,s18,s19,s20
s21,s22,s23,s24,s25,s26,s27,s28,s29,s30
s31,s32,s33,s34,s35,s36,s37              Scheduling constraints
g1,g2,g3,g4,g5,g6,g7,g8,g9,g10
g11,g12,g13,g14,g15,g16,g17,g18,g19,g20
g21,g22,g23,g24,g25,g26,g27,g22a,g23a    General CWN constraints
l1,l2,l3,l4,l5,l6,l7,l8,l9,l10
l11,l12,l13,l14,l15,l16,l17,l18,l19,l20
l21,l22,l23,l24,l25,l26,l27,l28,l29,l30
l31,l32                                  Linear CWN constraints
n1,n2,n3,n4,n5                           Nonlinear CWN constraints
;

$Ontext
-----------------------------Scheduling constraints-----------------------------
$Offtext

s1(p)$(ord(p) = 1)..                     T(p) =E= 0;
s2(p)$(ord(p) = card(p))..               T(p) =E= H;
s3(p)$(ord(p) ne card(p))..              T(p+1) =G= T(p);
s4(j,p)..                                sum(i$(ij(i,j)),Ws(i,p)) =L= 1;
s5(j,p)..                                sum(i$(ij(i,j)),Wf(i,p)) =L= 1;
s6(i)..                                  sum(p,Ws(i,p)) =E= sum(p,Wf(i,p));
s7(s,p)$(ord(p) ne 1)..                  SA(s,p) + SS(s,p) =E= SA(s,p-1) + sum(i$(ps(i,s)),BO(i,s,p)) - sum(i$(is(i,s)),BI(i,s,p));
s8(s,p)..                                SA(s,p) =L= Sc(s);
s9(s,p)$(ord(p) = 1)..                   SA(s,p) + SS(s,p) =E= Sc_0(s) + sum(i$(ps(i,s)),BO(i,s,p)) - sum(i$(is(i,s)),BI(i,s,p));
s10..                                    Z =E= sum(s,sum(p,zeta(s)*SS(s,p))) - 2*sum(p,CW(p)) - 100*CT;
s11(j,p)..                               sum(i$(ij(i,j)),sum(pp$(ord(pp) le ord(p)),Ws(i,pp) - Wf(i,pp))) =L= 1;
s12(i,p)$(ord(p) = 1)..                  Wf(i,p) =E= 0;
s13(i,p)$(ord(p) = card(p))..            Ws(i,p) =E= 0;
s14(i,p)..                               Tau(i,p) =E= (alpha(i)*Ws(i,p)) + (beta(i)*Bs(i,p));
s15(i,p)..                               Tf(i,p) =L= Ts(i,p) + Tau(i,p) + H*(1-Ws(i,p));
s16(i,p)..                               Tf(i,p) =G= Ts(i,p) + Tau(i,p) - H*(1-Ws(i,p));
s17(i,p)$(ord(p) ne 1)..                 Tf(i,p) - Tf(i,p-1) =L= H*Ws(i,p);
s18(i,p)$(ord(p) = 1)..                  Tf(i,p) =L= H*Ws(i,p);
s19(i,p)$(ord(p) ne 1)..                 Tf(i,p) - Tf(i,p-1) =G= Tau(i,p);
s20(i,p)$(ord(p) = 1)..                  Tf(i,p) =G= Tau(i,p);
s21(i,p)..                               Ts(i,p) =E= T(p);
s22(i,p)$(ord(p) ne 1)..                 Tf(i,p-1) =L= T(p) + H*(1-Wf(i,p));
s23(i,p)$((zw(i)) and (ord(p) ne 1))..   Tf(i,p-1) =G= T(p) - H*(1-Wf(i,p));
s24(i,p)..                               Bs(i,p) =G= B_L(i)*Ws(i,p);
s25(i,p)..                               Bs(i,p) =L= B_U(i)*Ws(i,p);
s26(i,p)..                               Bf(i,p) =G= B_L(i)*Wf(i,p);
s27(i,p)..                               Bf(i,p) =L= B_U(i)*Wf(i,p);
s28(i,p)..                               Bp(i,p) =G= B_L(i)*(sum(pp$(ord(pp) lt ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
s29(i,p)..                               Bp(i,p) =L= B_U(i)*(sum(pp$(ord(pp) lt ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
s30(i,p)$(ord(p) gt 1)..                 Bs(i,p-1) + Bp(i,p-1) =E= Bp(i,p) + Bf(i,p);
s31(i,s,p)$(si(s,i))..                   BI(i,s,p) =E= rho(i,s)*Bs(i,p);
s32(i,s,p)$(si(s,i))..                   BI(i,s,p) =L= B_U(i)*rho(i,s)*Ws(i,p);
s33(i,s,p)$(so(s,i))..                   BO(i,s,p) =E= rho(i,s)*Bf(i,p);
s34(i,s,p)$(so(s,i))..                   BO(i,s,p) =L= B_U(i)*rho(i,s)*Wf(i,p);
s35(j)..                                 sum(i$(ij(i,j)),sum(p,Tau(i,p))) =L= H;
s36(j,p)..                               sum(i$(ij(i,j)),sum(pp$(ord(pp) ge ord(p)),Tau(i,pp))) =L= H - T(p);
s37(j,p)..                               sum(i$(ij(i,j)),sum(pp$(ord(pp) le ord(p)),(alpha(i)*Wf(i,pp)) + (beta(i)*Bf(i,pp)))) =L= T(p);

$Ontext
-------------------------------General constraints------------------------------
$Offtext

g1(i,p)..                                Qi(i,p) =E= Q(i)*Ws(i,p);
g2(i,p)..                                Qo(i,p) =E= Q(i)*Wf(i,p);
g3(i,p)$(ord(p) gt 1)..                  Qu(i,p) =E= Qu(i,p-1) - Qo(i,p) + Qi(i,p);
g4(i,p)$(ord(p) = 1)..                   Qu(i,p) =E= Qi(i,p);
*!!! Must also be active when the unit is still being processed!!!!!
g5(p)..                                  CW(p) =E= sum(n,OS(n,p));
*g6(n,p)..                                OS(n,p) =E= sum(i,CS(n,i,p)) - M(n,p) + B(n,p);
*g7(n,p)..                                OS(n,p) =E= sum(i,CR(n,i,p)) - D(n,p) - E(n,p);
g6(n,p)..                                OS(n,p) =E= sum(i,CS(n,i,p));
g7(n,p)..                                OS(n,p) =E= sum(i,CR(n,i,p));
g8(i,p)..                                Fin(i,p) =E= sum(n,CS(n,i,p)) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i,p));
g9(i,p)..                                Fout(i,p) =E= sum(n,CR(n,i,p)) + sum(ii$(ord(ii) ne ord(i)),FR(i,ii,p));
g10(i,p)..                               Fin(i,p) =E= Fout(i,p);
*g11(n,p)..                               OS(n,p) =L= OS_U(n)*yCT(n);
g11(n,p)..                               OS(n,p) =L= OS_U(n);
g12(i,p)..                               Tout(i,p) =L= Tout_U(i)*(sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
g13(i,p)..                               Tout(i,p) =G= Tout_L*(sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
g14(i,p)..                               Fin(i,p) =L= (Fin_U(i))*(sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
g15(ii,i,p)$(ord(ii) ne ord(i))..        FR(ii,i,p) =L= Fin_U(i)*(sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
g16(ii,i,p)$(ord(ii) ne ord(i))..        FR(ii,i,p) =L= Fin_U(i)*(sum(pp$(ord(pp) le ord(p)),Ws(ii,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(ii,pp)));
g17(ii,i,p)$(ord(ii) ne ord(i))..        yr(ii,i,p) + yr(i,ii,p) =L= 1;
g18(ii,i,p)$(ord(ii) ne ord(i))..        FR(ii,i,p) =L= Fin_U(i)*yr(ii,i,p);
g19(ii,i,p)$(ord(ii) ne ord(i))..        FR(ii,i,p) =L= Fin(i,p);
g20(ii,i,p)$(ord(ii) ne ord(i))..        FR(ii,i,p) =L= Fin(ii,p);
g21..                                    CT =E= sum(n,yCT(n));
* Check the effect of this equation on the model
g22a(n,i,p)..                            CS(n,i,p) =L= OS_U(n)*(sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
g23a(n,i,p)..                            CR(n,i,p) =L= OS_U(n)*(sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
g22(n,i,p)..                             CS(n,i,p) =L= C_U(n)*(sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
g23(n,i,p)..                             CR(n,i,p) =L= C_U(n)*(sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
g24(n,p)..                               sum(nn,R(nn,n,p)) =L= OS_U(n);
*g25(n,p)..                               D(n,p) =E= 0.002*(sum(i,CR(n,i,p)) + sum(nn,R(nn,n,p)));
g25(n,p)..                               D(n,p) =E= 0.002*(sum(i,CR(n,i,p)));
g26(n,p)..                               B(n,p) =E= E(n,p)/(CC-1);
g27(n,p)..                               M(n,p) =E= D(n,p) + E(n,p) + B(n,p);

$Ontext
-------------------------------Linear constraints-------------------------------
$Offtext

l1(n,p)..                                E(n,p) =E= 0.00085*1.8*(sum(i,y5(n,i,p))-sum(i,CR(n,i,p)*TWout(n)));
* Why is the CW return term not included?
*l2(n,p)..                                sum(i,y1(n,i,p)) + sum(nn,R(nn,n,p)*TWout(nn)) =L= TWin_U(n)*sum(i,CR(n,i,p));
l2(n,p)..                                sum(i,y1(n,i,p)) =L= TWin_U(n)*sum(i,CR(n,i,p));
* Why is this equation not included in the nonlinear side?
l3(i,p)..                                (Qu(i,p)*3600/cp) + sum(n,CS(n,i,p)*TWout(n)) + sum(ii$(ord(ii) ne ord(i)),y2(ii,i,p)) =E= y3(i,p);
*l4(n,p)..                                sum(i,y4(n,i,p)) =E= M(n,p)*Tamb + (OS(n,p) - B(n,p) - sum(nn,R(n,nn,p)))*TWout(n);
l4(n,p)..                                sum(i,y4(n,i,p)) =E= M(n,p)*Tamb + (OS(n,p) - B(n,p))*TWout(n);
*l5(n,p)..                                sum(i,y5(n,i,p)) + sum(nn,y6(nn,n,p)) =E= sum(i,y1(n,i,p)) + sum(nn,R(nn,n,p)*TWout(nn));
l5(n,p)..                                sum(i,y5(n,i,p))=E= sum(i,y1(n,i,p));

l6(ii,i,p)$(ord(ii) ne ord(i))..         Wr(ii,i,p) =L= (sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
l7(ii,i,p)$(ord(ii) ne ord(i))..         Wr(ii,i,p) =L= (sum(pp$(ord(pp) le ord(p)),Ws(ii,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(ii,pp)));
l8(ii,i,p)$(ord(ii) ne ord(i))..         Wr(ii,i,p) =E= Wr(i,ii,p);

l9(n,i,p)..                              y1(n,i,p) =G= ((Fin_U(i)*Tout(i,p)) + (CR(n,i,p)*Tout_U(i)) - (Fin_U(i)*Tout_U(i)));
l10(n,i,p)..                             y1(n,i,p) =L= (Fin_U(i)*Tout(i,p) + CR(n,i,p)*Tout_L - ((sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)))*Fin_U(i)*Tout_L));
l11(n,i,p)..                             y1(n,i,p) =L= CR(n,i,p)*Tout_U(i);
l12(n,i,p)..                             y1(n,i,p) =G= CR(n,i,p)*Tout_L;

l13(ii,i,p)$(ord(ii) ne ord(i))..        y2(ii,i,p) =G= ((Fin_U(i)*Tout(ii,p)) + (FR(ii,i,p)*Tout_U(ii)) - (Fin_U(i)*Tout_U(ii)));
l14(ii,i,p)$(ord(ii) ne ord(i))..        y2(ii,i,p) =L= (Fin_U(i)*Tout(ii,p) + FR(ii,i,p)*Tout_L - Wr(ii,i,p)*Fin_U(i)*Tout_L);
l15(ii,i,p)$(ord(ii) ne ord(i))..        y2(ii,i,p) =L= FR(ii,i,p)*Tout_U(ii);
l16(ii,i,p)$(ord(ii) ne ord(i))..        y2(ii,i,p) =G= FR(ii,i,p)*Tout_L;

l17(i,p)..                               y3(i,p) =G= ((Fin_U(i)*Tout(i,p)) + (Fin(i,p)*Tout_U(i)) - (Fin_U(i)*Tout_U(i)));
l18(i,p)..                               y3(i,p) =L= ((Fin_U(i)*Tout(i,p)) + (Fin(i,p)*Tout_L) - ((sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)))*Fin_U(i)*Tout_L));
l19(i,p)..                               y3(i,p) =L= Fin(i,p)*Tout_U(i);
l20(i,p)..                               y3(i,p) =G= Fin(i,p)*Tout_L;

l21(n,i,p)..                             y4(n,i,p) =G= (Fin_U(i)*Tsup(n,p) + CS(n,i,p)*Tamb - Fin_U(i)*Tamb);
l22(n,i,p)..                             y4(n,i,p) =L= (Fin_U(i)*Tsup(n,p) + CS(n,i,p)*Tcmin - ((sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)))*Fin_U(i)*Tcmin));
l23(n,i,p)..                             y4(n,i,p) =L= CS(n,i,p)*Tamb;
l24(n,i,p)..                             y4(n,i,p) =G= CS(n,i,p)*Tcmin;

l25(n,i,p)..                             y5(n,i,p) =G= (Fin_U(i)*TWin(n,p) + CR(n,i,p)*TWin_U(n) - Fin_U(i)*TWin_U(n));
l26(n,i,p)..                             y5(n,i,p) =L= (Fin_U(i)*TWin(n,p) + CR(n,i,p)*Tcmin - ((sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)))*Fin_U(i)*Tcmin));
l27(n,i,p)..                             y5(n,i,p) =L= CR(n,i,p)*TWin_U(n);
l28(n,i,p)..                             y5(n,i,p) =G= CR(n,i,p)*Tcmin;

l29(nn,n,p)..                            y6(nn,n,p) =G= (OS_U(n)*TWin(n,p)) + R(nn,n,p)*TWin_U(n) - OS_U(n)*TWin_U(n);
l30(nn,n,p)..                            y6(nn,n,p) =L= (OS_U(n)*TWin(n,p)) + R(nn,n,p)*TWout(nn) - OS_U(n)*TWout(nn);
l31(nn,n,p)..                            y6(nn,n,p) =L= R(nn,n,p)*TWin_U(n);
l32(nn,n,p)..                            y6(nn,n,p) =G= R(nn,n,p)*TWout(nn);

$Ontext
------------------------------Nonlinear constraints-----------------------------
$Offtext

n1(i,p)..                                0.01*((Qu(i,p)*3600/cp) + sum(n,CS(n,i,p)*TWout(n)) + sum(ii$(ord(ii) ne ord(i)),FR(ii,i,p)*Tout(ii,p))) =E= 0.01*Fout(i,p)*Tout(i,p);
*n2(n,p)..                                TWin(n,p)*(sum(i,CR(n,i,p)) + sum(nn,R(nn,n,p))) =E= sum(i,CR(n,i,p)*Tout(i,p)) + sum(nn,R(nn,n,p)*TWout(nn));
n2(n,p)..                                TWin(n,p)*(sum(i,CR(n,i,p))) =E= sum(i,CR(n,i,p)*Tout(i,p));
n3(n,p)..                                TWin(n,p) =L= TWin_U(n);
*n4(n,p)..                                E(n,p) =E= 0.00085*1.8*(sum(i,CR(n,i,p)) + sum(nn,R(nn,n,p)))*(TWin(n,p)-TWout(n));
n4(n,p)..                                E(n,p) =E= 0.00085*1.8*(sum(i,CR(n,i,p)))*(TWin(n,p)-TWout(n));
*n5(n,p)..                                Tsup(n,p)*sum(i,CS(n,i,p)) =E= M(n,p)*Tamb + (OS(n,p) - B(n,p) - sum(nn,R(n,nn,p)))*TWout(n);
n5(n,p)..                                Tsup(n,p)*sum(i,CS(n,i,p)) =E= M(n,p)*Tamb + (OS(n,p) - B(n,p))*TWout(n);

$Ontext
-----------------------------------Boundaries-----------------------------------
$Offtext

*FR.fx(ii,i,p) = 0;
Fin.UP(i,p) = Fin_U(i);
Tout.UP(i,p) = Tout_U(i);
TWin.UP(n,p) = TWin_U(n);
OS.UP(n,p) = OS_U(n);


Model Maravelias_Grossmann_2003_1a /s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,s31,s32,s33,s34,s35,s36,s37,g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,g17,g18,g19,g20,g21,g22,g23,g25,g26,g27,l1,l2,l3,l4,l5,l6,l7,l8,l9,l10,l11,l12,l13,l14,l15,l16,l17,l18,l19,l20,l21,l22,l23,l24,l25,l26,l27,l28/;
Option SYSOUT = ON;
Options LIMROW = 1e9;
Options MIP = CPLEX;
Option  optcr = 0.000001;
Maravelias_Grossmann_2003_1a.optfile=1
$onecho > cplex.opt
iis              1
$offecho
Solve Maravelias_Grossmann_2003_1a using MINLP maximising Z;

Model Maravelias_Grossmann_2003_1b /s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,s31,s32,s33,s34,s35,s36,s37,g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,g17,g18,g19,g20,g21,g22,g23,g25,g26,g27,n1/;
Options RESLIM = 3000000000;
Option SYSOUT = ON;
Options LIMROW = 1e9;
*Options MINLP = BARON;
*Options MIP = CPLEX;
Option  optcr = 0.1;
Maravelias_Grossmann_2003_1b.optfile=1
$onecho > cplex.opt
iis              1
$offecho
$onecho > dicopt.opt
maxcycles        10000
$offecho
Solve Maravelias_Grossmann_2003_1b using MINLP maximising Z;



Model Maravelias_Grossmann_2003_1c /s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,s31,s32,s33,s34,s35,s36,s37,g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,g17,g18,g19,g20,g21,g22,g23,g25,g26,g27,n1,n2,n4/;
Options RESLIM = 3000000000;
Option SYSOUT = ON;
Options LIMROW = 1e9;
*Options MINLP = BARON;
*Options MIP = CPLEX;
Option  optcr = 0.1;
Maravelias_Grossmann_2003_1c.optfile=1
$onecho > cplex.opt
iis              1
$offecho
$onecho > dicopt.opt
maxcycles        10000
$offecho
Solve Maravelias_Grossmann_2003_1c using MINLP maximising Z;


Model Maravelias_Grossmann_2003_1d /s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,s31,s32,s33,s34,s35,s36,s37,g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,g17,g18,g19,g20,g21,g22,g23,g25,g26,g27,n1,n2,n4,n5/;
Options RESLIM = 3000000000;
Option SYSOUT = ON;
Options LIMROW = 1e9;
*Options MINLP = BARON;
*Options MIP = CPLEX;
Option  optcr = 0.1;
Maravelias_Grossmann_2003_1d.optfile=1
$onecho > cplex.opt
iis              1
$offecho
$onecho > dicopt.opt
maxcycles        10000
$offecho
Solve Maravelias_Grossmann_2003_1d using MINLP maximising Z;
Tin(i,p) = ((sum(n,CS.L(n,i,p)*TWout(n))) + sum(ii$(ord(ii) ne ord(i)),FR.L(ii,i,p)*Tout.L(ii,p)))/Fin.L(i,p);
Display Tin,OS_U,C_U;


$Ontext
*$Ontext
CT Losses and Supply Temperature
*$Offtext

Model Maravelias_Grossmann_2003_1c /s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,s31,s32,s33,s34,s35,s36,s37,g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,g17,g18,g19,g20,g21,g22,g23,g25,g26,g27,l1,l3,l4,l6,l7,l8,l13,l14,l15,l16,l17,l18,l19,l20,l21,l22,l23,l24,l25,l26,l27,l28/;
Option SYSOUT = ON;
Options LIMROW = 1e9;
Options MIP = CPLEX;
Option  optcr = 0.000001;
Maravelias_Grossmann_2003_1c.optfile=1
*$onecho > cplex.opt
iis              1
*$offecho
Solve Maravelias_Grossmann_2003_1c using MINLP maximising Z;

Model Maravelias_Grossmann_2003_1d /s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,s31,s32,s33,s34,s35,s36,s37,g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,g17,g18,g19,g20,g21,g22,g23,g25,g26,g27,n1,n4,n5/;
Options RESLIM = 3000000000;
Option SYSOUT = ON;
Options LIMROW = 1e9;
*Options MINLP = BARON;
*Options MIP = CPLEX;
*Option  optcr = 0.1;
Maravelias_Grossmann_2003_1d.optfile=1
*$onecho > cplex.opt
iis              1
*$offecho
*$onecho > dicopt.opt
maxcycles        10000
*$offecho
Solve Maravelias_Grossmann_2003_1d using MINLP maximising Z;
Tin(i,p) = ((sum(n,CS.L(n,i,p)*TWout(n))) + sum(ii$(ord(ii) ne ord(i)),FR.L(ii,i,p)*Tout.L(ii,p)))/Fin.L(i,p);
Display Tin,OS_U,C_U;
$Offtext

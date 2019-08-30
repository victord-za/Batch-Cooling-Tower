$Title Case1_Opt
$OnEmpty
$Ontext
         Case study 1
         Optimal scenario
$Offtext

Sets
i                Tasks
                 /i1*i6/
j                Equipment units
                 /j1*j3/
n                Cooling water sources supplying the cooling water network
                 /n1*n3/
p                Time points
                 /p1*p9/
s                States
                 /s1*s7/
ij(i,j)          Set of tasks that can be scheduled on equipment unit j
                 /i1.j1,i2.j2,i3.j1,i4.j2,i5.j3,i6.j3/
ii(i,s)          Set of tasks that use state s as input
                 /i1.s1,i1.s3,i2.s1,i2.s3,i3.s2,i4.s2,i5.s5,i6.s4,i6.s5/
io(i,s)          Set of tasks that produce state s
                 /i1.s5,i2.s5,i3.s3,i3.s4,i4.s3,i4.s4,i5.s6,i6.s7/
si(s,i)          Set of states consumed in task i
                 /s1.i1,s1.i2,s2.i3,s2.i4,s3.i1,s3.i2,s4.i6,s5.i5,s5.i6/
so(s,i)          Set of states produced from task i
                 /s3.i3,s3.i4,s4.i3,s4.i4,s5.i1,s5.i2,s6.i5,s7.i6/
zcw(i)           Set of task that produce at least one ZW state or require CW
                 /i1,i2,i3,i4,i5,i6/
;

Alias
(p,pp),(i,ip),(n,nn)
;

Positive variables
Approach(n,p)    Approach temperature for cooling tower n at time point p (C)
B(n,p)           Blowdown flow from cooling tower n at time point p (t.h^-1)
Bs(i,p)          Batch size of task i that starts at time point p (t.h^-1)
Bp(i,p)          Batch size of task i that is being processed at time point p (t.h^-1)
Bf(i,p)          Batch size of task i that finishes at or before time point p (t.h^-1)
BI(i,s,p)        Amount of state s used as input for task i at time point p (t.h^-1)
BO(i,s,p)        Amount of state s produced from task i at or before time point p (t.h^-1)
cPO(p)           Operational cost during time point p ($)
cVC(n)           Variable capital cost associated with cooling tower n ($)
cVCP(n,p)        Variable capital cost associated with cooling tower n at time point p ($)
cTC              Total capital costs ($)
cTO              Total operational costs ($)
cTR              Total raw material costs ($)
CR(n,i,p)        Return cooling water flow to cooling water source n from cooling-water-using operation i at time point p (t.h^-1)
CS(n,i,p)        Cooling water flow supplied from cooling water source n to cooling-water-using operation i at time point p (t.h^-1)
CT               Total number of active cooling towers
CW               Total cooling water flow rate supplied from all cooling towers (t.h^-1)
D(n,p)           Drift loss in cooling tower n at time point p (t.h^-1)
E(n,p)           Evaporation loss in cooling tower n at time point p (t.h^-1)
Fin(i,p)         Total cooling water flow into cooling-water-using operation i including supply and reused water at time point p(t.h^-1)
Fout(i,p)        Total cooling water flow from cooling-water-using operation i including return and reused water at time point p (t.h^-1)
FR(ip,i,p)       Reused cooling water flow from any other cooling-water-using operation ip to cooling-water-using operation i at time point p (t.h^-1)
M(n,p)           Makeup water flow to cooling tower n at time point p (t.h^-1)
OS(n,p)          Total cooling water flow supplied from cooling water source n (t.h^-1)
Qi(i,p)          Amount of cooling duty provided to task i from time point p (kW)
Qo(i,p)          Amount of cooling duty provided to task i until time point p (kW)
Qu(i,p)          Amount of cooling duty utilized at time point p (kW)
R(nn,n,p)        Cooling water recycled directly from cooling tower nn to cooling tower n at time point p (t.h^-1)
Range(n,p)       Range temperature for cooling tower n at time point p (C)
SA(s,p)          Amount of state s available at time point p (t)
SS(s,p)          Sales of state s at point p (t)
t(p)             Time that corresponds to time point p (h)
Tau(i,p)         Duration of task i that starts at time point p (h)
Tsup(n,p)        Supply temperature from cooling tower n at time point p to cooling water network (C)
ts(i,p)          Start time of task i that starts at time point p (h)
tf(i,p)          Finish time of task i that starts at time point p (h)
y1(n,i,p)        Linearisation variable 1 for term CR(n.i.p)*Tout(i.p)
y2(ip,i,p)       Linearisation variable 2 for term FR(ip.i.p)*Tout(ip.p)
y3(i,p)          Linearisation variable 3 for term Fin(i.p)*Tout(i.p)
y4(n,i,p)        Linearisation variable 4 for term CS(n.i.p)*Tsup(n.p)
y5(n,i,p)        Linearisation variable 5 for term CR(n.i.p)*Tret(n.p)
y6(nn,n,p)       Linearisation variable 6 for term R(nn.n.p)*Tsup(n.p)
y7(nn,n,p)       Linearisation variable 7 for term R(nn.n.p)*Tret(n.p)
Tout(i,p)        Outlet cooling water temperature from cooling-water-using operation i at time point p(C)
Tret(n,p)        Return temperature to cooling water source n at time point p (C)
;

Binary variables
Wr(ip,i,p)       Binary variable indicating whether tasks ip and i both take place during time point p
Ws(i,p)          Binary variable indicating whether task i starts at time point p
Wp(i,p)          Binary variable indicating whether task i is being processed at time point p
Wf(i,p)          Binary variable indicating whether task i finishes at or before time point p
yVC(n,p)         Binary variable associated with variable cooling tower costing
yCT(n)           Binary variable indicating activity of cooling tower n
yr(ip,i,p)       Binary variable indicating whether cooling water is reused by task i from task ip during time point p
Zs(j,p)          Binary variable indicating whether a task in I(j) is assigned to start in unit j at time point p
Zp(j,p)          Binary variable indicating whether a task in I(j) is being processed in unit j at time point p
Zf(j,p)          Binary variable indicating whether a task in I(j) assigned to unit j finishes at or before time point p
;

Free variables
Profitl
Profit
;

Parameters
alpha(i)         Fixed duration of task i (h)
                 /i1     0.5
                  i2     0.5
                  i3     0.75
                  i4     0.75
                  i5     0.25
                  i6     0.5/
B_L(i)           Lower bound on the batch size of task i (t)
                 /i1     40
                  i2     25
                  i3     40
                  i4     25
                  i5     40
                  i6     40/
B_U(i)           Upper bound on the batch size of task i (t)
                 /i1     80
                  i2     50
                  i3     80
                  i4     50
                  i5     80
                  i6     80/
beta(i)          Variable duration of task i (h.t^-1)
                 /i1     0.025
                  i2     0.04
                  i3     0.0375
                  i4     0.06
                  i5     0.0125
                  i6     0.025/
cRM(s)           Raw material cost ($.t^-1)
                 /s1     10
                  s2     15
                  s3     0
                  s4     0
                  s5     0
                  s6     0
                  s7     0/
CRS_U(n)         Maximum cooling water flow supplied from or returned to cooling water source n (t.h^-1)
Fin_U(i)         Maximum flowrate through cooling-water-using operation i (t.h^-1)
OS_U(n)          Design capacity of cooling water source n (t.h^-1)
                 /n1     30
                  n2     40
                  n3     40/
Q(i)             Heat of reaction of cooling-water-using operation i (kW.t^-1)
                 /i1     13
                  i2     13
                  i3     18
                  i4     18
                  i5     6
                  i6     15/

Sc_0(s)          Initial amount of state s (t)
                 /s1     400
                  s2     400
                  s3     0
                  s4     0
                  s5     0
                  s6     0
                  s7     0/
Sc(s)            Storage capacity for state s (t)
                 /s1     1000
                  s2     1000
                  s3     200
                  s4     100
                  s5     500
                  s6     1000
                  s7     1000/
Tct_L            Minimum cooling water temperature (C)
Tin(i,p)         Cooling water temperature into task i at time point p (C)
Tin_U(i)         Limiting inlet temperature to cooling-water-using operation i (C)
                 /i1     30
                  i2     30
                  i3     40
                  i4     40
                  i5     25
                  i6     45/
Tout_U(i)        Limiting outlet temperature from cooling-water-using operation i (C)
                 /i1     45
                  i2     45
                  i3     55
                  i4     55
                  i5     50
                  i6     60/
Tret_U(n)        Maximum return temperature to cooling water source n (C)
                 /n1     52
                  n2     52
                  n3     50/
Tct(n)         Cooling water supply temperature from cooling water source n (C)
                 /n1     20
                  n2     22
                  n3     25/
zeta(s)          Price of state s ($.t^-1)
                 /s1     0
                  s2     0
                  s3     0
                  s4     0
                  s5     0
                  s6     30
                  s7     40/
;

Scalars
BM               Large number for Big-M constraints
                 /5000/
CC               Cycles of concentration
                 /4/
cFC              Fixed cost associated with existence of a cooling tower ($)
                 /9.3024855/
cp               Specific heat capacity of water (J.(kg.C)^-1)
                 /4187/
H                Time horizon (h)
                 /8/
Tamb             Ambient temperature (C)
                 /25/
Tout_L           Limiting outlet temperature from cooling-water-using operation i (C)
                 /30/
Twb              Wet bulb temperature (C)
                 /17/
;

Table rho(i,s)   Mass balance coefficient for the consumption or production of state s in task i
                 s1      s2      s3      s4      s5      s6      s7
         i1      0.8     0       0.2     0       1       0       0
         i2      0.8     0       0.2     0       1       0       0
         i3      0       1       0.3     0.7     0       0       0
         i4      0       1       0.3     0.7     0       0       0
         i5      0       0       0       0       1       1       0
         i6      0       0       0       0.6     0.4     0       1
;

CRS_U(n) = OS_U(n)*(1.002+(0.00153*(Tret_U(n)-Tct(n))));
Fin_U(i) = Q(i)*3600/(cp*(Tout_U(i)-Tin_U(i)));
Tct_L = smin(n,Tct(n));

Equations
s1,s2,s3,s4,s5,s6,s7,s8,s9,s10
s11,s12,s13,s14,s15,s16,s17,s18,s19,s20
s21,s22,s23,s24,s25,s26,s27,s28,s29,s30
s31,s32,s33,s34,s35,s36                  Scheduling constraints
g1,g2,g3,g4,g5,g6,g6a,g7,g7a,g8,g9,g10
g11,g12,g13,g14,g15,g16,g17,g18,g19,g20
g21,g22,g23,g24,g25,g26,g27,g28,g29      General CWN constraints
l1,l2,l3,l4,l5,l6,l7,l8,l9,l10
l11,l12,l13,l14,l15,l16,l17,l18,l19,l20
l21,l22,l23,l24,l25,l26,l27,l28,l29,l30
l31,l32,l33,l34,l35                      Linear CWN constraints
n1,n2,n3,n4                              Nonlinear CWN constraints
c1,c2,c3,c4,c5,c6,c7,c8,c9,c10           Costing constraints
;

$Ontext
-----------------------------Scheduling constraints-----------------------------
$Offtext

s1(p)$(ord(p) = 1)..                     t(p) =E= 0;
s2(p)$(ord(p) = card(p))..               t(p) =E= H;
s3(p)$(ord(p) ne card(p))..              t(p+1) =G= t(p);
s4(j,p)..                                sum(i$(ij(i,j)),Ws(i,p)) =L= 1;
s5(j,p)..                                sum(i$(ij(i,j)),Wf(i,p)) =L= 1;
s6(i)..                                  sum(p,Ws(i,p)) =E= sum(p,Wf(i,p));
s7(s,p)$(ord(p) ne 1)..                  SA(s,p) + SS(s,p) =E= SA(s,p-1) + sum(i$(io(i,s)),BO(i,s,p)) - sum(i$(ii(i,s)),BI(i,s,p));
s8(s,p)..                                SA(s,p) =L= Sc(s);
s9(s,p)$(ord(p) = 1)..                   SA(s,p) + SS(s,p) =E= Sc_0(s) + sum(i$(io(i,s)),BO(i,s,p)) - sum(i$(ii(i,s)),BI(i,s,p));
s10(j,p)..                               sum(i$(ij(i,j)),sum(pp$(ord(pp) le ord(p)),Ws(i,pp) - Wf(i,pp))) =L= 1;
s11(i,p)$(ord(p) = 1)..                  Wf(i,p) =E= 0;
s12(i,p)$(ord(p) = card(p))..            Ws(i,p) =E= 0;
s13(i,p)..                               Tau(i,p) =E= (alpha(i)*Ws(i,p)) + (beta(i)*Bs(i,p));
s14(i,p)..                               tf(i,p) =L= ts(i,p) + Tau(i,p) + H*(1-Ws(i,p));
s15(i,p)..                               tf(i,p) =G= ts(i,p) + Tau(i,p) - H*(1-Ws(i,p));
s16(i,p)$(ord(p) ne 1)..                 tf(i,p) - tf(i,p-1) =L= H*Ws(i,p);
s17(i,p)$(ord(p) = 1)..                  tf(i,p) =L= H*Ws(i,p);
s18(i,p)$(ord(p) ne 1)..                 tf(i,p) - tf(i,p-1) =G= Tau(i,p);
s19(i,p)$(ord(p) = 1)..                  tf(i,p) =G= Tau(i,p);
s20(i,p)..                               ts(i,p) =E= t(p);
s21(i,p)$(ord(p) ne 1)..                 tf(i,p-1) =L= t(p) + H*(1-Wf(i,p));
s22(i,p)$((zcw(i)) and (ord(p) ne 1))..  tf(i,p-1) =G= t(p) - H*(1-Wf(i,p));
s23(i,p)..                               Bs(i,p) =G= B_L(i)*Ws(i,p);
s24(i,p)..                               Bs(i,p) =L= B_U(i)*Ws(i,p);
s25(i,p)..                               Bf(i,p) =G= B_L(i)*Wf(i,p);
s26(i,p)..                               Bf(i,p) =L= B_U(i)*Wf(i,p);
s27(i,p)..                               Bp(i,p) =G= B_L(i)*(sum(pp$(ord(pp) lt ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
s28(i,p)..                               Bp(i,p) =L= B_U(i)*(sum(pp$(ord(pp) lt ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
s29(i,p)$(ord(p) gt 1)..                 Bs(i,p-1) + Bp(i,p-1) =E= Bp(i,p) + Bf(i,p);
s30(i,s,p)$(si(s,i))..                   BI(i,s,p) =E= rho(i,s)*Bs(i,p);
s31(i,s,p)$(si(s,i))..                   BI(i,s,p) =L= B_U(i)*rho(i,s)*Ws(i,p);
s32(i,s,p)$(so(s,i))..                   BO(i,s,p) =E= rho(i,s)*Bf(i,p);
s33(i,s,p)$(so(s,i))..                   BO(i,s,p) =L= B_U(i)*rho(i,s)*Wf(i,p);
s34(j)..                                 sum(i$(ij(i,j)),sum(p,Tau(i,p))) =L= H;
s35(j,p)..                               sum(i$(ij(i,j)),sum(pp$(ord(pp) ge ord(p)),Tau(i,pp))) =L= H - t(p);
s36(j,p)..                               sum(i$(ij(i,j)),sum(pp$(ord(pp) le ord(p)),(alpha(i)*Wf(i,pp)) + (beta(i)*Bf(i,pp)))) =L= t(p);

$Ontext
-------------------------------General constraints------------------------------
$Offtext

g1(i,p)..                                Qi(i,p) =E= Q(i)*Bs(i,p);
g2(i,p)..                                Qo(i,p) =E= Q(i)*Bf(i,p);
g3(i,p)$(ord(p) gt 1)..                  Qu(i,p) =E= Qu(i,p-1) - Qo(i,p) + Qi(i,p);
g4(i,p)$(ord(p) = 1)..                   Qu(i,p) =E= Qi(i,p);
g5(p)$(ord(p) ne card(p))..              CW =E= sum(n,OS(n,p));
g6(n,p)..                                OS(n,p) =E= sum(i,CS(n,i,p)) + sum(nn,R(n,nn,p)) - M(n,p) + B(n,p);
g7(n,p)..                                OS(n,p) =E= sum(i,CR(n,i,p)) + sum(nn,R(nn,n,p)) - D(n,p) - E(n,p);
g6a(n,p)..                               OS(n,p) =E= sum(i,CS(n,i,p)) + sum(nn,R(n,nn,p));
g7a(n,p)..                               OS(n,p) =E= sum(i,CR(n,i,p)) + sum(nn,R(nn,n,p));
g8(i,p)..                                Fin(i,p) =E= sum(n,CS(n,i,p)) + sum(ip$(ord(ip) ne ord(i)),FR(ip,i,p));
g9(i,p)..                                Fout(i,p) =E= sum(n,CR(n,i,p)) + sum(ip$(ord(ip) ne ord(i)),FR(i,ip,p));
g10(i,p)..                               Fin(i,p) =E= Fout(i,p);
g11(n,p)..                               OS(n,p) =L= OS_U(n)*yCT(n);
g12(i,p)..                               Tout(i,p) =L= Tout_U(i)*(sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
g13(i,p)..                               Tout(i,p) =G= Tout_L*(sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
g14(i,p)..                               Fin(i,p) =L= (Fin_U(i))*(sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
g15(ip,i,p)$(ord(ip) ne ord(i))..        FR(ip,i,p) =L= Fin_U(i)*(sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
g16(ip,i,p)$(ord(ip) ne ord(i))..        FR(ip,i,p) =L= Fin_U(i)*(sum(pp$(ord(pp) le ord(p)),Ws(ip,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(ip,pp)));
g17(ip,i,p)$(ord(ip) ne ord(i))..        yr(ip,i,p) + yr(i,ip,p) =L= 1;
g18(ip,i,p)$(ord(ip) ne ord(i))..        FR(ip,i,p) =L= Fin_U(i)*yr(ip,i,p);
g19(ip,i,p)$(ord(ip) ne ord(i))..        FR(ip,i,p) =L= Fin(i,p);
g20(ip,i,p)$(ord(ip) ne ord(i))..        FR(ip,i,p) =L= Fin(ip,p);
g21..                                    CT =E= sum(n,yCT(n));
g22(n,i,p)..                             CS(n,i,p) =L= CRS_U(n)*(sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
g23(n,i,p)..                             CR(n,i,p) =L= CRS_U(n)*(sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
g24(n,p)..                               sum(nn,R(nn,n,p)) =L= OS_U(n);
g25(n,p)..                               D(n,p) =E= 0.002*(sum(i,CR(n,i,p)) + sum(nn,R(nn,n,p)));
g26(n,p)..                               B(n,p) =E= E(n,p)/(CC-1);
g27(n,p)..                               M(n,p) =E= D(n,p) + E(n,p) + B(n,p);
g28(n,p)..                               Range(n,p) =E= Tret(n,p) - Tct(n);
g29(n,p)..                               Approach(n,p) =E= Tret(n,p) - Twb;


$Ontext
-------------------------------Linear constraints-------------------------------
$Offtext

l1(i,p)..                                (Qu(i,p)*3600/cp) + sum(n,y4(n,i,p)) + sum(ip$(ord(ip) ne ord(i)),y2(ip,i,p)) =E= y3(i,p);
l2(n,p)..                                sum(i,y5(n,i,p)) + sum(nn,y7(nn,n,p)) =E= sum(i,y1(n,i,p)) + sum(nn,y6(nn,n,p));
l3(n,p)..                                E(n,p) =E= 0.00085*1.8*(sum(i,y5(n,i,p))-sum(i,CR(n,i,p)*Tct(n)));
l4(n,p)..                                sum(i,y4(n,i,p)) + sum(nn,y6(nn,n,p)) =E= M(n,p)*Tamb + (OS(n,p) - B(n,p))*Tct(n);

l5(ip,i,p)$(ord(ip) ne ord(i))..         Wr(ip,i,p) =L= (sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)));
l6(ip,i,p)$(ord(ip) ne ord(i))..         Wr(ip,i,p) =L= (sum(pp$(ord(pp) le ord(p)),Ws(ip,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(ip,pp)));
l7(ip,i,p)$(ord(ip) ne ord(i))..         Wr(ip,i,p) =E= Wr(i,ip,p);

l8(n,i,p)..                              y1(n,i,p) =G= ((Fin_U(i)*Tout(i,p)) + (CR(n,i,p)*Tout_U(i)) - (Fin_U(i)*Tout_U(i)));
l9(n,i,p)..                              y1(n,i,p) =L= (Fin_U(i)*Tout(i,p) + CR(n,i,p)*Tout_L - ((sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)))*Fin_U(i)*Tout_L));
l10(n,i,p)..                             y1(n,i,p) =L= CR(n,i,p)*Tout_U(i);
l11(n,i,p)..                             y1(n,i,p) =G= CR(n,i,p)*Tout_L;

l12(ip,i,p)$(ord(ip) ne ord(i))..        y2(ip,i,p) =G= ((Fin_U(i)*Tout(ip,p)) + (FR(ip,i,p)*Tout_U(ip)) - (Fin_U(i)*Tout_U(ip)));
l13(ip,i,p)$(ord(ip) ne ord(i))..        y2(ip,i,p) =L= (Fin_U(i)*Tout(ip,p) + FR(ip,i,p)*Tout_L - Wr(ip,i,p)*Fin_U(i)*Tout_L);
l14(ip,i,p)$(ord(ip) ne ord(i))..        y2(ip,i,p) =L= FR(ip,i,p)*Tout_U(ip);
l15(ip,i,p)$(ord(ip) ne ord(i))..        y2(ip,i,p) =G= FR(ip,i,p)*Tout_L;

l16(i,p)..                               y3(i,p) =G= ((Fin_U(i)*Tout(i,p)) + (Fin(i,p)*Tout_U(i)) - (Fin_U(i)*Tout_U(i)));
l17(i,p)..                               y3(i,p) =L= ((Fin_U(i)*Tout(i,p)) + (Fin(i,p)*Tout_L) - ((sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)))*Fin_U(i)*Tout_L));
l18(i,p)..                               y3(i,p) =L= Fin(i,p)*Tout_U(i);
l19(i,p)..                               y3(i,p) =G= Fin(i,p)*Tout_L;

l20(n,i,p)..                             y4(n,i,p) =G= (Fin_U(i)*Tsup(n,p) + CS(n,i,p)*Tamb - Fin_U(i)*Tamb);
l21(n,i,p)..                             y4(n,i,p) =L= (Fin_U(i)*Tsup(n,p) + CS(n,i,p)*Tct_L - ((sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)))*Fin_U(i)*Tct_L));
l22(n,i,p)..                             y4(n,i,p) =L= CS(n,i,p)*Tamb;
l23(n,i,p)..                             y4(n,i,p) =G= CS(n,i,p)*Tct_L;

l24(n,i,p)..                             y5(n,i,p) =G= (Fin_U(i)*Tret(n,p) + CR(n,i,p)*Tret_U(n) - Fin_U(i)*Tret_U(n));
l25(n,i,p)..                             y5(n,i,p) =L= (Fin_U(i)*Tret(n,p) + CR(n,i,p)*Tct_L - ((sum(pp$(ord(pp) le ord(p)),Ws(i,pp)) - sum(pp$(ord(pp) le ord(p)),Wf(i,pp)))*Fin_U(i)*Tct_L));
l26(n,i,p)..                             y5(n,i,p) =L= CR(n,i,p)*Tret_U(n);
l27(n,i,p)..                             y5(n,i,p) =G= CR(n,i,p)*Tct_L;

l28(nn,n,p)..                            y6(nn,n,p) =G= (OS_U(n)*Tsup(n,p)) + R(nn,n,p)*Tamb - OS_U(n)*Tamb;
l29(nn,n,p)..                            y6(nn,n,p) =L= (OS_U(n)*Tsup(n,p)) + R(nn,n,p)*Tct_L - OS_U(n)*Tct_L;
l30(nn,n,p)..                            y6(nn,n,p) =L= R(nn,n,p)*Tamb;
l31(nn,n,p)..                            y6(nn,n,p) =G= R(nn,n,p)*Tct_L;

l32(nn,n,p)..                            y7(nn,n,p) =G= ((OS_U(n)*Tret(n,p)) + (R(nn,n,p)*Tret_U(n)) - (OS_U(n)*Tret_U(n)));
l33(nn,n,p)..                            y7(nn,n,p) =L= (OS_U(n)*Tret(n,p) + R(nn,n,p)*Tct_L - OS_U(n)*Tct_L);
l34(nn,n,p)..                            y7(nn,n,p) =L= R(nn,n,p)*Tret_U(n);
l35(nn,n,p)..                            y7(nn,n,p) =G= R(nn,n,p)*Tct_L;

$Ontext
------------------------------Nonlinear constraints-----------------------------
$Offtext

n1(i,p)..                                0.01*((Qu(i,p)*3600/cp) + sum(n,CS(n,i,p)*Tsup(n,p)) + sum(ip$(ord(ip) ne ord(i)),FR(ip,i,p)*Tout(ip,p))) =E= 0.01*Fout(i,p)*Tout(i,p);
n2(n,p)..                                Tret(n,p)*(sum(i,CR(n,i,p)) + sum(nn,R(nn,n,p))) =E= sum(i,CR(n,i,p)*Tout(i,p)) + sum(nn,R(nn,n,p)*Tsup(nn,p));
n3(n,p)..                                E(n,p) =E= 0.00085*1.8*(sum(i,CR(n,i,p)) + sum(nn,R(nn,n,p)))*(Tret(n,p)-Tct(n));
n4(n,p)..                                Tsup(n,p)*(sum(nn,R(n,nn,p)) + sum(i,CS(n,i,p))) =E= M(n,p)*Tamb + (OS(n,p) - B(n,p))*Tct(n);

$Ontext
-------------------------------Costing constraints------------------------------
$Offtext

c1..                                     cTR =E= sum(i,sum(s,sum(p,cRM(s)*BI(i,s,p))));
c2(p)..                                  cPO(p) =E= sum(n,(110*OS(n,p) + 2275.132*M(n,p) + 1138*B(n,p)));
c3(n,p)..                                cVCP(n,p) =E= (746.749*(OS(n,p)**0.79)*(Range(n,p)**0.57)*(1/(Approach(n,p)**0.9924))*(((0.022*Twb)+(0.39))*2.447))*H/8000;
c4(n,p)..                                cVC(n) =G= cVCP(n,p);
c5(n,p)$(ord(p) ne card(p))..            cVC(n) =L= cVCP(n,p) + BM*(1-yVC(n,p));
c6(n)..                                  sum(p,yVC(n,p)) =E= 1;
c7..                                     cTC =E=  cFC*CT + sum(n,cVC(n));
c8..                                     cTO =E= sum(p,cPO(p)*(t(p)-t(p-1)))/8000;
c9..                                     Profitl =E= sum(s,sum(p,zeta(s)*SS(s,p))) - cTR - cFC*CT - sum(p,cPO(p))*H/8000;
*OC only estimated. Only fixed CC taken into account.
c10..                                    Profit =E= sum(s,sum(p,zeta(s)*SS(s,p))) - cTR - cTC  - cTO;

$Ontext
-----------------------------------Boundaries-----------------------------------
$Offtext

*FR.fx(ip,i,p) = 0;
Fin.UP(i,p) = Fin_U(i);
Tout.UP(i,p) = Tout_U(i);
Tret.UP(n,p) = Tret_U(n);
OS.UP(n,p) = OS_U(n);
Approach.LO(n,p) = 0.01;
yVC.FX(n,p)$(ord(p) = card(p)) = 0;
R.FX(nn,n,p)$(ord(nn) ne ord(n)) = 0;

Model Case1_Opt_a /s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,s31,s32,s33,s34,s35,s36,g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,g17,g18,g19,g20,g21,g22,g23,g25,g26,g27,g28,g29,l1,l2,l3,l4,l5,l6,l7,l8,l9,l10,l11,l12,l13,l14,l15,l16,l17,l18,l19,l20,l21,l22,l23,l24,l25,l26,l27,l28,l29,l30,l31,l32,l33,l34,l35,c1,c2,c9,test,test2,test3,test4/;
Option SYSOUT = ON;
Options LIMROW = 1e9;
Options MIP = CPLEX;
Option  optcr = 0.1;
Case1_Opt_a.optfile=1
$onecho > cplex.opt
iis              1
$offecho
Solve Case1_Opt_a using MIP maximising Profitl;


Model Case1_Opt_b /s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,s31,s32,s33,s34,s35,s36,g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,g17,g18,g19,g20,g21,g22,g23,g25,g26,g27,g28,g29,n1,n2,n3,n4,c1,c2,c3,c9,test,test2,test3,test4/;
Options RESLIM = 3000000000;
Option SYSOUT = ON;
Options LIMROW = 1e9;
Options MINLP = BARON;
Option  optcr = 0.01;
Solve Case1_Opt_b using MINLP maximising Profitl;

*Zl.FX = Zl.L;

Model Case1_Opt_c /s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,s31,s32,s33,s34,s35,s36,g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11,g12,g13,g14,g15,g16,g17,g18,g19,g20,g21,g22,g23,g25,g26,g27,g28,g29,n1,n2,n3,n4,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,test,test2,test3,test4/;
Options RESLIM = 3000000000;
Option SYSOUT = ON;
Options LIMROW = 1e9;
Options MINLP = BARON;
Option  optcr = 0.00000001;
Solve Case1_Opt_c using MINLP maximising Profit;
Tin(i,p) = ((sum(n,CS.L(n,i,p)*Tsup.L(n,p))) + sum(ip$(ord(ip) ne ord(i)),FR.L(ip,i,p)*Tout.L(ip,p)))/Fin.L(i,p);
Display Tin,OS_U,CRS_U;

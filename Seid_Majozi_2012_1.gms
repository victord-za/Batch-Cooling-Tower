$Title Seid_Majozi_2012_1
$Ontext
         A robust mathematical formulation for multipurpose batch plants (2012)
         E.R. Seid & T. Majozi
         Case 1
$Offtext
Sets
i        Tasks
         //
j        Units
         //
s        States
         //
p        Time points
         //
;
Positive variables
qs(s,p)  Amount of state s stored at time point p
mu(s,p)  Amount of material processed by a task at time point p
*sinj
tu(s,p)  Time at which task starts at time point p
*sinj
tp(s,p)  Time at which task ends at time point p
*sinj)
;
Binary variables
t(j,p)   Binary variable associated with usage of state produced by unit j at time point p
t(j,s,p) Binary variable associated with usage of state s produced by unit j at time point p if the unit produces more than one intermediate at time point p
u(s,p)   Amount of material stored in unit j at time point p
*sinj
x(s,p)   Binary variable associated with availability of storage for state s at time point p
y(s,p)   Binary variable for assignment of task at time point p
*sinj
;
Free variables

;
Parameters
Beta(s)  Coefficient of variable term of processing time of a task
*sinj
         //
QS_0(s)  Initial amount of state s stored
         //
QS_U(s)  Maximum capacity of storage to store a state s
         //
Rho(s)   Portion of state s consumed by a task
*sinjsc
         //
Rho(s)   Portion of state s produced by a task
*sinjsp
         //
Tau(s)   Coefficient of constant term of processing time of a task
*sinj
         //
V_U(j)   Maximum capacity of unit j
         //

;
Scalars
H        Time horizon of interest
         //
;
Equations
a1       Allocation constraints
c1       Capacity constraints
mb1      Material balance constraints
d1       Duration constraints
s1       Sequence constraints
st1      Storage constraints
th1      Time horizon constraints
t1       Tightening constraints
of       Objective function
;

function mpc = toy

%It currently work for the tnep part.

mpc.version = '2';
mpc.baseMVA = 100.0;

%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
mpc.bus = [
    1	 3	 5	     0.0	 0.0	 0.0	 1	    1.10000	   -0.00000	 240.0	 1	    1.10000	    0.90000;
	2	 2	 15.0	 2.0	 0.0	 0.0	 1	    0.92617	    7.25883	 240.0	 1	    1.10000	    0.90000;
	3	 2	 15.0	 0.0	 0.0	 0.0	 1	    0.90000	  -17.26710	 240.0	 2	    1.10000	    0.90000;
    4	 1	 30.0	 10.0	 0.0	 0.0	 1	    1.10000	   -0.00000	 240.0	 1	    1.10000	    0.90000;
	5	 1	 20.0	 4.0	 0.0	 0.0	 1	    0.92617	    7.25883	 240.0	 1	    1.10000	    0.90000;
	6	 1	 25.0	 10.0	 0.0	 0.0	 1	    0.90000	  -17.26710	 240.0	 2	    1.10000	    0.90000;
    7	 1	 30.0	 0.0	 0.0	 0.0	 1	    1.10000	   -0.00000	 240.0	 1	    1.10000	    0.90000;
	8	 1	 10.0	 20.0	 0.0	 0.0	 1	    0.92617	    7.25883	 240.0	 1	    1.10000	    0.90000;
	9	 1	 25.0	 20.0	 0.0	 0.0	 1	    0.90000	  -17.26710	 240.0	 2	    1.10000	    0.90000;
    
];

%% generator data
%	bus	Pg            Qg	Qmax	Qmin	Vg	mBase       status	Pmax	Pmin	pc1 pc2 qlcmin qlcmax qc2min qc2max ramp_agc ramp_10 ramp_30 ramp_q apf
mpc.gen = [
	1	 30.0	     30.0	 30.0	 -30.0	 1.07762	 100.0	 1	 40.0	 0.0;
	2	 70.0	     127.5	 127.5	 -127.5	 1.07762	 100.0	 1	 170.0	 0.0;
	3	 85.0	     390.0	 390.0	 -390.0	 1.1	     100.0	 1	 520.0	 0.0;
];

mpc.gencost = [
	2	 1.0	 0.0	 3	   0	   1.0	   0;
	2	 10.0	 0.0	 3	   0	   2.0     0;
	2	 20.0	 0.0	 3	   0	   4.0	   0;
];
%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status angmin angmax
mpc.branch = [
	4	 5	 0.003	 0.03	 0.00674	 240.0	 240.0	 240.0	 0.0	 0.0	 1	 -30.0	 30.0;
   	5	 6   0.003	 0.03	 0.00674	 240.0	 240.0	 240.0	 0.0	 0.0	 1	 -30.0	 30.0;
    6	 9	 0.003	 0.03	 0.00674	 240.0	 240.0	 240.0	 0.0	 0.0	 1	 -30.0	 30.0;
    9	 8	 0.003	 0.03	 0.00674	 240.0	 240.0	 240.0	 0.0	 0.0	 1	 -30.0	 30.0;
    8	 7	 0.042	 0.02	 0.3	 9000.0	 0.0	 0.0	 0.0	 0.0	 1	 -30.0	 30.0;
    7	 4	 0.042	 0.05	 0.3	 9000.0	 0.0	 0.0	 0.0	 0.0	 1	 -30.0	 30.0;
];



%column_names%	f_bus	t_bus	br_r	br_x	br_b	rate_a	rate_b	rate_c	tap	shift	br_status	angmin	angmax	construction_cost
mpc.ne_branch = [
	1	 4	 0.165	 0.012	 0.45	 1000.0	 0.0	 0.0	 0.0	 0.0	 1	 -30.0	 30.0	 1;
	1	 5   0.025	 0.025	 0.17	 50.0	 0.0	 0.0	 0.0	 0.0	 1	 -30.0	 30.0	 1;
	1	 6	 0.025	 0.09	 0.27	 500.0	 0.0	 0.0	 0.0	 0.0	 1	 -30.0	 30.0	 1;
    2	 1	 0.065	 0.062	 0.05	 9000.0	 0.0	 0.0	 0.0	 0.0	 1	 -30.0	 30.0	 1;
	3	 1	 0.225	 0.005	 0.97	 2000.0	 0.0	 0.0	 0.0	 0.0	 1	 -30.0	 30.0	 1;
    2	 3	 0.05	 0.35	 0.01	 50.0	 0.0	 0.0	 0.0	 0.0	 1	 -30.0	 30.0    1;
];




%% dcline data
%	fbus	tbus	status	Pf	Pt	Qf	Qt	Vf	Vt	Pmin	Pmax	QminF	QmaxF	QminT	QmaxT	loss0	loss1
mpc.dcline = [
	3	5	1	10	8.9	99.9934	-10.4049	1.1	1.05304	10	100 	-100	100	-100 100	1	0.01;
];

%% dcline cost data
%	2	startup	shutdown	n	c(n-1)	...	c0
mpc.dclinecost = [
	2	 0.0	 0.0	 3	   0.000000	  40.000000	   0.000000;
];

%I'm not sure to undestand all that the right way
%Quite sure what I'm doing here is imply a logic fault, by forcing 6 buses to be dc i'm maybe constraining the problem too much?

%% existing dc bus data
%column_names%   busdc_i grid    Pdc     Vdc     basekVdc    Vdcmax  Vdcmin  Cdc
mpc.busdc = [
1              1       0       1       345         1.1     0.9     0;
2              1       0       1       345         1.1     0.9     0;
3              1       0       1       345         1.1     0.9     0;
4              1       0       1       345         1.1     0.9     0;
5              1       0       1       345         1.1     0.9     0;
6              1       0       1       345         1.1     0.9     0;
];

%% existing converters
%column_names%   busdc_i busac_i type_dc type_ac P_g   Q_g  islcc  Vtar rtf xtf  transformer tm   bf filter    rc      xc  reactor   basekVac Vmmax   Vmmin   Imax    status   LossA LossB  LossCrec LossCinv  droop Pdcset    Vdcset  dVdcset Pacmax Pacmin Qacmax Qacmin
mpc.convdc = [
4       4   1       1       -360    -1.66   		0 1.0        0.01  0.01 1 1 0.01 1 0.01   0.01 1  345         1.1     0.9     15     1      1.1033 0.887  2.885    2.885       0.0050    -52.7   1.0079   0 700 -700 700 -700;
6       6   2       1       -360    -1.66   		0 1.0        0.01  0.01 1 1 0.01 1 0.01   0.01 1  345         1.1     0.9     15     1      1.1033 0.887  2.885    2.885       0.0050    -52.7   1.0079   0 700 -700 700 -700;
];



%% candidate dc bus data
%column_names%   busdc_i grid    Pdc     Vdc     basekVdc    Vdcmax  Vdcmin  Cdc
mpc.busdc_ne = [
4              1       0       1       345         1.1     0.9     0;
6              1       0       1       345         1.1     0.9     0;
];

%% candidate branches
%column_names%   fbusdc  tbusdc  r      l        c   rateA   rateB   rateC status cost
mpc.branchdc_ne = [
	1	 4	 0.01	 0.00	 0.00  200.0	 0.0	 0.0	 1.0	 2.3;
	1	 5	 0.01	 0.00	 0.00  200.0	 0.0	 0.0	 1.0	 2.4;
	1	 6	 0.01	 0.00	 0.00  400.0	 0.0	 0.0	 1.0	 3.4;
	2	 4	 0.01	 0.00	 0.00  200.0	 0.0	 0.0	 1.0	 2.6;
	2	 5	 0.01	 0.00	 0.00  400.0	 0.0	 0.0	 1.0	 3.6;
	2	 6	 0.01	 0.00	 0.00  200.0	 0.0	 0.0	 1.0	 2.7;
	3	 4	 0.01	 0.00	 0.00  400.0	 0.0	 0.0	 1.0	 3.7;
	3	 5	 0.01	 0.00	 0.00  200.0	 0.0	 0.0	 1.0	 2.8;
	3	 6	 0.01	 0.00	 0.00  400.0	 0.0	 0.0	 1.0	 3.8;
	1	 2	 0.01	 0.00	 0.00  200.0	 0.0	 0.0	 1.0	 2.9;
	2	 3	 0.01	 0.00	 0.00  400.0	 0.0	 0.0	 1.0	 3.9;
 ];

%% candidate converters
%column_names%   busdc_i busac_i type_dc type_ac P_g   Q_g  islcc  Vtar rtf xtf  transformer tm   bf filter    rc      xc  reactor   basekVac Vmmax   Vmmin   Imax    status   LossA LossB  LossCrec LossCinv  droop Pdcset    Vdcset  dVdcset Pacmax Pacmin Qacmax Qacmin cost
mpc.convdc_ne = [
1       1   1       1       -360    -1.66   		0 1.0        0.01  0.01 1 1 0.01 1 0.01   0.01 1  345         1.1     0.9     15     1     	1.1033 0.887  2.885    2.885       0.0050    -52.7   1.0079   0 700 -700 700 -700 3;
2       2   1       1       -360    -1.66   		0 1.0        0.01  0.01 1 1 0.01 1 0.01   0.01 1  345         1.1     0.9     15     1      1.1033 0.887  2.885    2.885       0.0050    -52.7   1.0079   0 700 -700 700 -700 3.5;
3       3   1       1       -360    -1.66   		0 1.0        0.01  0.01 1 1 0.01 1 0.01   0.01 1  345         1.1     0.9     15     1      1.1033 0.887  2.885    2.885       0.0050    -52.7   1.0079   0 700 -700 700 -700 2.5;
5       5   1       1       -360    -1.66   		0 1.0        0.01  0.01 1 1 0.01 1 0.01   0.01 1  345         1.1     0.9     15     1      1.1033 0.887  2.885    2.885       0.0050    -52.7   1.0079   0 700 -700 700 -700 4.5;
];

end

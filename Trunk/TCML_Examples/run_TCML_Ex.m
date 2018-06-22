% run_TCML_Ex.m ==========================================================%

% Written By: Jonathan Kratz (NASA GRC)
% Date: 12/21/2017
% Description: This script populates the workspace for the
%   TCML_Ex.slx model to run, executes the models, and displays the 
%   results. The results are shown in the form of several plots.

close all
clear all
clc

% Define workspace variables ---------------------------------------------%

%Simulation
%-- Time-step [sec]
MWS.TC.Ext.dt = 0.015; %time-step outside of this block [sec]
tsim = 200; %duration of simulation [sec]

%Special Parameters
%-- Degradation Gap [mils]
MWS.TC.DegGap = 0; %degradation gap [mils]

%Blade Parameters
%-- Time-step [sec]
MWS.TC.Blade.dt = 0.015;
%-- Dimensions
%----- Initial Length of Blade [ft]
MWS.TC.Blade.L0 = 0.1469; 
%----- MWS.TC.Blade.mMass of a Blade [slug]
MWS.TC.Blade.m = (2.9034/42)/32.174;
%----- Surface area of the Blade [ft^2]
MWS.TC.Blade.A = 2*MWS.TC.Blade.L0^2/1.36;
%-- Material Properties
%----- Density [slug/ft^3]
MWS.TC.Blade.rho = 4.7732;
%----- Heat Capacity [degR] & [Btu/(slug-degR)]
MWS.TC.Blade.TCp_Data = [536.67 3159.3];
MWS.TC.Blade.Cp_Data = [4.8215 9.4584];
%----- Thermal Expansion Coefficient [degR] & [degR^-1]
MWS.TC.Blade.Talpha_Data = [536.67 3159.3]; 
MWS.TC.Blade.alpha_Data = [0.00000111 0.0000015]; 
%----- Young's Modulus [degR] & [lbf/ft^2]
MWS.TC.Blade.TE_Data = [536.67 3159.3]; 
MWS.TC.Blade.E_Data = [3466982082.698, 3111929700.735];
%-- Heat Transfer Properties
%----- Film Cooling Coefficient [-]
MWS.TC.Blade.eta = 0.33;
%----- Heat Transfer Coefficient [Btu/(sec-ft^2-degR)]
%      h = hcoeff * (W/Wdes)^0.8 * (T/Tdes)^(0.23)
%      hcoeff [Btu/(sec-ft^2-degR)], Wdes [slug/sec], Tdes [degR]
MWS.TC.Blade.hcoeff = 0.4534; 
MWS.TC.Blade.Wdes = 1.8051; 
MWS.TC.Blade.Tdes = 3168.6;
%-- Initial Temperature [R]
MWS.TC.Blade.T0 = 1634;

%Rotor Parameters
%-- Time-step [sec]
MWS.TC.Rotor.dt = 0.015;
%-- Dimensions
%----- Initial Outer Radius [ft]
MWS.TC.Rotor.Ro = 0.5851;
%----- Width of the rotor [ft]
MWS.TC.Rotor.W = 0.75/12;
%----- Number of nodes [-]
MWS.TC.Rotor.n = 20;
%-- Material Properties
%----- Density [slug/ft^3]
MWS.TC.Rotor.rho = 15.8975;
%----- Thermal Conductivity [degR] & [Btu/(sec-ft-degR)]
MWS.TC.Rotor.Tk_Data = [59.7, 209.7, 459.7, 2459.7 3000]; 
MWS.TC.Rotor.k_Data = [0.000694444, 0.001111111, 0.001666667, 0.004722222 0.0055]; 
%----- Heat Capacity [degR] & [Btu/(slug-degR)]
MWS.TC.Rotor.TCp_Data = [529.7, 659.7, 859.7, 1059.7, 1259.7, 1459.7, 1659.7, 1859.7, 2059.7, 2259.7, 2459.7 3000];
MWS.TC.Rotor.Cp_Data = [3.2174, 3.53914, 3.86088, 4.02175, 4.18262, 4.34349, 4.50436, 4.8261, 5.14784, 5.46958, 5.46958 5.5];
%----- Thermal Expansion Coefficient [degR] & [degR^-1]
MWS.TC.Rotor.Talpha_Data = [659.7, 859.7, 1059.7, 1359.7, 1459.7, 1659.7, 1859.7]; 
MWS.TC.Rotor.alpha_Data = [0.0000071, 0.0000075, 0.0000077, 0.0000079, 0.000008, 0.0000084, 0.0000089]; 
%----- Young's Modulus [degR] & [lbf/ft^2]
MWS.TC.Rotor.TE_Data = [529.7, 659.7, 859.7, 1059.7, 1259.7, 1459.7, 1659.7, 1859.7, 2059.7, 2209.7 3000]; 
MWS.TC.Rotor.E_Data = [4262400000, 4204800000, 4147200000, 3974400000, 3816000000, 3672000000, 3528000000, 3326400000, 2606400000, 1598400000 500000000]; 
%----- Poisson's Ratio [degR] & [-]
MWS.TC.Rotor.Tv_Data = [529.7, 559.7, 659.7, 759.7, 859.7, 959.7, 1059.7, 1159.7, 1259.7, 1359.7, 1459.7, 1559.7, 1659.7, 1759.7, 1859.7, 1959.7, 2059.7, 2159.7, 2259.7, 2359.7, 2459.7 3000]; 
MWS.TC.Rotor.v_Data = [0.294, 0.291, 0.288, 0.28, 0.28, 0.275, 0.272, 0.273, 0.271, 0.272, 0.271, 0.276, 0.283, 0.292, 0.306, 0.31, 0.331, 0.334, 0.341, 0.366, 0.402 0.5]; 
%-- Heat Transfer Properties
%----- Heat Transfer Coefficient - Front Side [Btu/(sec-ft^2-degR)]
%      h = hcoeff * (W/Wdes)^0.8 * (T/Tdes)^(0.23)
%      hcoeff [Btu/(sec-ft^2-degR)], Wdes [slug/sec], Tdes [degR]
MWS.TC.Rotor.hcoeff_front = 0.0116;
MWS.TC.Rotor.Wdes_front = 0.009; 
MWS.TC.Rotor.Tdes_front = 1602.5;
%----- Heat Transfer Coefficient - Back Side [Btu/(sec-ft^2-degR)]
%      h = hcoeff * (W/Wdes)^0.8 * (T/Tdes)^(0.23)
%      hcoeff [Btu/(sec-ft^2-degR)], Wdes [slug/sec], Tdes [degR]
MWS.TC.Rotor.hcoeff_back = 0.0116; 
MWS.TC.Rotor.Wdes_back = 0.009;
MWS.TC.Rotor.Tdes_back = 1602.5;
%-- Initial Temperature [R]
MWS.TC.Rotor.T0 = 1065.8*ones(1,MWS.TC.Rotor.n);

%Case Parameters
%-- Time-step [sec]
MWS.TC.Case.dt = 0.015;
%-- Dimensions
%------ Initial Inner Radius of the engine Case
MWS.TC.L_Shroud = 0.75/12;
MWS.TC.Case.Ri = 0.7984;
%----- Thickness [ft]
MWS.TC.Case.W = 0.1/12;
%----- Number of nodes in the case [-]
MWS.TC.Case.n = 20;
%-- Material Properties
%----- Density [slug/ft^3]
MWS.TC.Case.rho = 15.8975;
%----- Thermal Conductivity [degR] & [Btu/(sec-ft-degR)]
MWS.TC.Case.Tk_Data = [59.7, 209.7, 459.7, 2459.7 3000];
MWS.TC.Case.k_Data = [0.000694444, 0.001111111, 0.001666667, 0.004722222 0.0055]; 
%----- Heat Capacity [degR] & [Btu/(slug-degR)]
MWS.TC.Case.TCp_Data = [529.7, 659.7, 859.7, 1059.7, 1259.7, 1459.7, 1659.7, 1859.7, 2059.7, 2259.7, 2459.7 3000];
MWS.TC.Case.Cp_Data = [3.2174, 3.53914, 3.86088, 4.02175, 4.18262, 4.34349, 4.50436, 4.8261, 5.14784, 5.46958, 5.46958 5.5];
%----- Thermal Expansion Coefficient [degR] & [degR^-1]
MWS.TC.Case.Talpha_Data = [659.7, 859.7, 1059.7, 1359.7, 1459.7, 1659.7, 1859.7]; 
MWS.TC.Case.alpha_Data = [0.0000071, 0.0000075, 0.0000077, 0.0000079, 0.000008, 0.0000084, 0.0000089];  
%-- Heat Transfer Properties
%------ Heat Transfer Coefficient - Inner Surface [Btu/(sec-ft^2-degR)]
%       h = hcoeff * (W/Wdes)^0.8 * (T/Tdes)^(0.23)
%       hcoeff [Btu/(sec-ft^2-degR)], Wdes [slug/sec], Tdes [degR]
MWS.TC.Case.hcoeff_in = 0.006; 
MWS.TC.Case.Wdes_in = 0.0289; 
MWS.TC.Case.Tdes_in = 1602.5;
%------ Heat Transfer Coefficient - Outer Surface [Btu/(sec-ft^2-degR)]
%       h = hcoeff * (W/Wdes)^0.8 * (T/Tdes)^(0.23)
%       hcoeff [Btu/(sec-ft^2-degR)], Wdes [slug/sec], Tdes [degR]
MWS.TC.Case.hcoeff_out = 0.0023; 
MWS.TC.Case.Wdes_out = 0.005;
MWS.TC.Case.Tdes_out = 550;
%-- Initial Temperature [R]
MWS.TC.Case.T0 = 945.4*ones(1,MWS.TC.Case.n);

%Flow Initialization
MWS.TC.FC.T0_Core = 1913.8;
MWS.TC.FC.W0_Core = 0.5410;
MWS.TC.FC.Tcool0_Blade = 1065.8;
MWS.TC.FC.Tcool0_Rotor_Front = 1065.8;
MWS.TC.FC.Wcool0_Rotor_Front = 0.0027;
MWS.TC.FC.Tcool0_Rotor_Back = 1065.8;
MWS.TC.FC.Wcool0_Rotor_Back = 0.0027;
MWS.TC.FC.Tcool0_Case_In = 1065.8;
MWS.TC.FC.Wcool0_Case_In = 0.0088;
MWS.TC.FC.Tcool0_Case_Out = 522.9388;
MWS.TC.FC.Wcool0_Case_Out = 0.0000293;
MWS.TC.FC.Wcool0_Case_Out_Nom = 0.0000293;

%Load Engine Inputs
%-- Data set includes:
%----- Nmech - high pressure spool speed [rpm]
%      T4 - turbine inlet temperature [R]
%      W4 - mass flow rate inside the core at the turbine inlet [slug/sec]
%      T3 - compressor discharge temperature [R]
%      Wrot - mass flow rate around HPT turbine discs [slug/sec]
%      Wcase_in - mass flow rate on the inside of the engine case [slug/sec]
%      T13 - temperature of the air in the bypass duct (used to cool the
%           outside of the engine case) [R]
%      Wcase_out - mass flow rate on the outside of the engine case [slug/sec]
%      Wcase_out_nom - nominal mass flow rate on the outside of the engine case [slug/sec]
%----- All variables are 2 column matrices with the first column being the
%      time and the second column being the value of the indicated
%      variable.
load('EngInputs.mat');

% Run Model --------------------------------------------------------------%

sim('TCML_Ex.slx')

% Plot Results -----------------------------------------------------------%

% Temperatures
figure()
plot(Out_Dyn.Blade.T.Time,Out_Dyn.Blade.T.Data,'-b','LineWidth',2)
hold on
plot(Out_Dyn.Rotor.Tavg.Time,permute(Out_Dyn.Rotor.Tavg.Data,[3,2,1]),'-r','LineWidth',2)
plot(Out_Dyn.Case.Tavg.Time,permute(Out_Dyn.Case.Tavg.Data,[3,2,1]),'-g','LineWidth',2)
xlabel('Time [sec]')
ylabel('Average Temperature [^oR]')
legend('Blade','Rotor Disc','Case',0)
grid on

% Deformations
% -- Blade [sec] & [mils]
tB = Out_Dyn.Blade.L.Time;
uB = (permute(Out_Dyn.Blade.L.Data,[3,2,1]) - MWS.TC.Blade.L0)*12000;
% -- Rotor Disc [sec] & [mils]
tR = Out_Dyn.Rotor.L.Time;
uR = (permute(Out_Dyn.Rotor.L.Data,[3,2,1]) - MWS.TC.Rotor.Ro)*12000;
% -- Case [sec] & [mils]
tC = Out_Dyn.Case.L.Time;
uC = (Out_Dyn.Case.L.Data - MWS.TC.Case.Ri)*12000;
figure()
plot(tB,uB,'-b','LineWidth',2)
hold on
plot(tR,uR,'-r','LineWidth',2)
plot(tC,uC,'-g','LineWidth',2)
hold off
xlabel('Time [sec]')
ylabel('Deformation [mils]')
legend('Blade','Rotor Disc','Case',0)
grid on

% Tip Clearance
figure()
plot(TCact.Time,permute(TCact.Data,[3,2,1]),'-b','LineWidth',2)
hold on
plot(Out_Dyn.TCnom.Time,permute(Out_Dyn.TCnom.Data,[3,2,1]),'-r','LineWidth',2)
plot(Out_SS.TC.Time,Out_SS.TC.Data,'--k','LineWidth',2)
hold off
xlabel('Time [sec]')
ylabel('Tip Clearance [mils]')
legend('Actual Tip Clearance','Nominal Tip Clearance (Dyn. Block)','Nominal Tip Clearance (SS Block)',0)
grid on

% Efficiency Impact
figure()
plot(effmod.Time,permute(effmod.Data,[3,2,1]),'-b','LineWidth',2)
xlabel('Time [sec]')
ylabel('HPT efficency scaler coefficient [-]')
grid on
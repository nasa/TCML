readme_TCML

TCML version 1.0.0
Date of most recent update: 01/04/2018
Developer: Jonathan Kratz (NASA Glenn Research Center)

GENERAL INFORMATION

The Tip Clearance Modeling Library (TCML) was developed to model the dynamic variation of high pressure 
turbine (HPT) tip clearance in aero-engine turbomachinery. The TCML blockset contains blocks to predict
the dynamic and steady-state tip clearance using a method similar to what is described in the references
below:

[1] Chapman, J., Kratz, J., Guo, T.H., and Litt, J., “Integrated Turbine Tip Clearance and Gas Turbine 
    Engine Simulation,” Proceedings of the 52nd AIAA/ASME/SAE/ASEE Joint Propulsion Conference, Salt Lake 
    City, UT, 2016.
[2] Kratz, J., Chapman, J., and Guo, T.H., “A Parametric Study of Actuator Requirements for Active Turbine
    Tip Clearance Control of a Modern High Bypass Turbofan Engine,” Proceedings of the 2017 ASME Turbo Expo,
    Charlotte, NC, 2017.
[3] Kratz, J., and Chapman, J., “Active Turbine Tip Clearance Control Trade Space Analysis of an Advanced
    Geared Turbofan Engine,” Proceedings of the 54nd AIAA/ASME/SAE/ASEE Joint Propulsion Conference, 
    Cincinnati, OH, 2018. To be published.

Most resently this blockset has been used in a HPT tip clearance study conducted for an advanced geared
turbofan with a compact gas turbine (CGT). See Ref. [3].

The library is conducive to use with dynamic engine models, particulary those created with the Toolbox 
for Modeling and Analysis of Thermodynamic Systems (T-MATS). TCML could be viewed as a compliment to 
T-MATS. Infact, the TCML blockset uses a few block from T-MATS version 1.1.3.13. The links to the T-MATS
library have been broken to enable use of TCML without a T-MATS installation.

The tip clearance modeling method is a physics-based system level approach. The help menu's of the blocks
provide a description of the method. In additon, the user is referred to the references listed above.

Note that TCML was developed using MATLAB/Simulink R2015a on a Windows PC with the Windows 7 operating
system. TCML is not gauranteed to work on different operating systems or different versions of MATLAB.



TCML ORGANIZATION

With the "Trunk" folder are files to install and uninstall TCML. Two folders "TCML_Library" and 
"TCML_Examples". "TCML_Library" contains the library file "lib_TipClearance.slx" and the folders
"Support" and "MATLAB_Scripts". "Support" containts the help files for the Simulink blocks and 
"MATLAB_Scripts" contains MATLAB functions that support the Simulink blocks. The folder "TCML_Examples"
contains an example to illustrate the usage of the blocks inside the library.



INSTALLING TCML

1. Download TSAT from the GIT server PUT URL HERE, click the green download button for the latest version, 
   and extract the files to a folder that can be accessed by MATLAB, ensuring there are no spaces in the 
   path name.
2. Open up MATLAB and navigate to the directory that TSAT was saved.
3. Run install_TCML.m. This will setup the paths for TSAT. A temporary install should only save the paths 
   for the current MATLAB session while the permanent install option will save the paths to MATLAB until 
   the uninstall script is ran or the paths are manually removed. If the user does not have elevated 
   privileges, the paths may not be saved properly. If the paths have not been saved, new paths must be 
   manually added to the pathdef.m file. To do this click on the “Set Path” icon in the MATLAB toolbar and 
   add the following paths by navigating to them and selecting them: 
	• Trunk\TCML_Library
	• Trunk\TCML_Library\Support
	• Trunk\TCML_Library\MATLAB_Scripts
   Save the paths before exiting the dialog box.
4. Open up Simulink and verify that the TCML library shows up in the library browser.
5. Open up one of the examples in the “Trunk\TCML_Examples” folder and attempt to execute it to verify 
   that the TCML library is on the path and the library blocks can be used.



UNINSTALLING TCML

1. Run uninstall_TCML.m. This will remove the paths that were added during the TCML install.
	a. If the paths were added manually during installation then they must be removed manually using 
 	   the “Set Path” tool in MATLAB.

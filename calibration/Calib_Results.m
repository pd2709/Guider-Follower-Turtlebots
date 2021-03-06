% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 630.135394139079153 ; 631.076416145119879 ];

%-- Principal point:
cc = [ 307.901145498176732 ; 250.956660551046383 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.140424220637678 ; -0.578128452158291 ; 0.003008542430493 ; -0.001814574448560 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 4.202060839755451 ; 4.046051860987177 ];

%-- Principal point uncertainty:
cc_error = [ 3.837992631742896 ; 3.670682751382875 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.023709274946526 ; 0.097553707740213 ; 0.002061643862829 ; 0.002099949617521 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 480;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 25;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 1.801589e+00 ; 1.964336e+00 ; 2.849781e-01 ];
Tc_1  = [ -1.274586e+02 ; -9.219306e+01 ; 4.516913e+02 ];
omc_error_1 = [ 7.145666e-03 ; 8.718289e-03 ; 1.403543e-02 ];
Tc_error_1  = [ 2.833734e+00 ; 2.664289e+00 ; 3.697835e+00 ];

%-- Image #2:
omc_2 = [ 1.801590e+00 ; 1.964336e+00 ; 2.849781e-01 ];
Tc_2  = [ -1.274586e+02 ; -9.219306e+01 ; 4.516913e+02 ];
omc_error_2 = [ 7.145666e-03 ; 8.718290e-03 ; 1.403543e-02 ];
Tc_error_2  = [ 2.833734e+00 ; 2.664289e+00 ; 3.697835e+00 ];

%-- Image #3:
omc_3 = [ -1.888662e+00 ; -2.010880e+00 ; 6.277433e-01 ];
Tc_3  = [ -5.507206e+01 ; -9.033430e+01 ; 4.592351e+02 ];
omc_error_3 = [ 6.680959e-03 ; 6.341229e-03 ; 1.231381e-02 ];
Tc_error_3  = [ 2.816633e+00 ; 2.647680e+00 ; 2.840004e+00 ];

%-- Image #4:
omc_4 = [ 1.723611e+00 ; 1.708196e+00 ; -4.807359e-01 ];
Tc_4  = [ -1.047263e+02 ; -4.267644e+01 ; 4.453967e+02 ];
omc_error_4 = [ 5.437695e-03 ; 6.488676e-03 ; 9.443267e-03 ];
Tc_error_4  = [ 2.685137e+00 ; 2.607082e+00 ; 3.031658e+00 ];

%-- Image #5:
omc_5 = [ -2.098981e+00 ; -2.074276e+00 ; -6.123057e-01 ];
Tc_5  = [ -8.373382e+01 ; -9.386004e+01 ; 3.314878e+02 ];
omc_error_5 = [ 6.476245e-03 ; 7.412500e-03 ; 1.304212e-02 ];
Tc_error_5  = [ 2.104236e+00 ; 1.987314e+00 ; 2.843510e+00 ];

%-- Image #6:
omc_6 = [ 2.164351e+00 ; 2.161696e+00 ; 9.280836e-02 ];
Tc_6  = [ -1.049316e+02 ; -7.255525e+01 ; 3.787026e+02 ];
omc_error_6 = [ 8.519746e-03 ; 8.684609e-03 ; 1.833155e-02 ];
Tc_error_6  = [ 2.351645e+00 ; 2.238141e+00 ; 3.012504e+00 ];

%-- Image #7:
omc_7 = [ 1.916758e+00 ; 2.358182e+00 ; -1.789839e-02 ];
Tc_7  = [ -8.498331e+01 ; -1.065130e+02 ; 4.402341e+02 ];
omc_error_7 = [ 9.042612e-03 ; 1.164866e-02 ; 2.100342e-02 ];
Tc_error_7  = [ 2.707007e+00 ; 2.569857e+00 ; 3.447887e+00 ];

%-- Image #8:
omc_8 = [ 2.275889e+00 ; 2.000950e+00 ; 2.486208e-01 ];
Tc_8  = [ -1.206704e+02 ; -7.922925e+01 ; 4.180295e+02 ];
omc_error_8 = [ 9.756597e-03 ; 9.446385e-03 ; 2.123339e-02 ];
Tc_error_8  = [ 2.638027e+00 ; 2.486539e+00 ; 3.512087e+00 ];

%-- Image #9:
omc_9 = [ -1.972199e+00 ; -2.218027e+00 ; 2.746345e-01 ];
Tc_9  = [ -7.108078e+01 ; -9.184440e+01 ; 4.321478e+02 ];
omc_error_9 = [ 7.804000e-03 ; 9.206853e-03 ; 1.755170e-02 ];
Tc_error_9  = [ 2.628422e+00 ; 2.501237e+00 ; 3.122758e+00 ];

%-- Image #10:
omc_10 = [ 2.038756e+00 ; 2.162448e+00 ; 1.537123e-01 ];
Tc_10  = [ -1.226303e+02 ; -9.937590e+01 ; 3.921903e+02 ];
omc_error_10 = [ 8.072882e-03 ; 9.886944e-03 ; 1.847669e-02 ];
Tc_error_10  = [ 2.457728e+00 ; 2.327943e+00 ; 3.189161e+00 ];

%-- Image #11:
omc_11 = [ -1.775117e+00 ; -1.735460e+00 ; 5.028357e-02 ];
Tc_11  = [ -1.210817e+02 ; -6.853620e+01 ; 3.693856e+02 ];
omc_error_11 = [ 5.318385e-03 ; 5.593483e-03 ; 8.936518e-03 ];
Tc_error_11  = [ 2.239408e+00 ; 2.167841e+00 ; 2.622874e+00 ];

%-- Image #12:
omc_12 = [ 1.909116e+00 ; 2.175071e+00 ; 4.974649e-01 ];
Tc_12  = [ -1.263928e+02 ; -9.397123e+01 ; 4.002699e+02 ];
omc_error_12 = [ 7.754296e-03 ; 9.225146e-03 ; 1.695677e-02 ];
Tc_error_12  = [ 2.571737e+00 ; 2.405492e+00 ; 3.483149e+00 ];

%-- Image #13:
omc_13 = [ -1.555677e+00 ; -2.274825e+00 ; 8.134312e-01 ];
Tc_13  = [ -8.229732e-01 ; -1.076922e+02 ; 4.714378e+02 ];
omc_error_13 = [ 6.271916e-03 ; 6.827696e-03 ; 1.175814e-02 ];
Tc_error_13  = [ 2.910242e+00 ; 2.723872e+00 ; 2.813705e+00 ];

%-- Image #14:
omc_14 = [ 1.717340e+00 ; 1.671620e+00 ; 1.290272e-01 ];
Tc_14  = [ -1.375894e+02 ; -4.707685e+01 ; 4.475344e+02 ];
omc_error_14 = [ 6.351764e-03 ; 6.944799e-03 ; 1.057983e-02 ];
Tc_error_14  = [ 2.761104e+00 ; 2.651793e+00 ; 3.555865e+00 ];

%-- Image #15:
omc_15 = [ 2.115524e+00 ; 2.071947e+00 ; 6.424971e-02 ];
Tc_15  = [ -4.706806e+01 ; -5.136623e+01 ; 4.765232e+02 ];
omc_error_15 = [ 1.006232e-02 ; 8.960483e-03 ; 1.979104e-02 ];
Tc_error_15  = [ 2.914613e+00 ; 2.772791e+00 ; 3.881384e+00 ];

%-- Image #16:
omc_16 = [ 2.110513e+00 ; 2.089472e+00 ; 1.541644e-01 ];
Tc_16  = [ -1.676106e+02 ; -5.231224e+01 ; 4.334352e+02 ];
omc_error_16 = [ 1.134644e-02 ; 1.277450e-02 ; 2.450483e-02 ];
Tc_error_16  = [ 2.710791e+00 ; 2.599731e+00 ; 3.776602e+00 ];

%-- Image #17:
omc_17 = [ 2.176623e+00 ; 2.117060e+00 ; -2.421018e-02 ];
Tc_17  = [ -1.638309e+02 ; -1.259436e+02 ; 4.244731e+02 ];
omc_error_17 = [ 7.741741e-03 ; 1.021109e-02 ; 2.038926e-02 ];
Tc_error_17  = [ 2.623681e+00 ; 2.539177e+00 ; 3.504841e+00 ];

%-- Image #18:
omc_18 = [ 2.059385e+00 ; 2.187048e+00 ; -8.361728e-02 ];
Tc_18  = [ 1.053367e+01 ; -4.744508e+01 ; 5.430872e+02 ];
omc_error_18 = [ 1.191798e-02 ; 1.045131e-02 ; 2.420491e-02 ];
Tc_error_18  = [ 3.326265e+00 ; 3.159051e+00 ; 4.525842e+00 ];

%-- Image #19:
omc_19 = [ -1.936226e+00 ; -2.246729e+00 ; 4.110906e-01 ];
Tc_19  = [ -1.365045e+02 ; -9.650244e+01 ; 5.174002e+02 ];
omc_error_19 = [ 7.845693e-03 ; 8.008719e-03 ; 1.592051e-02 ];
Tc_error_19  = [ 3.163416e+00 ; 3.037150e+00 ; 3.579994e+00 ];

%-- Image #20:
omc_20 = [ -2.076494e+00 ; -2.269432e+00 ; 1.560601e-01 ];
Tc_20  = [ -1.347448e+02 ; -8.515396e+01 ; 6.695147e+02 ];
omc_error_20 = [ 1.651169e-02 ; 1.767541e-02 ; 3.679196e-02 ];
Tc_error_20  = [ 4.074455e+00 ; 3.915972e+00 ; 5.182386e+00 ];

%-- Image #21:
omc_21 = [ -2.170967e+00 ; -2.212679e+00 ; 3.574778e-01 ];
Tc_21  = [ -9.958654e+01 ; -8.238286e+01 ; 3.125072e+02 ];
omc_error_21 = [ 6.038314e-03 ; 5.282412e-03 ; 1.238521e-02 ];
Tc_error_21  = [ 1.912514e+00 ; 1.819519e+00 ; 2.265226e+00 ];

%-- Image #22:
omc_22 = [ -1.899674e+00 ; -1.870708e+00 ; 6.650733e-01 ];
Tc_22  = [ -9.437618e+01 ; -8.225952e+01 ; 3.522738e+02 ];
omc_error_22 = [ 5.827456e-03 ; 4.444113e-03 ; 9.207154e-03 ];
Tc_error_22  = [ 2.162304e+00 ; 2.039028e+00 ; 2.088968e+00 ];

%-- Image #23:
omc_23 = [ 2.032256e+00 ; 2.173826e+00 ; 2.601977e-01 ];
Tc_23  = [ -9.938349e+01 ; -9.065797e+01 ; 2.604929e+02 ];
omc_error_23 = [ 5.734754e-03 ; 6.121882e-03 ; 1.187895e-02 ];
Tc_error_23  = [ 1.641296e+00 ; 1.570449e+00 ; 2.116777e+00 ];

%-- Image #24:
omc_24 = [ -1.927738e+00 ; -1.932415e+00 ; -1.803848e-02 ];
Tc_24  = [ -1.124802e+02 ; -7.087135e+01 ; 2.867818e+02 ];
omc_error_24 = [ 4.946089e-03 ; 5.450718e-03 ; 9.846775e-03 ];
Tc_error_24  = [ 1.755665e+00 ; 1.697064e+00 ; 2.179620e+00 ];

%-- Image #25:
omc_25 = [ 1.927753e+00 ; 1.819092e+00 ; -5.973902e-01 ];
Tc_25  = [ -1.115056e+02 ; -9.132210e+01 ; 3.360577e+02 ];
omc_error_25 = [ 4.478009e-03 ; 6.047344e-03 ; 9.176893e-03 ];
Tc_error_25  = [ 2.063341e+00 ; 1.971273e+00 ; 2.275647e+00 ];


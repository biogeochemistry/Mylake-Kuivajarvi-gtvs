% Performance metrics for CO2 in 2013 (calibration) (period = 'cal'),
% 2014 (validation) (period = 'val'), or May-October 2013 (period = 'mayoct13')

% To be executed after the script MyLake_C_gases_KJ.m

% Output: matrix eval_CO2auto consisting of
% CO2auto_sums      Sum of squared differences
% r2sCO2auto        Coefficient of determination
% rmsesCO2auto      Root-mean-square error
% NSEsCO2auto       Nash--Sutcliffe efficiency
% PbiassCO2auto     Percent bias
% NbiassCO2auto     Normalized bias
% rmsenusCO2auto    Normalized unbiased root-mean-square difference
% Nobs_CO2auto      Number of observations

period = 'cal';

switch period    
    case 'cal'        
        CO2_auto_observ = 44.01/1000*CO2ObsAuto(1:358,2:5);
        CO2_auto_obsdays = CO2ObsAuto(1:358,1);
    case 'val'        
        CO2_auto_observ = 44.01/1000*CO2ObsAuto(359:end,2:5);
        CO2_auto_obsdays = CO2ObsAuto(359:end,1);
    case 'mayoct13'
        CO2_auto_observ = 44.01/1000*CO2ObsAuto(116:297,2:5);
        CO2_auto_obsdays = CO2ObsAuto(116:297,1)';
end

obs_depths = [0.5 1.5 2.5 7]; %Depths of CO2 observations

%==========================================================================

lukumaara = 1;
numdepths = length(obs_depths);
iii = 1;
CO2auto_summat = NaN*zeros(lukumaara,numdepths);
r2sCO2auto = NaN*zeros(lukumaara, numdepths);
rmsesCO2auto = NaN*zeros(lukumaara, numdepths);
NSEsCO2auto = NaN*zeros(lukumaara, numdepths);
PbiassCO2auto = NaN*zeros(lukumaara, numdepths);
NbiassCO2auto = NaN*zeros(lukumaara, numdepths);
rmsenusCO2auto = NaN*zeros(lukumaara, numdepths);
BiassCO2auto = NaN*zeros(lukumaara, numdepths);

tt_mod = tt - datenum(year,1,1);

Obs_CO2auto_tt_mod=CO2_auto_obsdays - datenum(year,1,1);
CO2autofit_all=interp1(zz+dz/2,CO2zt,obs_depths)';
CO2autofit_sub=interp1(tt_mod,CO2autofit_all,Obs_CO2auto_tt_mod);

CO2auto_sums(iii,:)=nansum((0.001*CO2autofit_sub(:,1:4) - CO2_auto_observ(:, 1:4)).^2);

Nobs_CO2auto=sum(isnan(0.001*CO2autofit_sub(:,1:4) - CO2_auto_observ(:, 1:4))==0);

[r2sCO2auto(iii,:),rmsesCO2auto(iii,:),NSEsCO2auto(iii,:),PbiassCO2auto(iii,:),NbiassCO2auto(iii,:),rmsenusCO2auto(iii,:),BiassCO2auto(iii,:)]...
     = evalstat(CO2_auto_observ(:, 1:4),0.001*CO2autofit_sub(:,1:4));

eval_CO2auto = [CO2auto_sums; r2sCO2auto; 1000/44.01*rmsesCO2auto; NSEsCO2auto; PbiassCO2auto; NbiassCO2auto; rmsenusCO2auto; Nobs_CO2auto];

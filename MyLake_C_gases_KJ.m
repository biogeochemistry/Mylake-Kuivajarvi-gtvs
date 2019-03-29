% Script to run MyLake C with alternative gas exchange models for Kuivajärvi
% by PK, last modified 14.02.2019.

global ies80;

if (~exist('Qlambda','var'))
    load Qlambda.txt;
    
    %Temperature observations
    depths = [0.2 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 6 7 8 10 12]'; %Observation depths (m)
    [numMx,strMx]=xlsread('I_O_gases\Obs_T_Kuivaj_13_14.xls','temp');
    numMx(numMx(:,:)==-999)=NaN;
    [d1,d2]=size(numMx);
    kjtemp=NaN*zeros(d1*length(depths),5);
    hh=0;
    for ii=1:d1
        AAAA=datenum(strMx(ii+1,1),'dd.mm.yyyy');
        [yr,mm,dd]=datevec(AAAA);
        for jj=1:length(depths)
            kjtemp(hh+jj,1:3)=[yr,mm,dd];
            kjtemp(hh+jj,4)=depths(jj);
            kjtemp(hh+jj,5)=numMx(ii,jj);
        end
        hh=hh+length(depths);
    end
    
    %Daily averages of automatic lake CO2 conc. measurements
    [CO2ObsAuto,~] = xlsread...
        ('I_O_gases\Kuiva_Obs_CO2_gh.xls','CO2auto2014corr');
    
end

lake='Kuivajärvi'; %Järven nimi
year=2014; %Mallinnuksen aloitusvuosi
m_start= [2013,1,8]; %Mallinnuksen aloituspäivä
m_stop=[2014,12,31];  %Mallinnuksen lopetuspäivä

initfile='I_O_gases\KJ_init_01_13_new_gases.xls';
initsheet = 'lake';
parafile='I_O_gases\KJ_para_13_new_joint_h2_50_gases.xls';gasmodel = 'Heiskanen';
%parafile='I_O_gases\KJ_para_13_new_joint_c1_50_gases.xls';gasmodel = 'CC';
%parafile='I_O_gases\KJ_para_13_new_joint_m2_50_gases.xls';gasmodel = 'U_MacIntyre';
%parafile='I_O_gases\KJ_para_13_new_joint_t2_50_gases.xls';gasmodel = 'SR_Tedford';
inputfile='I_O_gases\Input_KJ_2012-2014_gases.xls';


tic
[zz,Az,Vz,tt,Qst,Kzt,Tzt,Czt,Szt,Pzt,Chlzt,PPzt,DOPzt,DOCzt,DOCzt1,DOCzt2,DOCzt3,DOCtfrac,...
    Daily_BB1t,Daily_BB2t,Daily_BB3t,Daily_PBt,DICzt,CO2zt,O2zt,O2_sat_relt,O2_sat_abst,POCzt,BODzt,Qzt_sed,lambdazt,...
    P3zt_sed,P3zt_sed_sc,His,DoF,DoM,MixStat,Wt,surfaceflux,oxygenflux,CO2_eqt,K0t,O2_eqt,K0_O2t,CO2_ppmt,...
    dO2Chlt,dO2BODt,dO2SODt,testi1t,testi2t,testi3t,testi4t,Heff_osat]...
    = solvemodel_vC_gases(m_start,m_stop,initfile,initsheet,inputfile,'timeseries', parafile,'lake',Qlambda,gasmodel);
run_time=toc

tt_mod = tt - datenum(year,1,1); %time now scaled so that it begins from the 1 january of the "year" (=0)

%=Temperature profile observations (tt_mod, z, T)
TempObs=[datenum(kjtemp(:,1:3)) - datenum(year,1,1),kjtemp(:,4), kjtemp(:,5)];

%==========================================================================

zlim = [0 max(zz)];   %Järven syvyysasteikon rajat
tlim = [min(tt_mod) max(tt_mod)];  %Aika-asteikon rajat

% thermocline depth
zt = MixStat(12,:);

figure(10)   %Snow and ice thickness and water temperature isopleths
clf
subplot(4,1,2:4) %Veden lämpötilaprofiili
pcolor(tt_mod,zz,Tzt)
shading interp
axis ij
hold on
plot(tt_mod,zt,'k','LineWidth',1);   %Termokliinin syvyyskäyrä
hold off
datetick('x','mmm'); %Vaaka-akselin jakoviivojen päivämääräotsikon muoto
set(gca,'ylim',zlim); %Pystyakselin rajat
caxis([0 25]);   %Lämpötila-asteikon rajat
colorbar;
set(gca,'fontsize',9);
ylabel('Depth (m)')   %Pystyakselin otsikko
set(gca,'TickDir','out')

subplot(4,1,1:1);   %Jään ja lumen paksuus
plot(tt_mod,His(1,:)+His(2,:),'-r',tt_mod,His(1,:)-His(3,:),':c',tt_mod,His(1,:),'-b')
% Jään ja lumen yhteispaksuus (punainen viiva), teräsjään paksuus
% (sinivihreä pisteviiva), kokonaisjäänpaksuus (sininen viiva)
set(gca,'fontsize',9);
set(gca,'ylim',[0 1]);   %Pystyakselin rajat
datetick('x','mmm');   %Vaaka-akselin jakoviivojen päivämääräotsikon muoto
set(gca,'XTickLabel',[]);
set(gca,'YTick',[0.2 0.4 0.6 0.8 1]); %Pystyakselin jaotus
set(gca,'TickDir','out')
ylabel('Hice, Hsnow (m)');   %Pystyakselin otsikko

grid on;

figure(16) %Carbon balance
clf
subplot(211)
plot(tt_mod, cumsum(MixStat(24,:)),'r') %Cumulative C inflow
hold on
plot(tt_mod, cumsum(MixStat(36,:)),'b')  %Cumulative C outflow
plot(tt_mod, cumsum(MixStat(26,:)),'c') %Cumulative C sedimentation
plot(tt_mod, cumsum(MixStat(27,:)),'k--') %Cumulative C internal loading
plot(tt_mod, -cumsum(MixStat(31,:)),'g') %Cumulative C surface flux
plot(tt_mod, (MixStat(29,:)),'m')  %Change in water column C content
plot(tt_mod, cumsum(MixStat(24,:)-MixStat(36,:)-MixStat(26,:)+MixStat(27,:)-MixStat(31,:))-MixStat(29,:),'k')
%C balance (inflow - outflow - sedimentation + resuspension - change in water column - surface flux)
datetick('x','mmm'); %Vaaka-akselin jakoviivojen päivämääräotsikon muoto
H=legend('Inflow of C', 'Outflow of C', 'Sedimentation of C', 'Internal loading of C',...
    'Surface flux of C', 'Change in lake C', 'C-Balance');
set(H,'fontsize',8);
set(H,'Location','NorthWest'); %Selityslaatikon sijainti
grid on;
ylabel('kg')

dum=datevec(tt_mod+datenum(year,1,1));
yrs=dum(:,1);
kk=0;
Intern=NaN*ones(length(max(yrs)-min(yrs))+1,5);
for i=min(yrs):max(yrs)
    inx=find(yrs==i);
    kk=kk+1;
    Intern(kk,1)=sum(MixStat(27,inx)); %C resuspension
    Intern(kk,2)=sum(MixStat(17,inx)); %Chl resuspension (50/50 between groups)
    Intern(kk,3)=sum(MixStat(30,inx)); %Net flux out of sediment
    Intern(kk,4)=sum(MixStat(24,inx)); %Inflow
    Intern(kk,5)=sum(MixStat(25,inx)); %Outflow
    Intern(kk,6)=sum(MixStat(31,inx)); %Surface flux
end

subplot(212)
plot([min(yrs)+0:max(yrs)], -1e-3*Intern(1:end,3),'k','linewidth',2)%Net C flux to sediment
hold on
plot([min(yrs)+0:max(yrs)], 1e-3*Intern(1:end,4),'r','linewidth',2) %C inflow
plot([min(yrs)+0:max(yrs)], 1e-3*Intern(1:end,6),'r--','linewidth',2) %C surface flux
plot([min(yrs)+0:max(yrs)], 1e-3*Intern(1:end,5),'b','linewidth',2) %C outflow

H=legend('Net C flux to sed.','C inflow','Surface flux','C outflow'); %Selityslaatikon otsikot
title('C budget','fontweight','bold')
set(H,'fontsize',8,'Location','NorthEast');
ylabel('tons/year') %Pystyakselin otsikko
grid on;

dz=zz(2)-zz(1);
depths_CO2 = [0.5 2.5 7];
CO2_mod = interp1(zz+dz/2,CO2zt,depths_CO2);

tlims=[datenum(m_start) datenum(m_stop)];

figure(544) %CO2 concentration with automatic measurements
clf

subplot (311) % 0.5 m
plot(tt+5,CO2_mod(1,:)/44.01,'b-','LineWidth',1);
hold on
plot(CO2ObsAuto(:,1),CO2ObsAuto(:,2),'r.','MarkerSize',6);
xlim(tlims)
title('CO_{2} concentration 0.5 m','fontsize',9)
set(gca,'xticklabel',[]);
set(gca,'Ylim',[0 250]);
set(gca,'fontsize',9);
set(gca,'Position',[0.1300 0.65 0.7750 0.2300])

subplot (312) % 2.5 m
plot(tt,CO2_mod(2,:)/44.01,'b-','LineWidth',1);
hold on
plot(CO2ObsAuto(:,1),CO2ObsAuto(:,4),'r.','MarkerSize',6);
xlim(tlims)
ylabel('CO_{2} (\mumol l^{-1})','fontsize',9)
set(gca,'XTickLabel',[])
title('2.5 m','Fontsize',9)
set(gca,'Ylim',[0 350]);
set(gca,'fontsize',9);
set(gca,'Position',[0.1300 0.38 0.7750 0.2300])

subplot (313) % 7.0 m
plot(tt,CO2_mod(3,:)/44.01,'b-','LineWidth',1);
hold on
plot(CO2ObsAuto(:,1),CO2ObsAuto(:,5),'r.','MarkerSize',6);
xlim(tlims)
datetick('x','mm yy')
title('7 m','Fontsize',9)
set(gca,'Ylim',[0 400]);
set(gca,'fontsize',9);
set(gca,'Position',[0.1300 0.1 0.7750 0.2300])


kCO2 = squeeze(testi4t(:,:,2))';
kCO2 = kCO2(:,1);
kCO2(kCO2==0) = NaN;

figure(17) % Gas transfer velocity for CO2 and air-water CO2 flux
clf
subplot(211)
plot(tt,kCO2,'b')
title('Gas transfer velocity for CO_2')
ylabel('k_{CO2} (m s^{-1})')
datetick('x','mmm')
xlim(tlims)
subplot(212)
plot(tt,0.001*surfaceflux,'b')
title('Air-water CO_2 flux')
ylabel('F_{CO2} (g CO_2 m^{-2} s^{-1})')
datetick('x','mmm')
xlim(tlims)


depths_f18 = [1 5 10];
Tzt_f18=interp1(zz+dz/2,Tzt,depths_f18);

figure(19) %Simulated and observed temperatures
clf
subplot(311) %Pintakerros, 0,5 metriä - T-havainnot vuosina 90-99 ja 04-07 syvyydeltä 0 m
inx=find(TempObs(:,2)==depths_f18(1));
plot(TempObs(inx,1)+datenum(year,1,1),TempObs(inx,3),'r+','linewidth',2); %Havainnot
hold on
plot(tt_mod+datenum(year,1,1),Tzt_f18(1,:),'-'); %Mallinnettu lämpötila 0,5 metrissä
set(gca,'ylim',[0 25]); %Lämpötila-asteikon rajat
ylabel('^oC','fontsize',9) %Pystyakselin otsikko
title(['Temperature ',num2str(depths_f18(1)),' m'],'fontweight','bold') %Kuvaajan otsikko
datetick('x','mm yy') %Vaaka-akselin jakoviivojen päivämääräotsikon muoto
grid on
set(gca,'fontsize',9)
set(gca,'xticklabel',[]);
set(gca,'xlim',tlims) %Aika-akselin rajat

subplot(312) %Lämpötilan harppauskerros, 3 metriä (b=c-1)
inx=find(TempObs(:,2)==depths_f18(2)); %havainnot 2000-2003
plot(TempObs(inx,1)+datenum(year,1,1),TempObs(inx,3),'r+','linewidth',2);
hold on
plot(tt_mod+datenum(year,1,1),Tzt_f18(2,:),'-'); %Mallinnettu lämpötila 2 metrissä
set(gca,'ylim',[0 25]); %Lämpötila-asteikon rajat
ylabel('^oC','fontsize',9) %Pystyakselin otsikko
title(['Temperature ',num2str(depths_f18(2)),' m'],'fontweight','bold') %Kuvaajan otsikko
datetick('x','mm yy') %Vaaka-akselin jakoviivojen päivämääräotsikon muoto
grid on
set(gca,'fontsize',9)
set(gca,'xticklabel',[]);
set(gca,'xlim',tlims) %Aika-akselin rajat

subplot(313) %Alusvesi, 5 metriä - T-havainnot vuosina 90-99 ja 04-07 syvyydeltä 5 m
inx=find(TempObs(:,2)==depths_f18(3)); %havainnot 2000-2003
plot(TempObs(inx,1)+datenum(year,1,1),TempObs(inx,3),'r+','linewidth',2);
hold on
plot(tt_mod+datenum(year,1,1),Tzt_f18(3,:),'-');
set(gca,'ylim',[0 25]); %Lämpötila-asteikon rajat
ylabel('^oC','fontsize',9) %Pystyakselin otsikko
xlabel('year','fontsize',9) %Vaaka-akselin otsikko
title(['Temperature ',num2str(depths_f18(3)),' m'],'fontweight','bold') %Kuvaajan otsikko
datetick('x','mm yy') %Vaaka-akselin jakoviivojen päivämääräotsikon muoto
grid on
set(gca,'fontsize',9)
set(gca,'xlim',tlims) %Aika-akselin rajat

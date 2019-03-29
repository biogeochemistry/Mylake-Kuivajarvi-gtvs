%Stand-alone script for generating the figures in the manuscript and
%calculating the performance metrics for air-water fluxes.

load plotdata.mat

colors_m = {'r-','g-','b-','k-'};
colors_m2 = {'r:','g:','b:','k:'};
linew = 1.0;
ruskea = 1/255*[128 0 0];

leg_models = {'HE','CC','MI','TE','Meas.'};

xlims_ows13 = [datenum([2013 5 3]) datenum([2013 11 25])];
ows13 = (find(tt==xlims_ows13(1)):find(tt==xlims_ows13(2)));

xlims_ows13_1 = [datenum([2013 5 3]) datenum([2013 5 31])];
xlims_ows13_1_plot = [datenum([2013 5 1]) datenum([2013 5 31])];
ows13_1 = (find(tt==xlims_ows13_1(1)):find(tt==xlims_ows13_1(2)));

xlims_ows13_2 = [datenum([2013 6 1]) datenum([2013 10 31])];
xlims_ows13_2_plot = [datenum([2013 6 1]) datenum([2013 11 1])];
ows13_2 = (find(tt==xlims_ows13_2(1)):find(tt==xlims_ows13_2(2)));

xlims_ows14 = [datenum([2014 4 3]) datenum([2014 11 23])];
ows14 = (find(tt==xlims_ows14(1)):find(tt==xlims_ows14(2)));
linw = 0.5;
fntsz = 8;
markersz = 5;

ylim_k = [0 15];
ylabel_k = '\itk \rm(cm h^{-1})';
kfactor = 360000;


xlims_mayoct13 = [datenum([2013 5 3]) datenum([2013 10 31])];
mayoct13 = (find(tt==xlims_mayoct13(1)):find(tt==xlims_mayoct13(2)));

xlims_heat = [datenum([2013 5 1]) datenum([2013 11 1])];

xlims_Fmeas = [datenum([2013 5 3]) datenum([2013 10 31])];
Fmeas = (find(tt==xlims_Fmeas(1)):find(tt==xlims_Fmeas(2)));
Fobs = find(Obs_flux_zml025(:,1)==xlims_Fmeas(1)):find(Obs_flux_zml025(:,1)==xlims_Fmeas(2));

dz = zz(2)-zz(1);
depths = [0.5 2.5 7];

Tzt_he_mod = interp1(zz+dz/2,Tzt_he,depths);
Tzt_cc_mod = interp1(zz+dz/2,Tzt_cc,depths);
Tzt_mi_mod = interp1(zz+dz/2,Tzt_mi,depths);
Tzt_te_mod = interp1(zz+dz/2,Tzt_te,depths);
CO2zt_he_mod = interp1(zz+dz/2,CO2zt_he./44.01,depths);
CO2zt_cc_mod = interp1(zz+dz/2,CO2zt_cc./44.01,depths);
CO2zt_mi_mod = interp1(zz+dz/2,CO2zt_mi./44.01,depths);
CO2zt_te_mod = interp1(zz+dz/2,CO2zt_te./44.01,depths);

xlims_cv = [datenum(2013,1,1),datenum(2015,1,1)];

%----------------- k_CO2 and F_CO2 in 2013-1014 -----------------
%%{

surfaceflux_he(surfaceflux_he==0) = NaN;
surfaceflux_cc(surfaceflux_cc==0) = NaN;
surfaceflux_mi(surfaceflux_mi==0) = NaN;
surfaceflux_te(surfaceflux_te==0) = NaN;

xmnthsFk13 = [datenum(2013,5,1),datenum(2013,6,1),datenum(2013,7,1),datenum(2013,8,1),...
    datenum(2013,9,1),datenum(2013,10,1),datenum(2013,11,1)];
mnthwrdsFk13 = {'May 13';'';'Jul 13';'';'Sep 13';'';'Nov 13'};
xmnthsFk14 = [datenum(2014,5,1),datenum(2014,6,1),datenum(2014,7,1),...
    datenum(2014,8,1),datenum(2014,9,1),datenum(2014,10,1),datenum([2014,11,1]),datenum([2014,12,1])];
mnthwrdsFk14 = {'May 14';'';'Jul 14';'';'Sep 14';'';'Nov 14';''};

figure(910)
%set(gcf, 'Outerposition',[100 200 1600 900])
set(gcf, 'Outerposition',[700 400 700 600]) %600])
clf
spk13 = subplot(221);
plot(tt(ows13),kfactor*k_he(ows13),colors_m{1},'LineWidth',linw)
hold on
plot(tt(ows13),kfactor*k_cc(ows13),'Color',ruskea,'LineWidth',linw)
plot(tt(ows13),kfactor*k_mi(ows13),colors_m{3},'LineWidth',linw)
plot(tt(ows13),kfactor*k_te(ows13),'Color',[0.8,0,0.9],'LineWidth',linw)
set(spk13,'Xtick',xmnthsFk13)
text(datenum([2013 5 15]), 14, '(a)','fontsize',fntsz)
ylim(ylim_k)
ylabel(ylabel_k,'fontsize',fntsz)
xlim([datenum([2013 5 1]) datenum([2013 11 30])])
set(gca,'Xticklabel',[])
set(gca,'fontsize',fntsz)


spk14 = subplot(222);
plot(tt(ows14),kfactor*k_he(ows14),colors_m{1},'LineWidth',linw)
hold on
plot(tt(ows14),kfactor*k_cc(ows14),'Color',ruskea,'LineWidth',linw)
plot(tt(ows14),kfactor*k_mi(ows14),colors_m{3},'LineWidth',linw)
plot(tt(ows14),kfactor*k_te(ows14),'Color',[0.8,0,0.9],'LineWidth',linw)
set(spk14,'Xtick',xmnthsFk14)
ylim(ylim_k)
xlim([datenum([2014 4 2]) datenum([2014 12 1])])
set(gca,'YAxisLocation','Right')
set(gca,'Xticklabel',[])
set(gca,'Yticklabel',[])
set(gca,'fontsize',fntsz)

plot([datenum([2014 4 2]),datenum([2014 4 2])],[-0.1,16.5],'w','LineWidth',10*linew,'Clipping','off');
plot([datenum([2014 4 2]),datenum([2014 4 2])],[0.5,15.5],'k--','LineWidth',0.5*linew,'Clipping','off');

spF13 = subplot(223);
plot(tt(ows13),surfaceflux_he(1,ows13)/44.01/86.4,colors_m{1},'LineWidth',linw);
hold on
plot(tt(ows13),surfaceflux_cc(1,ows13)/44.01/86.4,'Color',ruskea,'LineWidth',linw);
plot(tt(ows13),surfaceflux_mi(1,ows13)/44.01/86.4,colors_m{3},'LineWidth',linw);
plot(tt(ows13),surfaceflux_te(1,ows13)/44.01/86.4,'Color',[0.8,0,0.9],'LineWidth',linw);
set(spF13,'Xtick',xmnthsFk13)
set(spF13,'Xticklabel',mnthwrdsFk13)
text(datenum([2013 5 15]), 2.55, '(b)','fontsize',fntsz)
xlim([datenum([2013 5 1]) datenum([2013 11 30])])
ylblF1314 = ylabel('\itF_{\rmCO2} \rm(\mumol m^{-2} s^{-1})','fontsize',fntsz);
set(gca,'Ylim',[-0.15 2.8]);
set(gca,'fontsize',fntsz)


spF14 = subplot(224);
plot(tt(ows14),surfaceflux_he(1,ows14)/44.01/86.4,colors_m{1},'LineWidth',linw);
hold on
plot(tt(ows14),surfaceflux_cc(1,ows14)/44.01/86.4,'Color',ruskea,'LineWidth',linw);
plot(tt(ows14),surfaceflux_mi(1,ows14)/44.01/86.4,colors_m{3},'LineWidth',linw);
plot(tt(ows14),surfaceflux_te(1,ows14)/44.01/86.4,'Color',[0.8,0,0.9],'LineWidth',linw);
set(spF14,'Xtick',xmnthsFk14)
set(spF14,'Xticklabel',mnthwrdsFk14)
set(gca,'YAxisLocation','Right')
xlim([datenum([2014 4 2]) datenum([2014 12 1])])
set(gca,'Yticklabel',[])

lege_k = legend(leg_models{1},leg_models{2},leg_models{3},leg_models{4});
set(lege_k,'Position',[0.82 0.36 0.04 0.04],'Box','Off','FontSize',fntsz)
set(gca,'fontsize',fntsz)

legek_line = findobj(lege_k,'type','line');
xd2  = get(legek_line(2),'XData');
xd2(1)= xd2(1)+0.40;
xd2(2)= xd2(2)-0.00;
set(legek_line(2),'XData',xd2)
set(legek_line(4),'XData',xd2)
set(legek_line(6),'XData',xd2)
set(legek_line(8),'XData',xd2)

set(gca,'Ylim',[-0.15 2.8]);
set(gca,'fontsize',fntsz)
set(gcf,'Color','w')

plot([datenum([2014 4 2]),datenum([2014 4 2])],[-0.20,2.8],'w','LineWidth',8*linew,'Clipping','off');
plot([datenum([2014 4 2]),datenum([2014 4 2])],[-0.05,2.75],'k--','LineWidth',0.5*linew,'Clipping','off');

ylblposF1314 = get(ylblF1314,'Position');
ylblposF1314(1) = ylblposF1314(1)+12;
set(ylblF1314,'Position',ylblposF1314);

vasemmanleveys = datenum([2013 11 30])-datenum([2013 5 1]); 
oikeanleveys = datenum([2014 12 1])-datenum([2014 4 2]);

leveyssuhde = vasemmanleveys/(vasemmanleveys+oikeanleveys);

set(spk13,'Position',[0.07 0.53 leveyssuhde*0.91 0.44])
set(spk14,'Position',[0.07+leveyssuhde*0.91 0.53 (1-leveyssuhde)*0.91 0.44])
set(spF13,'Position',[0.07 0.05 leveyssuhde*0.91 0.44])
set(spF14,'Position',[0.07+leveyssuhde*0.91 0.05 (1-leveyssuhde)*0.91 0.44])

set(gcf,'Color','w')
%}
%%{
% ------ CO2 and T in 2013-2014 (calibration and validation) ------

xmnths = [datenum(2013,1,1),datenum(2013,4,1),datenum(2013,7,1),...
    datenum(2013,10,1),datenum(2014,1,1),datenum(2014,4,1),datenum(2014,7,1),...
    datenum(2014,10,1),datenum(2015,1,1)];
mnthwrds = {'Jan 13';'Apr 13';'Jul 13';'Oct 13';'Jan 14';'Apr 14';'Jul 14';'Oct 14';''};


figure(4300)
clf
set(gcf, 'Outerposition',[700 400 700 500]) % 700 <~> 149.2 mm
ykonen = subplot(311);
A1 = plot(tt,CO2zt_he_mod(1,:),'r-','LineWidth',linew);
hold on
A2 = plot(tt,CO2zt_cc_mod(1,:),'Color',1/255*[128,0,0],'LineWidth',linew);
A3 = plot(tt,CO2zt_mi_mod(1,:),'b-','LineWidth',linew);
plot(tt,CO2zt_te_mod(1,:),'Color',[0.8,0,0.9],'LineWidth',linew);
plot(CO2Auto(:,1),CO2Auto(:,2),'k.','MarkerSize',markersz); %0.5 m
datetick('x','mmm')
set(gca,'xticklabel',[]);

klpois = plot([datenum([2013 1 8]),datenum([2014 12 31])],[320,320],'k','LineWidth',0.5*linew);
klpois2 = plot([datenum([2013 1 8]),datenum([2013 1 8])],[320,340],'k','LineWidth',0.5*linew);
klpois3 = plot([datenum([2014 1 1]),datenum([2014 1 1])],[320,340],'k','LineWidth',0.5*linew);
klpois4 = plot([datenum([2014 12 31]),datenum([2014 12 31])],[320,340],'k','LineWidth',0.5*linew);
set(klpois,'Clipping','off')
set(klpois2,'Clipping','off')
set(klpois3,'Clipping','off')
set(klpois4,'Clipping','off')
text(datenum([2013 7 1]),345,'Calibration period','HorizontalAlignment','center','FontSize',fntsz)
text(datenum([2014 7 1]),345,'Validation period','HorizontalAlignment','center','FontSize',fntsz)

leg123=legend([A1, A2, A3],leg_models{1},leg_models{2},leg_models{3});
set(leg123,'fontsize',fntsz);
set(leg123,'Orientation','Vertical','Box','Off');
set(gca,'xlim',xlims_cv)

set(leg123,'Position',[0.705 0.830 0.03 0.03])
%Selitteen malliviivan muokkaaminen
leg123_line = findobj(leg123,'type','line');
xd4 = get(leg123_line(4),'XData');
xd4(1) = xd4(1)+0.370;
xd4(2) = xd4(2)-0.060;
set(leg123_line(4),'XData',xd4)
xd2  =get(leg123_line(2),'XData');
xd2(1)=xd2(1)+0.370;
xd2(2)=xd2(2)-0.060;
set(leg123_line(2),'XData',xd2)
set(leg123_line(2),'XData',xd2)
xd6  =get(leg123_line(6),'XData');
xd6(1)=xd6(1)+0.370;
xd6(2)=xd6(2)-0.060;
set(leg123_line(6),'XData',xd6)

plot([datenum([2014 5 15]),datenum([2014 11 25])],[115,115],'k','LineWidth',0.5*linew);
plot([datenum([2014 5 15]),datenum([2014 11 25])],[275,275],'k','LineWidth',0.5*linew);
plot([datenum([2014 5 15]),datenum([2014 5 15])],[115,275],'k','LineWidth',0.5*linew);
plot([datenum([2014 11 25]),datenum([2014 11 25])],[115,275],'k','LineWidth',0.5*linew);

text(735250,265,'(a) 0.2 m','Fontsize',fntsz)
set(gca,'Ylim',[0 300]);
set(gca,'fontsize',fntsz);

kakonen = subplot(312);
plot(tt,CO2zt_he_mod(2,:),'r-','LineWidth',linew);
hold on
plot(tt,CO2zt_cc_mod(2,:),'Color',ruskea,'LineWidth',linew);
plot(tt,CO2zt_mi_mod(2,:),'b-','LineWidth',linew);
A4 = plot(tt,CO2zt_te_mod(2,:),'Color',[0.8,0,0.9],'LineWidth',linew);
A5 = plot(CO2Auto(:,1),CO2Auto(:,4),'k.','MarkerSize',markersz); %2.5 m
hold off
datetick('x','mmm')
set(gca,'XTickLabel',[])
text(735250,265,'(b) 2.5 m','Fontsize',fntsz)
set(gca,'Ylim',[0 300]);
set(gca,'xlim',xlims_cv)
set(gca,'fontsize',fntsz);
ylbl = ylabel('CO_{2} concentration (mmol m^{-3})','fontsize',fntsz);
ylblpos = get(ylbl,'Position');
ylblpos(1) = ylblpos(1)+12;
set(ylbl,'Position',ylblpos);

leg45=legend([A4, A5],leg_models{4},leg_models{5});
set(leg45,'fontsize',fntsz);
set(leg45,'Orientation','Vertical','Box','Off');
set(gca,'xlim',xlims_cv)

set(leg45,'Position',[0.825 0.854 0.03 0.03])
%Selitteen malliviivan muokkaaminen
leg45_line = findobj(leg45,'type','line');


xd1  =get(leg45_line(1),'XData');
xd1=xd1(1)+0.120;
set(leg45_line(1),'XData',xd1)

xd4  =get(leg45_line(4),'XData');
xd4(1)=xd4(1)+0.300;
xd4(2)=xd4(2)-0.060;
set(leg45_line(4),'XData',xd4)

kolomone = subplot(313);
plot(tt,CO2zt_he_mod(3,:),'r-','LineWidth',linew);
hold on
plot(tt,CO2zt_cc_mod(3,:),'Color',ruskea,'LineWidth',linew);
plot(tt,CO2zt_mi_mod(3,:),'b-','LineWidth',linew);
plot(tt,CO2zt_te_mod(3,:),'Color',[0.8,0,0.9],'LineWidth',linew);
plot(CO2Auto(:,1),CO2Auto(:,5),'k.','MarkerSize',markersz); %7.0 m
plot(datenum([2012 12 25]),10,'k-','LineWidth',linew);
plot(datenum([2012 12 25]),10,'k:','LineWidth',linew);
set(gca,'XTick',xmnths)
set(gca,'XTickLabel',mnthwrds)
text(735250,350,'(c) 7 m','Fontsize',fntsz)
set(gca,'Ylim',[0 400]);
set(gca,'fontsize',fntsz);
set(gca,'xlim',xlims_cv)
set(kolomone,'Position',[0.08 0.05 0.90 0.27])
set(kakonen,'Position',[0.08 0.36 0.90 0.27])
set(ykonen,'Position',[0.08 0.67 0.90 0.27])
set(gcf,'Color','w')

figure(4301)
clf
set(gcf, 'Outerposition',[700 400 700 550]) %149.2 mm

kolomone = subplot(313);
plot(tt,Tzt_he_mod(3,:),'r-','LineWidth',linew);
hold on
plot(tt,Tzt_cc_mod(3,:),'Color',ruskea,'LineWidth',linew);
plot(tt,Tzt_mi_mod(3,:),'b-','LineWidth',linew);
plot(tt,Tzt_te_mod(3,:),'Color',[0.8,0,0.9],'LineWidth',linew);
plot(tt,Temps(:,13),'k.','MarkerSize',markersz); %7.0 m
plot(datenum([2012 12 25]),10,'k-','LineWidth',linew);
plot(datenum([2012 12 25]),10,'k:','LineWidth',linew);

set(gca,'XTick',xmnths)
set(gca,'XTickLabel',mnthwrds)
text(735250,23,'(c) 7 m','Fontsize',fntsz)
set(gca,'Ylim',[0 28]);
set(gca,'fontsize',fntsz);
set(gca,'xlim',xlims_cv)

ykonen = subplot(311);
A1 = plot(tt,Tzt_he_mod(1,:),'r-','LineWidth',linew);
hold on
A2 = plot(tt,Tzt_cc_mod(1,:),'Color',ruskea,'LineWidth',linew);
A3 = plot(tt,Tzt_mi_mod(1,:),'b-','LineWidth',linew);
plot(tt,Tzt_te_mod(1,:),'Color',[0.8,0,0.9],'LineWidth',linew);
plot(tt,Temps(:,1),'k.','MarkerSize',markersz); %0.2 m
datetick('x','mmm')
set(gca,'xticklabel',[]);

klpois = plot([datenum([2013 1 8]),datenum([2014 12 31])],[28.5,28.5],'k','LineWidth',linew);
klpois2 = plot([datenum([2013 1 8]),datenum([2013 1 8])],[28.5,30.5],'k','LineWidth',linew);
klpois3 = plot([datenum([2014 1 1]),datenum([2014 1 1])],[28.5,30.5],'k','LineWidth',linew);
klpois4 = plot([datenum([2014 12 31]),datenum([2014 12 31])],[28.5,30.5],'k','LineWidth',linew);
set(klpois,'Clipping','off')
set(klpois2,'Clipping','off')
set(klpois3,'Clipping','off')
set(klpois4,'Clipping','off')
text(datenum([2013 7 1]),31.5,'Calibration period','HorizontalAlignment','center','FontSize',fntsz)
text(datenum([2014 7 1]),31.5,'Validation period','HorizontalAlignment','center','FontSize',fntsz)

leg123=legend([A1, A2, A3],leg_models{1},leg_models{2},leg_models{3});
set(leg123,'fontsize',fntsz);
set(leg123,'Orientation','Vertical','Box','Off');
set(gca,'xlim',xlims_cv)

set(leg123,'Position',[0.470 0.210 0.03 0.03])
%Selitteen malliviivan muokkaaminen
leg123_line = findobj(leg123,'type','line');
xd4 = get(leg123_line(4),'XData');
xd4(1) = xd4(1)+0.370;
xd4(2) = xd4(2)-0.060;
set(leg123_line(4),'XData',xd4)
xd2  =get(leg123_line(2),'XData');
xd2(1)=xd2(1)+0.370;
xd2(2)=xd2(2)-0.060;
set(leg123_line(2),'XData',xd2)
set(leg123_line(2),'XData',xd2)
xd6  =get(leg123_line(6),'XData');
xd6(1)=xd6(1)+0.370;
xd6(2)=xd6(2)-0.060;
set(leg123_line(6),'XData',xd6)

text(735250,23,'(a) 0.2 m','Fontsize',fntsz)
set(gca,'Ylim',[0 28]);
set(gca,'fontsize',fntsz);

kakonen = subplot(312);
plot(tt,Tzt_he_mod(2,:),'r-','LineWidth',linew);
hold on
plot(tt,Tzt_cc_mod(2,:),'Color',ruskea,'LineWidth',linew);
plot(tt,Tzt_mi_mod(2,:),'b-','LineWidth',linew);
A4 = plot(tt,Tzt_te_mod(2,:),'Color',[0.8,0,0.9],'LineWidth',linew);
A5 = plot(tt,Temps(:,6),'k.','MarkerSize',markersz); %2.5 m
hold off
datetick('x','mmm')
set(gca,'XTickLabel',[])
text(735250,23,'(b) 2.5 m','Fontsize',fntsz)
set(gca,'Ylim',[0 28]);
set(gca,'xlim',xlims_cv)
set(gca,'fontsize',fntsz);
ylbl = ylabel(['Temperature (',char(0176),'C)'],'fontsize',fntsz);
ylblpos = get(ylbl,'Position');
ylblpos(1) = ylblpos(1)+3;
set(ylbl,'Position',ylblpos);

leg45=legend([A4, A5],leg_models{4},leg_models{5});
set(leg45,'fontsize',fntsz);
set(leg45,'Orientation','Vertical','Box','Off');
set(gca,'xlim',xlims_cv)

set(leg45,'Position',[0.585 0.230 0.03 0.03])
%Selitteen malliviivan muokkaaminen
leg45_line = findobj(leg45,'type','line');


xd1  =get(leg45_line(1),'XData');
xd1=xd1(1)+0.120;
set(leg45_line(1),'XData',xd1)

xd4  =get(leg45_line(4),'XData');
xd4(1)=xd4(1)+0.300;
xd4(2)=xd4(2)-0.060;
set(leg45_line(4),'XData',xd4)


set(kolomone,'Position',[0.07 0.05 0.91 0.27])
set(kakonen,'Position',[0.07 0.36 0.91 0.27])
set(ykonen,'Position',[0.07 0.67 0.91 0.27])
set(gcf,'Color','w')

%}
%%{
xmnths2 = [datenum(2013,6,1),datenum(2013,7,1),datenum(2013,8,1),...
    datenum(2013,9,1),datenum(2013,10,1),datenum(2013,11,1)];
mnthwrds2 = {'Jun';'Jul';'Aug';'Sep';'Oct';'Nov'};

% ------ Surface CO2 in open water season 2013 ------

figure(432)
clf
set(gcf, 'Outerposition',[700 400 700 360]) 
sp5 = subplot(121);
plot(tt(ows13_1),CO2zt_he_mod(1,ows13_1),colors_m{1},'LineWidth',linw);
hold on
plot(tt(ows13_1),CO2zt_cc_mod(1,ows13_1),'Color',ruskea,'LineWidth',linw);
plot(tt(ows13_1),CO2zt_mi_mod(1,ows13_1),colors_m{3},'LineWidth',linw);
plot(tt(ows13_1),CO2zt_te_mod(1,ows13_1),'Color',[0.8 0 0.9],'LineWidth',linw);
plot(CO2Auto(ows13_1,1),CO2Auto(ows13_1,2),'k.','LineWidth',linew); %0.5 m
plot(tt(ows13_1),CO2_eqt_he(ows13_1)/44.01,colors_m2{1},'LineWidth',linw);
plot(tt(ows13_1),CO2_eqt_cc(ows13_1)/44.01,colors_m2{2},'LineWidth',linw);
plot(tt(ows13_1),CO2_eqt_mi(ows13_1)/44.01,colors_m2{3},'LineWidth',linw);
plot(tt(ows13_1),CO2_eqt_te(ows13_1)/44.01,':','Color',[0.8 0 0.9],'LineWidth',linw);
plot(Obs_flux_zml025(:,1),Obs_flux_zml025(:,17)/44.01,colors_m{4},'LineWidth',linw);
datetick('x','mmm')
set(gca,'xlim',xlims_ows13_1_plot)
set(gca,'Ylim',[0 200]);
set(gca,'fontsize',fntsz);
ylbl = ylabel('CO_{2} concentration (mmol m^{-3})','fontsize',fntsz);
ylblpos = get(ylbl,'Position');
ylblpos(1) = ylblpos(1)-4;
set(ylbl,'Position',ylblpos);


sp6to10 = subplot(122);
plot(tt(ows13_2),CO2zt_he_mod(1,ows13_2),colors_m{1},'LineWidth',linw);
hold on
plot(tt(ows13_2),CO2zt_cc_mod(1,ows13_2),'Color',ruskea,'LineWidth',linw);
plot(tt(ows13_2),CO2zt_mi_mod(1,ows13_2),colors_m{3},'LineWidth',linw);
plot(tt(ows13_2),CO2zt_te_mod(1,ows13_2),'Color',[0.8 0 0.9],'LineWidth',linw);
plot(CO2Auto(ows13_2,1),CO2Auto(ows13_2,2),'k.','LineWidth',linew); %0.5 m
plot(tt(ows13_2),CO2_eqt_he(ows13_2)/44.01,colors_m2{1},'LineWidth',linw);
plot(tt(ows13_2),CO2_eqt_cc(ows13_2)/44.01,colors_m2{2},'LineWidth',linw);
plot(tt(ows13_2),CO2_eqt_mi(ows13_2)/44.01,colors_m2{3},'LineWidth',linw);
plot(tt(ows13_2),CO2_eqt_te(ows13_2)/44.01,':','Color',[0.8 0 0.9],'LineWidth',linw);
plot(Obs_flux_zml025(:,1),Obs_flux_zml025(:,17)/44.01,colors_m{4},'LineWidth',linw);
%annotation('textarrow', [0.70 0.64], [0.16 0.20],'String',' \itC_{\rmeq}','HeadLength',6,'HeadWidth',6);
text(datenum([2013 9 25]), 14, '\itC_{\rmeq}','fontsize',fntsz)

set(gca,'XTick',xmnths2)
set(gca,'XTickLabel',mnthwrds2)
set(gca,'YAxisLocation','Right')
set(gca,'xlim',xlims_ows13_2_plot)

leg=legend(leg_models{1},leg_models{2},leg_models{3},leg_models{4},leg_models{5});
set(leg,'fontsize',fntsz);
set(leg,'Orientation','Vertical','Box','Off');

set(leg,'Position',[0.62 0.72 0.03 0.03])
%Selitteen malliviivan muokkaaminen
leg_line = findobj(leg,'type','line');
xd4 = get(leg_line(4),'XData');
xd4(1) = xd4(1)+0.320;
xd4(2) = xd4(2)-0.060;
set(leg_line(4),'XData',xd4)
set(leg_line(6),'XData',xd4)
set(leg_line(8),'XData',xd4)
set(leg_line(10),'XData',xd4)
xd1 = get(leg_line(1),'XData');
set(leg_line(1),'XData',xd1+0.13)

set(gca,'Ylim',[0 100]);
set(gca,'fontsize',fntsz);
set(gcf,'Color','w')


startx = 0.08;
widtot = 0.875;
widmay = 31/184*widtot;
widjunoct = 153/184*widtot;

set(sp5,'Position',[startx 0.085 widmay 0.87])
set(sp6to10,'Position',[startx+widmay 0.085 widjunoct 0.87])

% ------ F_CO2 in open water season 2013 ------

text_F = {'(a) HE','(b) CC','(c) MI','(d) TE'};
xmnthsFk = [datenum(2013,5,1),datenum(2013,6,1),datenum(2013,7,1),datenum(2013,8,1),...
    datenum(2013,9,1),datenum(2013,10,1),datenum(2013,11,1)];
mnthwrdsFk = {'May';'Jun';'Jul';'Aug';'Sep';'Oct';'Nov'};
ylabel_F = '\itF_{\rmCO2} \rm(\mumol m^{-2} s^{-1})';

figure(93) %In units mumol m-2 s-1
clf
set(gcf, 'Outerposition',[1200 200 700 750]) 
hF1 = subplot(411);
plot(tt(mayoct13),surfaceflux_he(mayoct13)./(44.01*86.4),'b')
hold on
plot(Obs_flux_zml025(:,1),Obs_flux_zml025(:,11)./(44.01*86.4),'k.','Markersize',7)
ylim([-0.1 2])
ylbla = ylabel(ylabel_F,'fontsize',fntsz);

leg_F = legend('Simulated','Calculated');
set(leg_F,'Position',[0.78 0.90 0.05 0.05],'Box','Off','fontsize',fntsz)

leg_F_line = findobj(leg_F,'type','line');
xd4 = get(leg_F_line(4),'XData');
xd4(1) = xd4(1)+0.300;
xd4(2) = xd4(2)-0.000;
set(leg_F_line(4),'XData',xd4)
xd1  =get(leg_F_line(1),'XData');
xd1=xd1+0.140;
set(leg_F_line(1),'XData',xd1)

set(gca,'XTick',xmnthsFk)
set(gca,'XTickLabel',mnthwrdsFk)
set(gca,'YTick',[0 0.5 1 1.5 2])
set(gca,'YTickLabel',{'   0' '  0.5' '    1' '  1.5' '    2'})
xlim([datenum([2013 5 1]) datenum([2013 11 1])])
text(735372,1.75,text_F{1},'Fontsize',fntsz)
set(gca,'XTickLabel',[])
ylblposa = get(ylbla,'Position');
ylblposa(1) = ylblposa(1)+5;
set(ylbla,'Position',ylblposa);
grid on
set(gca,'fontsize',fntsz)

hF2 = subplot(412);
plot(tt(mayoct13),surfaceflux_cc(mayoct13)./(44.01*86.4),'b')
hold on
plot(Obs_flux_zml025(:,1),Obs_flux_zml025(:,13)./(44.01*86.4),'k.','Markersize',7)
ylim([-0.05 1.1])
ylblb = ylabel(ylabel_F,'fontsize',fntsz);
set(gca,'XTick',xmnthsFk)
set(gca,'XTickLabel',mnthwrdsFk)
set(gca,'YTick',[0 0.25 0.50 0.75 1])
set(gca,'YTickLabel',{'0' '0.25' '0.5' '0.75' '1'})
xlim([datenum([2013 5 1]) datenum([2013 11 1])])
text(735372,0.95,text_F{2},'Fontsize',fntsz)
set(gca,'XTickLabel',[])
ylblposb = get(ylblb,'Position');
ylblposb(1) = ylblposb(1)+5;
set(ylblb,'Position',ylblposb);
grid on
set(gca,'fontsize',fntsz)


hF3 = subplot(413);
plot(tt(mayoct13),surfaceflux_mi(mayoct13)./(44.01*86.4),'b')
hold on
plot(Obs_flux_zml025(:,1),Obs_flux_zml025(:,14)./(44.01*86.4),'k.','Markersize',7)
datetick('x','mmm')
ylim([-0.1 2.1])
ylblc = ylabel(ylabel_F,'fontsize',fntsz);
set(gca,'XTick',xmnthsFk)
set(gca,'XTickLabel',mnthwrdsFk)
set(gca,'YTick',[0 0.5 1 1.5 2])
set(gca,'YTickLabel',{'   0' '  0.5' '    1' '  1.5' '    2'})
xlim([datenum([2013 5 1]) datenum([2013 11 1])])
text(735372,1.8,text_F{3},'Fontsize',fntsz)
set(gca,'XTickLabel',[])
ylblposc = get(ylblc,'Position');
ylblposc(1) = ylblposc(1)+5;
set(ylblc,'Position',ylblposc);
grid on
set(gca,'fontsize',fntsz)

hF4 = subplot(414);
plot(tt(mayoct13),surfaceflux_te(mayoct13)./(44.01*86.4),'b')
hold on
plot(Obs_flux_zml025(:,1),Obs_flux_zml025(:,15)./(44.01*86.4),'k.','Markersize',7)
ylim([-0.0 4.5])
ylbld = ylabel(ylabel_F,'fontsize',fntsz);
set(gca,'XTick',xmnthsFk)
set(gca,'XTickLabel',mnthwrdsFk)
set(gca,'YTick',[0 1 2 3 4])
set(gca,'YTickLabel',{'     0' '     1' '     2' '     3' '     4'})
xlim([datenum([2013 5 1]) datenum([2013 11 1])])
text(735372,3.9,text_F{4},'Fontsize',fntsz)
ylblposd = get(ylbld,'Position');
ylblposd(1) = ylblposd(1)+5;
set(ylbld,'Position',ylblposd);
grid on
set(gca,'fontsize',fntsz)

set(hF4,'Position',[0.09 0.04 0.89 0.21])
set(hF3,'Position',[0.09 0.28 0.89 0.21])
set(hF2,'Position',[0.09 0.52 0.89 0.21])
set(hF1,'Position',[0.09 0.76 0.89 0.21])
set(gcf,'Color','w')

% ------ k_CO2 in open water season 2013 ------

ylim_k = [0 16];
ylabel_k = '\itk \rm(cm h^{-1})';
kfactor = 360000;
text_k_xy = [datenum([2013 5 5]) 14];
text_k = text_F; %{'(a) HE','(b) CC','(c) MI','(d) TE'};


figure(92)
clf
set(gcf, 'Outerposition',[50 200 700 750]) 
hk1 = subplot(411);
plot(tt(mayoct13),kfactor*k_he(mayoct13),'b')
hold on
plot(Obs_flux_zml025(:,1),kfactor*Obs_flux_zml025(:,6),'k.','Markersize',7)
set(gca,'XTick',xmnthsFk)
ylblka = ylabel('\itk_{\rmHE} \rm(cm h^{-1})','fontsize',fntsz);
leg_k = legend('Simulated','Calculated');
set(leg_k,'Position',[0.78 0.90 0.05 0.05],'Box','Off','fontsize',fntsz)

leg_k_line = findobj(leg_k,'type','line');
xd4 = get(leg_k_line(4),'XData');
xd4(1) = xd4(1)+0.300;
xd4(2) = xd4(2)-0.000;
set(leg_k_line(4),'XData',xd4)
xd1  =get(leg_k_line(1),'XData');
xd1=xd1+0.140;
set(leg_k_line(1),'XData',xd1)

text(text_k_xy(1),text_k_xy(2),text_k{1},'Fontsize',fntsz)
set(gca,'XTickLabel',[])
ylim(ylim_k)
xlim([datenum([2013 5 1]) datenum([2013 11 1])])
ylblposka = get(ylblka,'Position');
ylblposka(1) = ylblposka(1)+5;
set(ylblka,'Position',ylblposka);
grid on
set(gca,'fontsize',fntsz)

hk2 = subplot(412);
plot(tt(mayoct13),kfactor*k_cc(mayoct13),'b')
hold on
plot(Obs_flux_zml025(:,1),kfactor*Obs_flux_zml025(:,8),'k.','Markersize',7)
set(gca,'XTick',xmnthsFk)
ylblkb = ylabel('\itk_{\rmCC} \rm(cm h^{-1})','fontsize',fntsz);
text(text_k_xy(1),8/16*text_k_xy(2),text_k{2},'Fontsize',fntsz)
set(gca,'XTickLabel',[])
ylim(8/16*ylim_k)
xlim([datenum([2013 5 1]) datenum([2013 11 1])])
ylblposkb = get(ylblkb,'Position');
ylblposkb(1) = ylblposkb(1)-0;
set(ylblkb,'Position',ylblposkb);
grid on
set(gca,'fontsize',fntsz)

hk3 = subplot(413);
plot(tt(mayoct13),kfactor*k_mi(mayoct13),'b')
hold on
plot(Obs_flux_zml025(:,1),kfactor*Obs_flux_zml025(:,9),'k.','Markersize',7)
set(gca,'XTick',xmnthsFk)
ylblkc = ylabel('\itk_{\rmMI} \rm(cm h^{-1})','fontsize',fntsz);
text(text_k_xy(1),text_k_xy(2),text_k{3},'Fontsize',fntsz)
set(gca,'XTickLabel',[])
ylim(ylim_k)
xlim([datenum([2013 5 1]) datenum([2013 11 1])])
ylblposkc = get(ylblkc,'Position');
ylblposkc(1) = ylblposkc(1)+5;
set(ylblkc,'Position',ylblposkc);
grid on
set(gca,'fontsize',fntsz)

hk4 = subplot(414);
plot(tt(mayoct13),kfactor*k_te(mayoct13),'b')
hold on
plot(Obs_flux_zml025(:,1),kfactor*Obs_flux_zml025(:,10),'k.','Markersize',7)
set(gca,'XTick',xmnthsFk)
set(gca,'XTickLabel',mnthwrdsFk)
ylblkd =ylabel('\itk_{\rmTE} \rm(cm h^{-1})','fontsize',fntsz);
text(text_k_xy(1),text_k_xy(2),text_k{4},'Fontsize',fntsz)
ylim(ylim_k)
xlim([datenum([2013 5 1]) datenum([2013 11 1])])
ylblposkd = get(ylblkd,'Position');
ylblposkd(1) = ylblposkd(1)+5;
set(ylblkd,'Position',ylblposkd);
grid on
set(gca,'fontsize',fntsz)

set(hk4,'Position',[0.07 0.04 0.90 0.21])
set(hk3,'Position',[0.07 0.28 0.90 0.21])
set(hk2,'Position',[0.07 0.52 0.90 0.21])
set(hk1,'Position',[0.07 0.76 0.90 0.21])
set(gcf,'Color','w')




%---------- Q_eff, z_AML in open water season 2013 ----------
%%{

%Havaintojen päällysveden syvyys.
[z_epi_obs] = z_epilimnion_obs(Temps,depths_Temps);

figure(650)
clf
set(gcf, 'Outerposition',[300 250 700 400]) 
Hykonen = subplot(311);
plot(tt(mayoct13),Heff_he(mayoct13),colors_m{1})
hold on
plot(tt(mayoct13),Heff_cc(mayoct13),'Color',ruskea)
plot(tt(mayoct13),Heff_mi(mayoct13),colors_m{3})
plot(tt(mayoct13),Heff_te(mayoct13),'Color',[0.8 0 0.9])
plot(Obs_flux_zml025(:,1),Obs_flux_zml025(:,5),'k.','MarkerSize',7)
datetick('x','mmm')
set(gca,'XTickLabel',[])
set(gca,'xlim',xlims_heat)
ylim([-300 120]) 
ylblhu1 =ylabel('\itQ_{\rmeff} \rm(W m^{-2})','FontSize',fntsz);
ylblposhu1 = get(ylblhu1,'Position');
ylblposhu1(1) = ylblposhu1(1)+5;
set(ylblhu1,'Position',ylblposhu1);
text(735365,80,'(a)','FontSize',fntsz)
set(gca,'FontSize',fntsz)
legeH1 = legend(leg_models{1},leg_models{2},leg_models{3},leg_models{4},'Meas.');
set(legeH1,'Orientation','Vertical','Box','Off')
set(legeH1,'Position',[0.90 0.78 0.04 0.04])

legH_line = findobj(legeH1,'type','line');
xd1 = get(legH_line(1),'XData');
xd1(1) = xd1(1)+0.10;
set(legH_line(1),'XData',xd1)
xd4 = get(legH_line(4),'XData');
xd4(1) = xd4(1)+0.27;
xd4(2) = xd4(2)-0.07;
set(legH_line(4),'XData',xd4)
set(legH_line(6),'XData',xd4)
set(legH_line(8),'XData',xd4)
set(legH_line(10),'XData',xd4)

Hkakonen = subplot(312);
plot(tt(mayoct13),zml_he(mayoct13),colors_m{1},'LineWidth',linw)
hold on
plot(tt(mayoct13),zml_cc(mayoct13),'Color',ruskea,'LineWidth',linw)
plot(tt(mayoct13),zml_mi(mayoct13),colors_m{3},'LineWidth',linw)
plot(tt(mayoct13),zml_te(mayoct13),'Color',[0.8 0 0.9],'LineWidth',linw)
plot(Obs_EC_vert_zml025(:,1),Obs_EC_vert_zml025(:,10),'k.','MarkerSize',7)
datetick('x','mmm')
set(gca,'xlim',xlims_heat)
ylim([0 14])
axis ij
ylblhu2 = ylabel('\itz_{\rmAML} \rm(m)','fontsize',fntsz);
ylblposhu2 = get(ylblhu2,'Position');
ylblposhu2(1) = ylblposhu2(1)-0.5;
set(ylblhu2,'Position',ylblposhu2);
text(735365,3,'(b)','fontsize',fntsz)
set(gca,'fontsize',fntsz)


set(Hkakonen,'Position',[0.085 0.07 0.79 0.33])
set(Hykonen,'Position',[0.085 0.47 0.79 0.48])
set(gcf,'Color','w')

text_Hfl_xy = [datenum([2013 5 5]) 13];
text_Hfl = {'(a)','(b)','(c)','(d)'};
%}

%----- Components of surface heat flux in open water season 2013 ------
%%{
figure(6510)
clf
set(gcf, 'Outerposition',[1100 150 700 900]) 

ykonen = subplot(411);
plot(tt(mayoct13),Heff_osat_he(mayoct13,1),colors_m{1})
hold on
plot(tt(mayoct13),Heff_osat_cc(mayoct13,1),'Color',ruskea)
plot(tt(mayoct13),Heff_osat_mi(mayoct13,1),colors_m{3})
plot(tt(mayoct13),Heff_osat_te(mayoct13,1),'Color',[0.8 0 0.9])
plot(Obs_EC_vert_zml025(:,1),-Obs_EC_vert_zml025(:,3),'k.','MarkerSize',7)
set(ykonen,'Ylim',[-100 50])
datetick('x','mmm')
set(gca,'XTickLabel',[])
set(gca,'xlim',xlims_heat)
ylblhs1 = ylabel('\itQ_{\rmH} \rm(W m^{-2})','fontsize',fntsz);
ylblposhs1 = get(ylblhs1,'Position');
ylblposhs1(1) = ylblposhs1(1)+5;
set(ylblhs1,'Position',ylblposhs1);
text(735375,32,'(a)','fontsize',fntsz)
set(gca,'fontsize',fntsz)

legeHF1 = legend(leg_models{1},leg_models{2},leg_models{3},leg_models{4},'Meas.');
set(legeHF1,'Orientation','Vertical','Box','Off','fontsize',fntsz)
set(legeHF1,'Position',[0.90 0.85 0.04 0.04])

leg_line = findobj(legeHF1,'type','line');
xd1 = get(leg_line(1),'XData');
xd1(1) = xd1(1)+0.10;
set(leg_line(1),'XData',xd1)
xd4 = get(leg_line(4),'XData');
xd4(1) = xd4(1)+0.25;
xd4(2) = xd4(2)-0.05;
set(leg_line(4),'XData',xd4)
set(leg_line(6),'XData',xd4)
set(leg_line(8),'XData',xd4)
set(leg_line(10),'XData',xd4)

kakonen = subplot(412);
plot(tt(mayoct13),Heff_osat_he(mayoct13,2),colors_m{1})
hold on
plot(tt(mayoct13),Heff_osat_cc(mayoct13,2),'Color',ruskea)
plot(tt(mayoct13),Heff_osat_mi(mayoct13,2),colors_m{3})
plot(tt(mayoct13),Heff_osat_te(mayoct13,2),'Color',[0.8 0 0.9])
plot(Obs_EC_vert_zml025(:,1),-Obs_EC_vert_zml025(:,4),'k.','MarkerSize',7)
set(kakonen,'Ylim',[-200 50])
datetick('x','mmm')
set(gca,'XTickLabel',[])
set(gca,'xlim',xlims_heat)
ylblhs2  = ylabel('\itQ_{\rmL} \rm(W m^{-2})','fontsize',fntsz);
ylblposhs2 = get(ylblhs2,'Position');
ylblposhs2(1) = ylblposhs2(1)+5;
set(ylblhs2,'Position',ylblposhs2);
text(735375,20,'(b)','fontsize',fntsz)
set(gca,'fontsize',fntsz)

kolomone = subplot(413);
plot(tt(mayoct13),Heff_osat_he(mayoct13,3),colors_m{1})
hold on
plot(tt(mayoct13),Heff_osat_cc(mayoct13,3),'Color',ruskea)
plot(tt(mayoct13),Heff_osat_mi(mayoct13,3),colors_m{3})
plot(tt(mayoct13),Heff_osat_te(mayoct13,3),'Color',[0.8 0 0.9])
plot(Obs_EC_vert_zml025(:,1),Obs_EC_vert_zml025(:,5),'k.','MarkerSize',7)
set(kolomone,'Ylim',[-150 50])
datetick('x','mmm')
set(gca,'XTickLabel',[])
set(gca,'xlim',xlims_heat)
ylblhs3  = ylabel('\itQ_{\rmLW} \rm(W m^{-2})','fontsize',fntsz);
ylblposhs3 = get(ylblhs3,'Position');
ylblposhs3(1) = ylblposhs3(1)+5;
set(ylblhs3,'Position',ylblposhs3);
text(735375,25,'(c)','fontsize',fntsz)
set(gca,'fontsize',fntsz)

nelone = subplot(414);
plot(tt(mayoct13),Heff_osat_he(mayoct13,4)+Heff_osat_he(mayoct13,5)+Heff_osat_he(mayoct13,6),colors_m{1})
hold on
plot(tt(mayoct13),Heff_osat_cc(mayoct13,4)+Heff_osat_cc(mayoct13,5)+Heff_osat_cc(mayoct13,6),'Color',ruskea)
plot(tt(mayoct13),Heff_osat_mi(mayoct13,4)+Heff_osat_mi(mayoct13,5)+Heff_osat_mi(mayoct13,6),colors_m{3})
plot(tt(mayoct13),Heff_osat_te(mayoct13,4)+Heff_osat_te(mayoct13,5)+Heff_osat_te(mayoct13,6),'Color',[0.8 0 0.9])
plot(Obs_EC_vert_zml025(:,1),Obs_EC_vert_zml025(:,6),'k.','MarkerSize',7)
set(nelone,'Ylim',[0 220])
datetick('x','mmm')
set(gca,'xlim',xlims_heat)
ylblhs4 = ylabel('\itQ_{\rmSW,AML} \rm(W m^{-2})','fontsize',fntsz);
ylblposhs4 = get(ylblhs4,'Position');
ylblposhs4(1) = ylblposhs4(1)+3;
set(ylblhs4,'Position',ylblposhs4);
text(735375,195,'(d)','fontsize',fntsz)
set(gca,'fontsize',fntsz)

set(nelone,'Position',[0.09 0.04 0.78 0.21])
set(kolomone,'Position',[0.09 0.28 0.78 0.21])
set(kakonen,'Position',[0.09 0.52 0.78 0.21])
set(ykonen,'Position',[0.09 0.76 0.78 0.21])
set(gcf,'Color','w')

%}
%----- Atmospheric friction velocity in open water season 2013 ------
%%{

figure(652)
clf
set(gcf, 'Outerposition',[1000 250 700 400]) 

plot(tt(mayoct13),ustar_he(mayoct13),colors_m{1},'LineWidth',linw)
hold on
plot(tt(mayoct13),ustar_cc(mayoct13),'Color',ruskea,'LineWidth',linw)
plot(tt(mayoct13),ustar_mi(mayoct13),colors_m{3},'LineWidth',linw)
plot(tt(mayoct13),ustar_te(mayoct13),'Color',[0.8 0 0.9],'LineWidth',linw)
plot(Obs_EC_vert_zml025(:,1),Obs_EC_vert_zml025(:,9),'k.','MarkerSize',7)
datetick('x','mmm')
set(gca,'xlim',xlims_heat)
ylim([0 0.38])
ylblhu2 = ylabel('\itu_{\rm*a} \rm(m s^{-1})','FontSize',fntsz);
ylblposhu2 = get(ylblhu2,'Position');
ylblposhu2(1) = ylblposhu2(1)+0;
set(ylblhu2,'Position',ylblposhu2);


legeT1 = legend(leg_models{1},leg_models{2},leg_models{3},leg_models{4},'Meas.');
set(legeT1,'Orientation','Vertical','Box','Off','fontsize',fntsz)
set(legeT1,'Position',[0.90 0.75 0.04 0.04])
set(gca,'fontsize',fntsz)

legT_line = findobj(legeT1,'type','line');
xd1 = get(legT_line(1),'XData');
xd1(1) = xd1(1)+0.10;
set(legT_line(1),'XData',xd1)
xd4 = get(legT_line(4),'XData');
xd4(1) = xd4(1)+0.25;
xd4(2) = xd4(2)-0.05;
set(legT_line(2),'XData',xd4)
set(legT_line(4),'XData',xd4)
set(legT_line(6),'XData',xd4)
set(legT_line(8),'XData',xd4)
set(legT_line(10),'XData',xd4)

set(gca,'FontSize',fntsz)


set(gca,'Position',[0.10 0.08 0.77 0.88])
set(gcf,'Color','w')


% ---------- Summertime epilimnion thickness in 2013 ----------
%%{
[~,~,zept_he] = pclin(Tzt_he,zz);
[~,~,zept_cc] = pclin(Tzt_cc,zz);
[~,~,zept_mi] = pclin(Tzt_mi,zz);
[~,~,zept_te] = pclin(Tzt_te,zz);
zept_he = zept_he-dz;
zept_cc = zept_cc-dz;
zept_mi = zept_mi-dz;
zept_te = zept_te-dz;

xlims_ows13 = [datenum([2013 5 3]) datenum([2013 11 25])];
ss13_6_he = (find(tt>=xlims_ows13(1) & tt<=xlims_ows13(2) & zept_he'<6.5 & Tzt_he(1,:)'>4));
ss13_6_cc = (find(tt>=xlims_ows13(1) & tt<=xlims_ows13(2) & zept_cc'<6.5 & Tzt_cc(1,:)'>4));
ss13_6_mi = (find(tt>=xlims_ows13(1) & tt<=xlims_ows13(2) & zept_mi'<6.5 & Tzt_mi(1,:)'>4));
ss13_6_te = (find(tt>=xlims_ows13(1) & tt<=xlims_ows13(2) & zept_te'<6.5 & Tzt_te(1,:)'>4));

xlims_ows14 = [datenum([2014 4 16]) datenum([2014 11 22])];
ss14_6_he = (find(tt>=xlims_ows14(1) & tt<=xlims_ows14(2) & zept_he'<6.5 & Tzt_he(1,:)'>4));
ss14_6_cc = (find(tt>=xlims_ows14(1) & tt<=xlims_ows14(2) & zept_cc'<6.5 & Tzt_cc(1,:)'>4));
ss14_6_mi = (find(tt>=xlims_ows14(1) & tt<=xlims_ows14(2) & zept_mi'<6.5 & Tzt_mi(1,:)'>4));
ss14_6_te = (find(tt>=xlims_ows14(1) & tt<=xlims_ows14(2) & zept_te'<6.5 & Tzt_te(1,:)'>4));
ss14_6_he(end-2:end) = [];
ss14_6_cc(1:2) = [];
ss14_6_mi(1:2) = [];
ss14_6_te(1:2) = [];

figure(6520)
clf
set(gcf, 'Outerposition',[1000 550 625 300]) 
zep13 = subplot(121);
plot(tt(ss13_6_he),zept_he(ss13_6_he)+dz,colors_m{1},'LineWidth',linw)
hold on
plot(tt(ss13_6_cc),zept_cc(ss13_6_cc)+dz,'Color',ruskea,'LineWidth',linw)
plot(tt(ss13_6_mi),zept_mi(ss13_6_mi)+dz,colors_m{3},'LineWidth',linw)
plot(tt(ss13_6_te),zept_te(ss13_6_te)+dz,'Color',[0.8 0 0.9],'LineWidth',linw)
plot(tt(ss13_6_he),z_epi_obs(ss13_6_he),'k.','MarkerSize',7)
set(gca,'XTick',[datenum(2013,5,1),datenum(2013,6,1),datenum(2013,7,1),...
    datenum(2013,8,1),datenum(2013,9,1)])
set(gca,'XTickLabel',{'May 13';'';'Jul 13';'';'Sep 13'})
set(gca,'xlim',[datenum([2013 5 1]) datenum([2013 10 1])])
ylim([0 7.9])
axis ij
ylblhu2 = ylabel('\itz_{\rmepi} \rm(m)','fontsize',fntsz);
ylblposhu2 = get(ylblhu2,'Position');
ylblposhu2(1) = ylblposhu2(1)+4;
set(ylblhu2,'Position',ylblposhu2);
set(gca,'fontsize',fntsz)


zep14 = subplot(122);
plot(tt(ss14_6_he),zept_he(ss14_6_he)+dz,colors_m{1},'LineWidth',linw)
hold on
plot(tt(ss14_6_cc),zept_cc(ss14_6_cc)+dz,'Color',ruskea,'LineWidth',linw)
plot(tt(ss14_6_mi),zept_mi(ss14_6_mi)+dz,colors_m{3},'LineWidth',linw)
plot(tt(ss14_6_te),zept_te(ss14_6_te)+dz,'Color',[0.8 0 0.9],'LineWidth',linw)
plot(tt(ss14_6_he),z_epi_obs(ss14_6_he),'k.','MarkerSize',7)
set(gca,'XTick',[datenum(2014,6,1),datenum(2014,7,1),...
    datenum(2014,8,1),datenum(2014,9,1),datenum(2014,10,1)])
set(gca,'XTickLabel',{'Jun 14';'';'Aug 14';'';'Oct 14'})
set(gca,'xlim',[datenum([2014 5 1]) datenum([2014 10 1])])
ylim([0 7.9])
set(gca,'Yticklabel',[])
axis ij
set(gca,'fontsize',fntsz)

legeT1 = legend(leg_models{1},leg_models{2},leg_models{3},leg_models{4},'Obs.');
set(legeT1,'Orientation','Vertical','Box','Off','fontsize',fntsz)
set(legeT1,'Position',[0.90 0.67 0.04 0.04])
set(gca,'fontsize',fntsz)

legT_line = findobj(legeT1,'type','line');
xd1 = get(legT_line(1),'XData');
xd1(1) = xd1(1)+0.125;
set(legT_line(1),'XData',xd1)
xd4 = get(legT_line(4),'XData');
xd4(1) = xd4(1)+0.30;
xd4(2) = xd4(2)-0.05;
set(legT_line(2),'XData',xd4)
set(legT_line(4),'XData',xd4)
set(legT_line(6),'XData',xd4)
set(legT_line(8),'XData',xd4)
set(legT_line(10),'XData',xd4)

set(zep13,'Position',[0.08 0.13 0.40 0.82])
set(zep14,'Position',[0.48 0.13 0.40 0.82])
set(gcf,'Color','w')

klpois5 = plot([datenum([2014 5 1]),datenum([2014 5 1])],[-0.05,8.1],'w','LineWidth',10*linew,'Clipping','off');
klpois6 = plot([datenum([2014 5 1]),datenum([2014 5 1])],[0.05,7.8],'k--','LineWidth',0.5*linew,'Clipping','off');

%}

% -------------------- Performance metrics --------------------

% Output: matrix eval_X consisting of
% r2_X         Coefficient of determination
% rmses_X      Root-mean-square error
% NSEs_X       Nash--Sutcliffe efficiency
% Pbiass_X     Percent bias
% Nbiass_X     Normalized bias
% rmsenus_X    Normalized unbiased root-mean-square difference
% Nobs_X       Number of observations

%%{

%Gas transfer velocity
[r2s_k,rmses_k,NSEs_k,Pbiass_k,Nbiass_k,rmsenus_k,Biass_k] =...
    evalstat(3.6e5*[Obs_flux_zml025(Fobs,6) Obs_flux_zml025(Fobs,8) Obs_flux_zml025(Fobs,9) Obs_flux_zml025(Fobs,10)],...
    3.6e5*[k_he(Fmeas) k_cc(Fmeas) k_mi(Fmeas) k_te(Fmeas)]); % cm/h
Nobs_k = nansum([~isnan(Obs_flux_zml025(Fobs,6)) ~isnan(Obs_flux_zml025(Fobs,8)) ~isnan(Obs_flux_zml025(Fobs,9)) ~isnan(Obs_flux_zml025(Fobs,10))]);
eval_k = [r2s_k; rmses_k; NSEs_k; Pbiass_k; Nbiass_k; rmsenus_k; Nobs_k];

%Air-water CO2 flux
[r2s_F,rmses_F,NSEs_F,Pbiass_F,Nbiass_F,rmsenus_F,Biass_F] =...
    evalstat(1/(86.4*44.01)*[Obs_flux_zml025(Fobs,11) Obs_flux_zml025(Fobs,13) Obs_flux_zml025(Fobs,14) Obs_flux_zml025(Fobs,15)],...
    1/(86.4*44.01)*[surfaceflux_he(Fmeas); surfaceflux_cc(Fmeas); surfaceflux_mi(Fmeas); surfaceflux_te(Fmeas)]'); %mumol m-2 s-1
Nobs_F = nansum([~isnan(Obs_flux_zml025(Fobs,11)) ~isnan(Obs_flux_zml025(Fobs,13)) ~isnan(Obs_flux_zml025(Fobs,14)) ~isnan(Obs_flux_zml025(Fobs,15))]);
eval_F = [r2s_F; rmses_F; NSEs_F; Pbiass_F; Nbiass_F; rmsenus_F; Nobs_F];

%Effective surface heat flux
[r2s_Heff,rmses_Heff,NSEs_Heff,Pbiass_Heff,Nbiass_Heff,rmsenus_Heff,Biass_Heff] =...
    evalstat([Obs_flux_zml025(:,5) Obs_flux_zml025(:,5) Obs_flux_zml025(:,5) Obs_flux_zml025(:,5)],...
    [Heff_he(Fmeas) Heff_cc(Fmeas) Heff_mi(Fmeas) Heff_te(Fmeas)]);
Nobs_Heff = nansum([~isnan(Obs_flux_zml025(:,5)) ~isnan(Obs_flux_zml025(:,5)) ~isnan(Obs_flux_zml025(:,5)) ~isnan(Obs_flux_zml025(:,5))]);
eval_Heff = [r2s_Heff; rmses_Heff; NSEs_Heff; Pbiass_Heff; Nbiass_Heff; rmsenus_Heff; Nobs_Heff];

%Sensible heat flux
[r2s_SH,rmses_SH,NSEs_SH,Pbiass_SH,Nbiass_SH,rmsenus_SH,Biass_SH] =...
    evalstat(-[Obs_EC_vert_zml025(:,3) Obs_EC_vert_zml025(:,3) Obs_EC_vert_zml025(:,3) Obs_EC_vert_zml025(:,3)],...
    [Heff_osat_he(Fmeas,1) Heff_osat_cc(Fmeas,1) Heff_osat_mi(Fmeas,1) Heff_osat_te(Fmeas,1)]);
Nobs_SH = nansum([~isnan(Obs_EC_vert_zml025(:,3)) ~isnan(Obs_EC_vert_zml025(:,3)) ~isnan(Obs_EC_vert_zml025(:,3)) ~isnan(Obs_EC_vert_zml025(:,3))]);
eval_SH = [r2s_SH; rmses_SH; NSEs_SH; Pbiass_SH; Nbiass_SH; rmsenus_SH; Nobs_SH];

%Latent heat flux
[r2s_LH,rmses_LH,NSEs_LH,Pbiass_LH,Nbiass_LH,rmsenus_LH,Biass_LH] =...
    evalstat(-[Obs_EC_vert_zml025(:,4) Obs_EC_vert_zml025(:,4) Obs_EC_vert_zml025(:,4) Obs_EC_vert_zml025(:,4)],...
    [Heff_osat_he(Fmeas,2) Heff_osat_cc(Fmeas,2) Heff_osat_mi(Fmeas,2) Heff_osat_te(Fmeas,2)]);
Nobs_LH = nansum([~isnan(Obs_EC_vert_zml025(:,4)) ~isnan(Obs_EC_vert_zml025(:,4)) ~isnan(Obs_EC_vert_zml025(:,4)) ~isnan(Obs_EC_vert_zml025(:,4))]);
eval_LH = [r2s_LH; rmses_LH; NSEs_LH; Pbiass_LH; Nbiass_LH; rmsenus_LH; Nobs_LH];

%Long-wave radiative heat flux
[r2s_Qlw,rmses_Qlw,NSEs_Qlw,Pbiass_Qlw,Nbiass_Qlw,rmsenus_Qlw,Biass_Qlw] =...
    evalstat([Obs_EC_vert_zml025(:,5) Obs_EC_vert_zml025(:,5) Obs_EC_vert_zml025(:,5) Obs_EC_vert_zml025(:,5)],...
    [Heff_osat_he(Fmeas,3) Heff_osat_cc(Fmeas,3) Heff_osat_mi(Fmeas,3) Heff_osat_te(Fmeas,3)]);
Nobs_Qlw = nansum([~isnan(Obs_EC_vert_zml025(:,5)) ~isnan(Obs_EC_vert_zml025(:,5)) ~isnan(Obs_EC_vert_zml025(:,5)) ~isnan(Obs_EC_vert_zml025(:,5))]);
eval_Qlw = [r2s_Qlw; rmses_Qlw; NSEs_Qlw; Pbiass_Qlw; Nbiass_Qlw; rmsenus_Qlw; Nobs_Qlw];

%Short-wave radiative heat flux trapped in the actively mixing layer
[r2s_Qsw_epi,rmses_Qsw_epi,NSEs_Qsw_epi,Pbiass_Qsw_epi,Nbiass_Qsw_epi,rmsenus_Qsw_epi,Biass_Qsw_epi] =...
    evalstat([Obs_EC_vert_zml025(:,6) Obs_EC_vert_zml025(:,6) Obs_EC_vert_zml025(:,6) Obs_EC_vert_zml025(:,6)],...
    [sum(Heff_osat_he(Fmeas,4:6),2) sum(Heff_osat_cc(Fmeas,4:6),2) sum(Heff_osat_mi(Fmeas,4:6),2) sum(Heff_osat_te(Fmeas,4:6),2)]);
Nobs_Qsw_epi = nansum([~isnan(Obs_EC_vert_zml025(:,6)) ~isnan(Obs_EC_vert_zml025(:,6)) ~isnan(Obs_EC_vert_zml025(:,6)) ~isnan(Obs_EC_vert_zml025(:,6))]);
eval_Qsw_epi = [r2s_Qsw_epi; rmses_Qsw_epi; NSEs_Qsw_epi; Pbiass_Qsw_epi; Nbiass_Qsw_epi; rmsenus_Qsw_epi; Nobs_Qsw_epi];

%Atmospheric friction velocity
[r2s_ustar,rmses_ustar,NSEs_ustar,Pbiass_ustar,Nbiass_ustar,rmsenus_ustar,Biass_ustar] =...
    evalstat([Obs_EC_vert_zml025(:,9) Obs_EC_vert_zml025(:,9) Obs_EC_vert_zml025(:,9) Obs_EC_vert_zml025(:,9)],...
    [ustar_he(Fmeas,1) ustar_cc(Fmeas,1) ustar_mi(Fmeas,1) ustar_te(Fmeas,1)]);
Nobs_ustar = nansum([~isnan(Obs_EC_vert_zml025(:,9)) ~isnan(Obs_EC_vert_zml025(:,9)) ~isnan(Obs_EC_vert_zml025(:,9)) ~isnan(Obs_EC_vert_zml025(:,9))]);
eval_ustar = [r2s_ustar; rmses_ustar; NSEs_ustar; Pbiass_ustar; Nbiass_ustar; rmsenus_ustar; Nobs_ustar];

%}
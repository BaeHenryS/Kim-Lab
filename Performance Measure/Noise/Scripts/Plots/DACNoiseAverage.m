% DAC Noise Averaging 
% Used Kim-Lab\Performance Measure\Noise\2022_07_25\Noise20220725_1_Workspace.mat
% 

dacv0_100k_vb_001_mod = dacv0_100k_vb_001;


dacv0_100k_vb_001_mod(1:10,:) = [];

x_100k_mod = x_100k;

x_100k_mod(:,1:10) = [];

x_100k_mod = reshape(x_100k_mod, [],1);




noiseAverage_100k = figure;

figure(noiseAverage_100k)


for i = 1:21
    dacv0_100k_vb_001_avg(i) = mean(dacv0_100k_vb_001_mod(:,i));

end


plot(linspace(-10,10, 21), dacv0_100k_vb_001_avg * 10^9, 'LineWidth',3)


title('Average DAC Noise Value from -10V - 10V, 0 - 100kHz','Interpreter','latex','FontSize',24)
xlabel('Voltage $$(V)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)







noiseAverage_195 = figure;

figure(noiseAverage_195)



dacv0_195_vb_001_mod = dacv0_195_vb_001;


dacv0_195_vb_001_mod(1:50,:) = [];

x_195_mod = x_195;
x_195_mod(:,1:50) = [];
x_195_mod = reshape(x_195_mod, [],1);



for i = 1:21
    dacv0_195_vb_001_avg(i) = mean(dacv0_195_vb_001_mod(:,i));

end


plot(linspace(-10,10, 21), dacv0_195_vb_001_avg * 10^9, 'LineWidth',3)


title('Average DAC Noise Value from -10V - 10V, 25 - 195Hz','Interpreter','latex','FontSize',24)
xlabel('Voltage $$(V)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)



%{
dacv0_195_vb_001_combined = (dacv0_195_vb_001 + dacv0_195_vb_002 + dacv0_195_vb_003 + dacv0_195_vb_004 + dacv0_195_vb_005 +dacv0_195_vb_006;


noiseAverage_combined_195 = figure;

figure(noiseAverage_combined_195)



dacv0_195_vb_001_combined_mod = dacv0_195_vb_001_combined;


dacv0_195_vb_001_combined_mod(1:100,:) = [];

x_195_mod = x_195;
x_195_mod(:,1:100) = [];
x_195_mod = reshape(x_195_mod, [],1);



for i = 1:21
    dacv0_195_vb_001_combined_avg(i) = mean(dacv0_195_vb_001_combined_mod(:,i));

end


plot(linspace(-10,10, 21), dacv0_195_vb_001_combined_avg * 10^9)


title('DAC Noise Measurement from -10V - 10V, 0 - 100kHz','Interpreter','latex','FontSize',24)
xlabel('Voltage $$(V)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)


%}

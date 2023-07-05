% Noise Measurement Plot at -10V-10V Output with 1/f Fit , 0 - 195Hz
% Used Kim-Lab\Performance Measure\Noise\2022_07_25\Noise20220725_1_Workspace.mat
% 

oneoverx_fit_195 = figure;
figure(oneoverx_fit_195)


dacv0_195_vb_001_mod = dacv0_195_vb_001;


dacv0_195_vb_001_mod(1:10,:) = [];

x_195_mod = x_195;

x_195_mod(:,1:10) = [];

x_195_mod = reshape(x_195_mod, [],1);


myfit = fittype('a + b/x + c/x^2 + d/x^3',...
    'dependent',{'y'},'independent',{'x'},...
    'coefficients',{'a','b','c','d'});

f = fit(x_195_mod, dacv0_195_vb_001_mod(:,1), myfit);
plot(x_195_mod, dacv0_195_vb_001_mod(:,1))
hold on
semilogy(x_195_mod, f(x_195_mod))

title('Noise Measurement Plot at -10V Output with 1/f Fit , 0 - 195Hz','Interpreter','latex','FontSize',24)
xlabel('Frequency $$(Hz)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)

hold off





oneoverx_fit_all_195 = figure;
figure(oneoverx_fit_all_195)


for i = 1:21
    f = fit(x_195_mod, dacv0_195_vb_001_mod(:,i), myfit);
    %plot(x_195_mod, dacv0_195_vb_001_mod(:,1))
    %hold on
    semilogy(x_195_mod, f(x_195_mod))
    hold on
end

title('Noise Measurement Plot at -10V - 10V Output with 1/f Fit , 0 - 195Hz','Interpreter','latex','FontSize',24)
xlabel('Frequency $$(Hz)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)

hold off




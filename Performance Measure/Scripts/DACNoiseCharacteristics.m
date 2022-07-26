for i = 1:21
    dacv0_100k_vb_001_avg(i) = mean(dacv0_100k_vb_001_mod(:,i));

end


plot(linspace(-10,10, 21), dacv0_100k_vb_001_avg * 10^9)


title('DAC Noise Measurement from -10V - 10V, 0 - 100kHz','Interpreter','latex','FontSize',24)
xlabel('Voltage $$(V)$$','Interpreter','latex','FontSize',16)
ylabel('Noise $$(nV/\sqrt{Hz})$$','Interpreter','latex','FontSize',16)
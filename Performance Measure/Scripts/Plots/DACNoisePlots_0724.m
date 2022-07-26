

dacv0_195_vb_001_mod = dacv0_195_vb_001;


dacv0_195_vb_001_mod(1:10,:) = [];

x_195_mod = x_195;

x_195_mod(:,1:10) = [];

x_195_mod = reshape(x_195_mod, [],1);


myfit = fittype('a + b/x',...
    'dependent',{'y'},'independent',{'x'},...
    'coefficients',{'a','b'});

f = fit(x_195_mod, dacv0_195_vb_001_mod(:,10), myfit);
plot(x_195_mod, dacv0_195_vb_001_mod(:,10))
hold on
semilogy(x_195_mod, f(x_195_mod))


%{
for i = 1:21
    f = fit(x_195_mod, dacv0_195_vb_001_mod(:,i), myfit);
    %plot(x_195_mod, dacv0_195_vb_001_mod(:,1))
    %hold on
    semilogy(x_195_mod, f(x_195_mod))
    hold on
end



dacv0_100k_vb_001_mod = dacv0_100k_vb_001;


dacv0_100k_vb_001_mod(1:10,:) = [];

x_100k_mod = x_100k;

x_100k_mod(:,1:10) = [];

x_100k_mod = reshape(x_100k_mod, [],1);



for i = 1:21
   plot(x_100k_mod, dacv0_100k_vb_001_mod(:,i), 'DisplayName',string(i))
   hold on
end

%colormap(prism(21))
%}

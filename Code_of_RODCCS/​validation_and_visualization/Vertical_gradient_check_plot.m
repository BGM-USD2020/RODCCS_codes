Vertical_gradient_check_plot_temp;
cd 'E:\y-cc\RODECS\final_data_v4\qc7_gradient_figure';
Vertical_gradient_check_plot_salt;
cd 'E:\y-cc\RODECS\final_data_v4\qc7_gradient_figure';
Vertical_gradient_check_plot_do;
cd 'E:\y-cc\RODECS\final_data_v4\qc7_gradient_figure';
Vertical_gradient_check_plot_si;
cd 'E:\y-cc\RODECS\final_data_v4\qc7_gradient_figure';
Vertical_gradient_check_plot_no3;
cd 'E:\y-cc\RODECS\final_data_v4\qc7_gradient_figure';
Vertical_gradient_check_plot_po4;
cd 'E:\y-cc\RODECS\final_data_v4\qc7_gradient_figure';
%%
f = figure('Units','centimeters',...
            'PaperType', 'A4',...
            'PaperOrientation','landscape',...
            'Position',[1 5 28 6],...
            'PaperPosition',[1 5 6 6],...
            'PaperUnits','centimeters');
h1 = scatter(nan,nan,'ko','filled');
hold on;
h2 = scatter(nan,nan,'bo','filled');
hold on;
h3 = scatter(nan,nan,'ro','filled');
hold on;
h4 = scatter(nan,nan,'mo','filled');
hold on;
h5 = plot(nan,nan,'bo');
hold on;
h6 = plot(nan,nan,'ro');
hold on;
h7 = plot(nan,nan,'mo');
hold on;
h8 = plot(nan,nan,'r--','LineWidth',2);
legend([h1,h2,h3,h4,h5,h6,h7,h8],'Original data','Passed data','Failed data',...
    'Irrelevant data','Passed data point','Failed data point','Irrelevant data point','MGV',...
    'Location','South','Box','off','NumColumns',4); 
axis off;
set(gca,'FontName','Times New Roman','FontSize',10,'FontWeight','bold','LineWidth', 2);
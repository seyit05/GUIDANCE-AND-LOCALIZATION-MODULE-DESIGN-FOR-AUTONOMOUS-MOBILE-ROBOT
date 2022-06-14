delete(instrfindall);
clear
clc
serialPort = 'COM6';                 
judulGrafik = 'Logger Data Serial';  
xLabel = 'Time';           
yLabel = 'Data';                     
plotGrid = 'on';                    
min = -4000;                            
max = -3000;                              
lebarScroll = 11;                  
delay = 0.01;                       
waktu = 0;
data = 0;
cacah = 0;
plotGraph = plot(waktu,data,...
              'LineWidth',1.5,...
              'MarkerSize',3,...
              'MarkerEdgeColor','k',...
              'MarkerFaceColor','r');             
title(judulGrafik,'FontSize',15);
xlabel(xLabel,'FontSize',12);
ylabel(yLabel,'FontSize',12);
axis([0 11 min max]);
grid(plotGrid);  
s=serial('COM6','BaudRate',9600); 
disp('Tutup jendela grafik untuk mengakhiri logger');
fopen(s);
tic                            
while ishandle(plotGraph)       
  nilaiInput = fscanf(s,'%d'); 
  if(~isempty(nilaiInput) && isfloat(nilaiInput))          
    cacah = cacah + 1;    
    waktu(cacah) = toc;           
    data(cacah) = nilaiInput(1);        
    if(lebarScroll > 0)
    set(plotGraph,'XData',waktu(waktu > waktu(cacah)-lebarScroll),'YData',data(waktu > waktu(cacah)-lebarScroll));
    axis([waktu(cacah)-lebarScroll waktu(cacah) min max]);
    else
    set(plotGraph,'XData',waktu,'YData',data);
    axis([0 waktu(cacah) min max]);
    end
      pause(delay);
  end
end
fclose(s);
clear all; 
disp('Logger berakhir...');
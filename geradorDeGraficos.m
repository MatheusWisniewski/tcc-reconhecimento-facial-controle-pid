subplot(3,1,1)
gerarGraficoAPartirDoArquivo('./Results/Luis Viola PID/LuminanciaS.txt', 'b', 37)
title('Lumin�ncia S')
axis([0 150 15 60])
subplot(3,1,2)
gerarGraficoAPartirDoArquivo('./Results/Luis Viola PID/LuminanciaNE.txt', 'b', 42)
title('Lumin�ncia NE')
axis([0 150 15 60])
subplot(3,1,3)
gerarGraficoAPartirDoArquivo('./Results/Luis Viola PID/LuminanciaNW.txt', 'b', 42)
title('Lumin�ncia NW')
axis([0 150 15 60])
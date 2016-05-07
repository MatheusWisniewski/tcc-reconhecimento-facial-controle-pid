function [idDaPessoa, temRostoNaImagem, luminanciaS, luminanciaNE, luminanciaNW] = ...
    fazerReconhecimentoEDeteccaoDeLuminanciaDaImagem (imagemInicialDaCamera, ...
        MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS)
    
    [imagemCortada, temRostoNaImagem] = ...
        detectarRostoPorSegmentacao(imagemInicialDaCamera, ...
        MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS);

    imagemCortadaGray = rgb2gray(imagemCortada);

    [taxaDeCerteza, idDaPessoa] = ...
        reconhecerQuemEstaNaImagem(imagemCortadaGray);

    imprimirResultadosDoReconhecimento(taxaDeCerteza, idDaPessoa, temRostoNaImagem);

    if temRostoNaImagem

        [luminanciaS, luminanciaNE, luminanciaNW] = ...
            detectarLuminanciaDasTresDivisoesDoRosto(imagemCortada, MOSTRAR_RESULTADOS_FINAIS);

        imprimirLuminancias(luminanciaS, luminanciaNE, luminanciaNW);
    else
        luminanciaS  = 0;
        luminanciaNE = 0;
        luminanciaNW = 0;
        
        disp(' '); disp(' '); disp(' '); 
    end

end



function [ imagemCortadaEm80por60RGB, temRostoNaImagem ]...
    = detectarRostoPorSegmentacao...
    (MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS, USAR_WEBCAM_INTEGRADA)

    switch nargin
        case 0
            MOSTRAR_RESULTADOS_INTERMEDIARIOS = 0;
            MOSTRAR_RESULTADOS_FINAIS = 0;
            USAR_WEBCAM_INTEGRADA = 0;
        case 1
            MOSTRAR_RESULTADOS_FINAIS = 1;
            USAR_WEBCAM_INTEGRADA = 0;
        case 2
            USAR_WEBCAM_INTEGRADA = 0;
    end
    
    if(USAR_WEBCAM_INTEGRADA)
        [imagemInicialDaCamera] = tirarFotoComWebcam(1);
    else
        [imagemInicialDaCamera] = tirarFotoComWebcam(2);
    end

    if max(imagemInicialDaCamera) == 0
        
        temRostoNaImagem = 0;
        imagemCortadaEm80por60RGB = -1;
        
    else
    
        imagemInicialEmRGB=double(imagemInicialDaCamera);

        [w, h]=size(imagemInicialEmRGB(:,:,1));
        imagemAposReconhecimento = zeros(w,h,3);

        imagemPele = segmentacaoPorPele(imagemInicialEmRGB);

        imagemDeteccaoDeBordas = edge(imagemPele, 'canny');
        imagemDeteccaoDeBordasDilatada = ...
            dilatacaoComQuadradoVariavel(imagemDeteccaoDeBordas, 3);
        
        imagemPeleComDeteccaoDeBordas = imagemPele - imagemDeteccaoDeBordasDilatada;
        
        imagemBinariaPosTratamento = ...
            sequenciaDeTratamentosDeImagem (imagemPeleComDeteccaoDeBordas, ...
                                            MOSTRAR_RESULTADOS_INTERMEDIARIOS);

        if contemCandidatosARostoNaImagem(imagemBinariaPosTratamento)
            
            [imagemBinariaContendoApenasRosto, temRostoNaImagem] = ...
                deixarApenasRostoNaImagem(imagemBinariaPosTratamento);
            
            if temRostoNaImagem
            
                for color=1:3
                    imagemAposReconhecimento(:,:,color)=imagemInicialEmRGB(:,:,color).*...
                        imagemBinariaContendoApenasRosto;   
                end

                [BoundingBox, plotDaElipse] = ...
                    encontrarRetanguloEElipseNoRosto(imagemBinariaContendoApenasRosto);

                if MOSTRAR_RESULTADOS_FINAIS == 1
                    plotarResultadosFinais(imagemInicialDaCamera, imagemAposReconhecimento, ...
                        plotDaElipse, BoundingBox);
                end

                imagemCortada = imcrop(imagemInicialDaCamera, BoundingBox);

                imagemCortadaEm80por60RGB = imresize(imagemCortada, [80 60]);
            
            else
                
                temRostoNaImagem = 0;
                imagemCortadaEm80por60RGB = imresize(imagemInicialDaCamera, [80 60]);
                
            end
                
        else
            
            temRostoNaImagem = 0;
            imagemCortadaEm80por60RGB = imresize(imagemInicialDaCamera, [80 60]);
        end
  
        
    end

end

function [ imagemContendoApenasRosto, temRostoNaImagem ] = ...
    deixarApenasRostoNaImagem( imagemBinariaComVariosObjetos, MOSTRAR_RESULTADOS_INTERMEDIARIOS )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    [height, width] = size(imagemBinariaComVariosObjetos);

    [imagemComLabel, numeroDeObjetos] = bwlabel(imagemBinariaComVariosObjetos, 8);
    blobMeasurements = regionprops(imagemComLabel, imagemBinariaComVariosObjetos, ...
        'Area', 'Eccentricity', 'Orientation');
    
    
    
    areas = [blobMeasurements.Area];
    eccentricities = [blobMeasurements.Eccentricity];
    orientations = [blobMeasurements.Orientation];
    
    idDoMaiorComFormatoDeRosto = 0;
    
    for i=1:numeroDeObjetos
        
        if  areas(i) >= areas(idDoMaiorComFormatoDeRosto + 1*(~idDoMaiorComFormatoDeRosto)) && ...
                eccentricities(i) < 0.85
%                 ~estaEntre(orientations(i),-65,65) && ...
%                 eccentricities(i) < 0.85
                
            
            idDoMaiorComFormatoDeRosto = i;
            
            
        end
    end
    
    for i=1:numeroDeObjetos
        
        for h=1:height
               for w=1:width
                  if imagemComLabel(h,w) ~= idDoMaiorComFormatoDeRosto
                      imagemBinariaComVariosObjetos(h,w) = 0;
                  end
               end
        end
        
    end
    
    if idDoMaiorComFormatoDeRosto > 0 
        if areas(idDoMaiorComFormatoDeRosto) > 5000
            temRostoNaImagem = 1;
            imagemContendoApenasRosto = imagemBinariaComVariosObjetos;
        else
            temRostoNaImagem = 0;
            imagemContendoApenasRosto = 0;
        end
    else
        temRostoNaImagem = 0;
        imagemContendoApenasRosto = 0;
    end
    
    if MOSTRAR_RESULTADOS_INTERMEDIARIOS
        figure
       
        subplot(1,2,1)
        imshow(label2rgb(imagemComLabel, 'hsv', 'k', 'shuffle'))
        title('Blocos de pixels encontrados')
        
        subplot(1,2,2)
        imshow(label2rgb(imagemContendoApenasRosto, 'hsv', 'k', 'shuffle'))
        title('Apenas rosto')
    end
    
end


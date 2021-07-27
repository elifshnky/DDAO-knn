    function [ uzaklik_dizisi] = Uzaklik_Hesapla( baginti_no,veri_seti,yeni_veri )

        if (baginti_no==1)
            uzaklik_dizisi= Baginti_Oklit(veri_seti,yeni_veri);
            elseif (baginti_no==2)
            uzaklik_dizisi= Baginti_Manhattan(veri_seti,yeni_veri);
            else

        end

    end


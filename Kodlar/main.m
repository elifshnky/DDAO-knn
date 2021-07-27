% 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49
komsular = [3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49]
uzaklik_bagintisi_no=1;

Nvar = 5; %dimension
MaxIt= 100;
Npop=3; % Population Size

VarLength = [1 Nvar];   % solution vector size
L_limit = 0;          % Lower limit of solution vector
U_limit = 1;           % Upper limit of solution vector
run = 50;

hata_deger_dknn=zeros(1,run);
hata_deger_sknn=zeros(1,run);

% [bestSolution,  bestFitness]=DDAO(komsu_sayisi, uzaklik_bagintisi_no,Npop,MaxIt,U_limit,L_limit,VarLength);



for komsu_sayisi=1:run
    if any(komsular(:)==komsu_sayisi)
        Verileri_Oku();
        
        [bestSolution,  bestFitness]=DDAO(komsu_sayisi, uzaklik_bagintisi_no,Npop,MaxIt,U_limit,L_limit,VarLength);
        
        komsu_sayisi
        
        deterministik_knn_yuzde_hata = k_nn(komsu_sayisi,uzaklik_bagintisi_no);
        sezgisel_knn_yuzde_hata = Sezgisel_k_nn(komsu_sayisi,uzaklik_bagintisi_no,bestSolution);
        fprintf('knn icin k %d komsu say için hata deg:%s\n',komsu_sayisi,num2str(deterministik_knn_yuzde_hata));
        fprintf('sezgisel knn icin k %d komsu say için hata deg:%s\n',komsu_sayisi,num2str(sezgisel_knn_yuzde_hata));
        %     disp(komsu_sayisi);
        %     disp(deterministik_knn_yuzde_hata);
        %     disp(sezgisel_knn_yuzde_hata);
        if(deterministik_knn_yuzde_hata~=0)
            hata_deger_dknn(komsu_sayisi)=deterministik_knn_yuzde_hata;
            hata_deger_sknn(komsu_sayisi)=sezgisel_knn_yuzde_hata;
        end

    end
    
    xlswrite( 'sonuclar.xlsx', hata_deger_dknn, 'dknn-MIt_100');
    xlswrite( 'sonuclar.xlsx', hata_deger_sknn, 'sknn-MIt_100');

end
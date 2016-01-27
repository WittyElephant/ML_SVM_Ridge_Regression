function [AUC,AUPRC] = plotMetricsV2(yPredict, yReal, confidences)

FPR = zeros(10, 1);
TPR = zeros(10, 1);
Recall = zeros(10, 1);
Precision = zeros(10, 1);

for i = 1:10 %for 10 thresholds
    Tp = zeros(1, size(yReal,1));
    Fp = zeros(1, size(yReal,1));
    notClassified = zeros(1, size(yReal,1));
    threshold = .45 +.05*i;
    firstIndex = 1;
    lastIndex = 19;
   for c = 1:10 %got to match witht he confidences
       
       for k = firstIndex:lastIndex
          if(yPredict(k) == yReal(k))%possible TP
               if(confidences(yPredict(k),c) >= threshold)
                  Tp(k) = 1;
               else
                  notClassified(k) = 1;
  
               end
          elseif(yPredict(k) ~= yReal(k)) %possible Fp
               if(confidences(yPredict(k),c) >= threshold)
                  Fp(k) = 1;
               else
                   notClassified(k) = 1;
               end

          end
       end
       if c == 2 || c == 4 || c == 6 || c== 8 
        firstIndex = lastIndex+1;
        lastIndex = lastIndex+20;
       else
        firstIndex = lastIndex+1;
        lastIndex = lastIndex+19;
       
       end
   end
   


Precision(i) = sum(Tp)/(sum(Fp)+sum(Tp));
Recall(i) = sum(Tp)/(size(yReal,1));
FPR(i) = sum(Fp)/(size(yReal,1));
TPR(i) = sum(Tp)/(size(yReal,1));
end


%      disp('FPR');
%      disp(FPR);    %debugger
%      disp('Tn');
%      disp(Tn);
%      disp('FPR');
%      disp(FPR);
%      disp('recall');
%      disp(recall);

%       [~, I] = sort(FPR);
  %  plot(sort(FPR),recall(I));
  figure
    plot(FPR,TPR);
%     disp(recall(I));
    %display(size(FPR,2));
    %display(size(recall,2));
%     AUC = trapz(sort(FPR),recall(I));
    AUC = trapz(FPR,TPR);
%     disp(AUC(i));
% disp('end AUC');
title('ROC Curve')
xlabel('FPR')
ylabel('TPR')
axis([0 1 0 1]);


%-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
figure
plot(Recall,Precision);
AUPRC = trapz(Recall,Precision);

title('PR Curve')
xlabel('Recall')
ylabel('Precision')
axis([0 1 0 1]);


end
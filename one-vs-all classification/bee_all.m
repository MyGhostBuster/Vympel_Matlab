%Initialization
clear ; close all; clc

%import data
load('train.mat');

p=[1,2,3,4,5,6,10,11,12,13,15,16,17,18,19,20,21,22,23];
for t=1:length(p)
    k=a(:,p(t));
    m=size(k,1);
    count=0;
    for i=1:m
         if k(i)>10000
             count=count+1;
             for j=(i+1):m
                 if k(j)==k(i)
                     k(j)=count;
                 end
             end
             k(i)=count;
         end
    end
    a(:,p(t))=k;
end

%data preparation
%ac=0;
%for tre=1:100
    
    %numb=randi([8 62],1,1);
    %st=randi([1 62],1,numb(1,1));
    st=[7,8,23:25,28:33,38,43:45,48:51,53:55,57:60,62];
    X=a(1:39593,st);
    y=a(1:39593,63);

    %Normalize
    [X, mu, sigma] = featureNormalize(X);  % Normalize
    %X = [ones(m, 1), X];                   % Add Ones

    %Preparation X
    [n,l]=size(X);
    for i=1:n
        for j=1:l
            if isnan(X(i,j))
                X(i,j)=0;
            end
        end
    end

%loading test sample
    load('test.mat');
    X_test=b(:,st);
    id=id;

    % Map X_test and normalize (using mu and sigma)
    X_test = bsxfun(@minus, X_test, mu);
    X_test = bsxfun(@rdivide, X_test, sigma);
    %X_test = [ones(size(X_test, 1), 1), X_test]; 


    %Preparation X_test
    [n,l]=size(X_test);
    for i=1:n
        for j=1:l
            if isnan(X_test(i,j))
                X_test(i,j)=0;
            end
        end
    end

    num_labels = 7;

    lambda = 10;
    [all_theta] = oneVsAll(X, y, num_labels, lambda);
    
    pred = predictOneVsAll(all_theta, X_test);
    pred1 = predictOneVsAll(all_theta, X);

    %if mean(double(pred1 == y)) * 100>ac
        ac=mean(double(pred1 == y)) * 100;
     %   tac=st;
    %end
%end    

   exp_res=[id';pred'];
   exp_res=exp_res';

   csvwrite('sol.csv',exp_res);

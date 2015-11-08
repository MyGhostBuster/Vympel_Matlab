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
st=[7,31,33,36,45,55,57:60];
%stt=zeros(63);
%for RR=1:length(st1)
   % st=RR;
    X=a(1:50000,st);
    y=a(1:50000,63);
    X_val=a(39593:39593,st);
    y_val=a(39593:39593,63);

    % m = Number of examples
    m = size(X, 1);

    %Normalize
    [X, mu, sigma] = featureNormalize(X);  % Normalize
    X = [ones(m, 1), X];                   % Add Ones
    
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
    X_test = [ones(size(X_test, 1), 1), X_test]; 

    %Preparation X_test
    [n,l]=size(X_test);
    for i=1:n
        for j=1:l
            if isnan(X_test(i,j))
                X_test(i,j)=0;
            end
        end
    end

    % Map X_val and normalize (using mu and sigma)
    X_val = bsxfun(@minus, X_val, mu);
    X_val = bsxfun(@rdivide, X_val, sigma);
    X_val = [ones(size(X_val, 1), 1), X_val];           % Add Ones

    %Validation for Selecting Lambda
    [lambda_vec, error_train, error_val]=validationCurve(X, y, X_val, y_val);

    close all;

    fprintf('lambda\t\tTrain Error\tValidation Error\n');
    for i = 1:length(lambda_vec)
    	fprintf(' %f\t%f\t%f\n', ...
                lambda_vec(i), error_train(i), error_val(i));
        %stt(RR)=error_train(i);    
    end

%end
%fprintf('Program paused. Press enter to continue.\n');
%    pause;
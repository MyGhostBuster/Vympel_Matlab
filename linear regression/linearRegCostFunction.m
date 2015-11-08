function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%

% class
%y_p=X*theta;
%res=[1,2,3,4,5,6];
%m=size(y_p,1);
%n=length(res);
%for i=1:m
    %min=(y_p(i)-res(1))^2;
    %minc=res(1);
    %for j=2:n
       % if (y_p(i)-res(j))^2<min
        %    min=(y_p(i)-res(j))^2;
         %   minc=res(j);
        %end
    %end
    %y_p(i)=minc;
%end

%diff=zeros(size(y));

%standart error
%for h=1:size(y,1)
%    if y_p(h)==y(h)
%        diff(h)=1;
%    end
%end

%J=1-(sum(diff)/size(y,1));

J = sum((X*theta-y).^2)/(2*m)+lambda*sum(theta(2:end).^2)/(2*m);
grad(1)=((X*theta-y))'*X(:,1)./m;
grad(2:end)=((X*theta-y))'*X(:,2:end)./m+theta(2:end)'.*lambda./m;










% =========================================================================



end

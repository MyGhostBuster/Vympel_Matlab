lambda=0;
theta=trainLinearReg(X,y,lambda);
y_pred=zeros(size(id));
y_pred=X_test*theta;

y_p=y_pred;
res=[0,1,2,3,4,5,6];
m=size(y_p,1);
n=length(res);
for i=1:m
    min=(y_p(i)-res(1))^2;
    minc=res(1);
    for j=2:n
        if (y_p(i)-res(j))^2<min
            min=(y_p(i)-res(j))^2;
            minc=res(j);
        end
    end
    y_p(i)=minc;
end
matr=[y_pred';y_p'];
matr=matr';

exp_res=[id';y_p'];
exp_res=exp_res';

csvwrite('sol.csv',exp_res);







function H1 = least_Square_Correlation(f, t)
[x, y] = meshgrid(51:100,51:100);   %window size
%size of the images in the window
actual = f(30:79, 60:109);
t = t(30:79, 60:109);
% x and y gradients multiplied with the window size
[fx, fy] = gradient(actual,2);
%Intialising the parameters
x2=x.^2; y2=y.^2;
xy=x.*y; fab=fx.*fy;
fa2=fx.^2; fb2=fy.^2;

% for "fx" "gradient" in Inhomogeneous system of equations 
A =sum(sum(fx));
sizeX = size(x)
sizeFx = size(fx)
fa=sum(sum(fx.*x));
fxY=sum(sum(fx.*y));

%for "fY" "gradient" in Inhomogeneous system of equations
fY=sum(sum(fy));
fyX=sum(sum(fy.*x));
fyY=sum(sum(fy.*y));

% "fx2"  "gradient" in Inhomogeneous system of equations
fx_square=sum(sum(fa2));
fx2x2=sum(sum(fa2.*x2));
fx2xy=sum(sum(fa2.*xy));
fx2y2=sum(sum(fa2.*y2));
fx2X=sum(sum(fa2.*x));
fx2Y=sum(sum(fa2.*y));

% "fab"  "gradient" in Inhomogeneous system of equations
fx_fy=sum(sum(fab));
fxfyx2=sum(sum(fab.*x2));
fxfyxy=sum(sum(fab.*xy));
fxfyy2=sum(sum(fab.*y2));
fxfyX=sum(sum(fab.*x));
fxfyY=sum(sum(fab.*y));

% "fy2"  "gradient" in Inhomogeneous system of equations
fy2X=sum(sum(fb2.*x));
fy2Y=sum(sum(fb2.*y));
fy2x2 = sum(sum(fb2.*x2));
fy2xy = sum(sum(fb2.*xy)); 
fy2y2 = sum(sum(fb2.*y2));
fy_square = sum(sum(fb2));

%Design Matrix  "D" 
D = [fx2x2 fx2xy fxfyx2 fxfyxy fx2X fxfyX;fx2xy fx2y2 fxfyxy fxfyy2 fx2Y fxfyY;
    fxfyx2 fxfyxy fy2x2 fy2xy fxfyX fy2X;fxfyxy fxfyy2 fy2xy fy2y2 fxfyY fy2Y;
    fx2X fx2Y fxfyX fxfyY fx_square fx_fy;fxfyX fxfyY fy2X fy2Y fx_fy fy_square];

% Grey value difference between actual image and the target image
fVec = actual(:) - t(:);
sizeFG_vec = size(fVec) % calculating the matrix size

p = fx(:)'*(x(:).*fVec);
q = fx(:)'*(y(:).*fVec);
r = fy(:)'*(x(:).*fVec);
s = fy(:)'*(y(:).*fVec);
t = fx(:)'*fVec;
u = fy(:)'*fVec;

B_Mat = [p; q; r; s; t; u];      

%"Moore-Penrose-Pseudoinverse"
d = pinv(D)*B_Mat; 
% Correlation
H1 = [1+d(1) d(2) d(5);d(3) 1 + d(4) d(6);0 0 1]
end
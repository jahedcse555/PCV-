close all;
clear all;
clc;

% Least Squares Corelation
% image(150*150 pix.) as our input
[filename, pathname]=uigetfile('*.*','choose an image');
Image=imread([pathname filename]);
I = double(Image);

f=geotrans (eye(3),I);    %input image  f
figure(1);imshow (f, []);                   %show the image
title('Input Image');

%To reduce distortions the first step is to make a transformation
%Here we did Affine transformation to make our requirements

H = [1 0.1 2; 0.2 0.7 3; 0 0 1];            % Arbitrary 3*3 Affine transformation matrix
%Affine Transformation of the given parameters
%For this we are using the given geotrans.m to get our task completed

g = geotrans (H, f);       %Transfored Affine image g
figure(2);imshow (g, []);
title('Transformed Image(Affine)');
% print(gcf,'-dpng','Affine Transformation.png');

%In the next step of our mini project question it is given to implement the
%least square corelation for which we need the x and y dirction which can
%be obtained by using the given gradient.m file.
%The Taylor linearized inhomogeneous equation system: Az = b

iter = input('Enter the No of Iteration=');
Affine_Trans =test(f, g, iter);            
[fx, fy] = gradient(f, 2);                       %Using "gradient" given function 
figure;imshow(fx,[]);                                           % show x-gradient
title('X-direction gradient ');

figure;imshow (fy, []);                                          % show y-gradient
title('Y-direction gradient');

function affine =test(f,target,n)                
%value of radius, height, width and center                                  
r=8;
h=79;
w=49;                                        %centre with the choosen parameters
c=[h-r+1,w-r+1,r*2+1,r*2+1];                                          
for i= 1:n
    d=least_Square_Correlation(f,target);           
    target = geotrans(inv(d), target);                   
    figure;imshow(target,[]);                              %show the Target Image
    rectangle('Position',c,'LineWidth',0.2,'EdgeColor','b');   
    title(['iteration :' num2str(i)]);              
    pause(0.1);                                     %the iteration breaking time to display consecutive images
end                                     
affine=target;
end
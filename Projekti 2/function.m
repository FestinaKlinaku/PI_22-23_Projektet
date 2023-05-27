%% Komandat per pastrimin e workspace, mbylljen e figurave
%% dhe pastrimin e dritares komanduese
clc
clear all
close all

%% Instalimi i paketes image e cila mundeson
%% perdorimin e funksioneve per procesimin e imazheve
pkg load image

%% Leximi i imazhit 'moon.tiff' permes metodes imread
%% e cila kthen nje matrice me dimensionet e imazhit
%% Ruajtja e matrices ne nje variabel x
x = im2double(imread('moon.tiff'))

%% Shfaqja e imazhit ne nje dritare te vogel
imshow(x)

%% Krijimi i variablave row dhe col duke u bazuar ne dimensionet e matrices x
[row col] = size(x)

%% Krijimi dhe mbushja e matrices  IM_BW me 0 dhe
IM_BW = zeros(row,col)

%% Kthimi i vlerave te matrices nga uint8 ne double
%% permes metodes im2double dhe ruajtja ne variablen IM_X
IM_X = im2double(x)

%% Dhenia e parametrave
e = 4
k0 = 0
k1 = 0.02
k2 = 0.4

%% Gjetja e vlerave per mesataren lokale dhe devijimin standard lokal
%% Vlerat ones(3) dhe ones(3)/9 jane vlera te cilat perdoren kur kemi te
%% bejme me dritaren 3x3
dl = stdfilt(IM_X, ones(5))
ml = conv2(IM_X,ones(5)/25,'same')

%% Gjetja e vlerave per mesataren globale dhe devijimin standard global
dg = std2(IM_X)
mg = mean2(IM_X)

%% Iterimi neper matrice
for i=1:row
    for j=1:col
        %% Kushti per ndryshimin e pixelave dales
        %%
        %%           E*f(x,y) nese (ml<=k0*mg) dhe (k1*dg<=dl<=k2*dg)
        %% g(x,y) =
        %%           f(x,y)   ne rastet tjera
        %%
        if((ml(i,j) <= k0*mg) && (k1*dg <= dl(i,j)) && (dl(i,j) <= k2*dg))
            IM_BW(i,j)=e*IM_X(i,j);
        else
            IM_BW(i,j)=IM_X(i,j);
        end
    end
end

%% Shfaqja e figures pas ndryshimin
figure, imshow(IM_BW)

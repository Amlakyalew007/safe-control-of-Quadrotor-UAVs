function F=ARBF_z(in)
%==================================================================
%  GLOBAL VARIABLES
%==================================================================
global    G_s  m_s

global    B_e1   B_e2

global    k_o1  k_o2  k_a1 k_a2 


%%%%%%%%%%%%%%%%%%%%%%%
%   INPUTS    % 
%%%%%%%%%%%%%%%%%%%%%%%
lambda1=in(1);
lambda2=in(2);

x11=in(3);
x12=in(4);

W1_h=in(5:23);
W2_h=in(24:42);


vartheta_t=in(43);

e1=in(44);
x12d = in(45);
S=x12-x12d+k_o2^(-1)*lambda2;



cij=[-1.4  -1   -0.8  -0.4  -0.2   0    0.4  0.8    1     1.2    1.6    2     2.4  2.8    3   3.2  3.4  3.8   4;
     -8   -7    -6   -6.5  -6   -5.5   -5   -4   -3.5    -2    -1.5   -0.5     0   0.5    1   1.5   2   2.5   3
];%19
  
% bj=[ 2; 2; 2; 2; 2; 2; 2];

bj=[0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2; 0.2]*20;%19

J3=[x11;x12];
S_3=zeros(19,1);

for j=1:1:19
    S_3(j)=exp(-norm(J3-cij(:,j))^(2)/(2*bj(j)^(2)));
end
% S_3 = normalize(S_3);
% W1_h=[w1_1;w1_2;w1_3;w1_4;w1_5;w1_6;w1_7;w1_8;w1_9;w1_10;w1_11;w1_12;w1_13;w1_14;w1_15;w1_16;w1_17;w1_18;w1_19];
% W2_h=[w2_1;w2_2;w2_3;w2_4;w2_5;w2_6;w2_7;w2_8;w2_9;w1_10;w1_11;w1_12;w1_13;w1_14;w1_15;w1_16;w1_17;w1_18;w1_19];
% W3_h=[w3_1;w3_2;w3_3;w3_4;w3_5;w3_6;w3_7;w3_8;w3_9;w3_10;w3_11;w3_12;w3_13;w3_14;w3_15;w3_16;w3_17;w3_18;w3_19];



lambda1_dot=-k_a1*lambda1+lambda2-W1_h'*S_3;
lambda2_dot=-k_a2*lambda2-W2_h'*S_3;

varepsilon_F1=0.2;
k_F1=4;

varepsilon_F2=0.2;
k_F2=6;


W1_hd=varepsilon_F1*(k_o1^(-1)*vartheta_t^(2)*e1/(B_e1^2-(vartheta_t*e1)^2)+ e1*k_o1^(-1)+lambda1)*S_3-varepsilon_F1*k_F1*W1_h;
W2_hd=varepsilon_F2*(S*k_o2^(-1)+lambda2)*S_3-varepsilon_F2*k_F2*W2_h;


F  =  [lambda1_dot,lambda2_dot,W1_hd',W2_hd',W1_hd'*S_3,W2_hd'*S_3]';
%  F        =  [0,0,0,0]';
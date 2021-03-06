%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% Schrodinger solver on non-regular grid with m(z)!!! %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[E,psi]=Schroed1D_FEM_1band_nonregular_f(z,V0,Mass,n)

% One problem here is the operator (d/dz)*(1/m(z))*(d/dz) inside the Shrodinger equation
% Without any modification, the results are not accurate and show discontinuity 
% at the material interface due to the difference of masses
% One very nice approach is to use the mid-point mass:

% Paul Harrisson
% Quantum Wells, Wires and Dots.
% 4th edition (2016),
% chap 3 : "Numerical Solutions"
% 3.13: "Extention to variable effective mass"
% page 102

% Xunpeng Ma, Kangwen Li, Zuyin Zhang, Haifeng Hu, Qing Wang, Xin Wei,and Guofeng Song
% "Two-band finite difference method for the bandstructure calculation with nonparabolicity effects in quantum cascade lasers"
% JAP, 114, 063101 (2013)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Constants %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=6.62606896E-34;               %% Planck constant J.s
hbar=h/(2*pi);
e=1.602176487E-19;              %% charge de l electron Coulomb
m0=9.10938188E-31;              %% electron mass kg

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Nz=length(z);
dzb(2:Nz) = z(2:Nz) - z(1:Nz-1);      %% backward difference (i) - (i-1)
dzb(1) = dzb(2);
dzf(1:Nz-1) = z(2:Nz) - z(1:Nz-1);    %% forward difference  (i+1) - (i)
dzf(Nz) = dzf(Nz-1);

shift=min(V0);
V0=V0-shift;
V0(1) = 2;
V0(end) = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Building of the operators %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Massf = [         (Mass(1:end-1) + Mass(2:end)) / 2   Mass(end) ];  % forward mass
Massb = [ Mass(1) (Mass(1:end-1) + Mass(2:end)) / 2             ];  % backward mass

b = 2*( Massf.*dzf + Massb.*dzb ) ./ ( Massf.*dzf.*Massb.*dzb ) ./ ( dzb + dzf ) ;
a = 1./Massb(2:Nz)   ./ ( dzb(2:Nz)   .* ( dzb(2:Nz)   + dzf(2:Nz)   ) );
c = 1./Massf(1:Nz-1) ./ ( dzf(1:Nz-1) .* ( dzb(1:Nz-1) + dzf(1:Nz-1) ) );

DZ2 = (-1)*diag(b)  +  (2)*diag(a,-1)  +  (2)*diag(c,+1) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Building of the Hamiltonien %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

H = (-hbar^2/(2*m0)) * DZ2 + diag(V0*e);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% Diagonalisation of the Hamiltonien %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

H=sparse(H);
[psi,Energy] = eigs(H,n,'SM');
E = diag(Energy)/e + shift;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% Normalization of the Wavefunction %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:n
  psi(:,i)=psi(:,i)/sqrt(trapz(z',abs(psi(:,i)).^2));  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% here is a small patch due to differences between Octave and Matlab
% Matlab order the eigen values while Octave reverse it

if E(1)>E(2)
  psi=psi(:,end:-1:1);
  E=E(end:-1:1);
end

end
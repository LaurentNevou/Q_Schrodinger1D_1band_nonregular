%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Layers Structure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% first column is the material used from the "library"
% second column is the length of the layer in nm
% third column is the amount of meshing points of the layer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%substrate=GaAs;      % Important for the Strain model (GaAs, InP, InAs, GaSb)
%M=[
%GaAs      10    20
%InGaAs20  10    30
%GaAs      10    10
%];

%substrate=GaAs;      % Important for the Strain model (GaAs, InP, InAs, GaSb)
%M=[
%AlGaAs40      5   20
%GaAs          5   25
%AlGaAs40      5   10
%];

% Sirtori, PRB, 50, 8663 (1994)
%substrate=InP;      % Important for the Strain model (GaAs, InP, InAs, GaSb)
%M=[
%AlInAs   6      20
%InGaAs   5.2    15
%AlInAs   6      10
%];

% Sirtori, PRB, 50, 8663 (1994)
%substrate=InP;      % Important for the Strain model (GaAs, InP, InAs, GaSb)
%M=[
%AlInAs   6      20
%InGaAs   5.9    15
%AlInAs   1.3    5
%InGaAs   2.4    7
%AlInAs   6      10
%];

% Sirtori, PRB, 50, 8663 (1994)
substrate=InP;      % Important for the Strain model (GaAs, InP, InAs, GaSb)
M=[
AlInAs   6      10
InGaAs   4.6    70
AlInAs   1.0     5
InGaAs   2.0    6
AlInAs   1.0    35
InGaAs   1.9    40
AlInAs   6      10
];

%substrate=InP;      % Important for the Strain model (GaAs, InP, InAs, GaSb)
%M=[
%GaAsSb   10    20
%InGaAs   10    33
%GaAsSb   10    10
%];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

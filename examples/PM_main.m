clc
clear

DRAW_MAGNET = 1;
DRAW_TIKZ   = 0;

%% Define cross sections
rotor = CrossSectInnerRotorPMRotor( ...
        'name', 'rotor', ...
        'dim_alpha_rm', DimDegree(60), ...
        'dim_alpha_rp', DimDegree(180), ...     %Consider using alpha_rp = (360/p)*pi/180;
        'dim_alpha_rs', DimDegree(5), ...
        'dim_d_ri', DimMillimeter(8), ...
        'dim_r_ri', DimMillimeter(40), ...
        'dim_d_rp', DimMillimeter(5), ...
        'dim_d_rs', DimMillimeter(3), ...
        'dim_t_i',DimMillimeter(4),...
        'num_pole', 2, ...
        'num_seg', 5, ...
        'location', Location2D( ...
            'anchor_xy', DimMillimeter([0,0]), ...
            'theta', DimDegree(0).toRadians() ...
        ) ...
        );
%% Define components

cs = rotor;

comp1 = Component( ...
        'name', 'comp1', ...
        'crossSections', cs, ...
'material', MaterialGeneric('name', 'M19: USS Transformer 72 -- 29 Gage'), ...
        'makeSolid', MakeSimpleExtrude( ...
            'location', Location3D( ...
                'anchor_xyz', DimMillimeter([0,0,0]), ...
                'rotate_xyz', DimDegree([0,0,0]).toRadians() ...
                ), ...
            'dim_depth', DimMillimeter(15)) ...
        );

%% Draw via MagNet

if (DRAW_MAGNET)
    toolMn = MagNet();
    toolMn.open(0,0,true);
    toolMn.setDefaultLengthUnit('millimeters', false);

    comp1.make(toolMn,toolMn);

    toolMn.viewAll();
end

%% Draw via TikZ

if (DRAW_TIKZ)
    toolTikz = TikZ();
    toolTikz.open('output.txt');

    comp1.make(toolTikz);

    toolTikz.close();
end

function water = water_properties

% WATER_PROPERTIES Returns function handles to compute physical properties
%    of water dependent on temperature, from 0.1 to 100 celsius.
%
%    Requires:
%        water_data.mat
%
%    Water properties:
%        Density [kg/m^3]
%        Kinematic Viscosity [m^2/s]
%        Bulk Modulus [Pa]
%
%    Independent variable:
%        Temperature [C]
%
%    Examples:
%        water = water_properties;
%        % Compute water properties for a single temperature value
%        water.nu(27)
%        water.rho(27)
%        water.K(27)
%        % Create a short alias
%        nu = water.nu;
%        % Compute and plot the viscosity for multiple temperature values
%        t = 10:80;
%        plot(t,nu(t),'*')
%
%    Author:
%        Ildeberto de los Santos Ruiz
%        idelossantos@ittg.edu.mx

data_file = 'water_data.mat';
if exist(data_file)
    disp('Loading data...')
    x = load(data_file);
else
    errorStruct.message = 'Data file not found.';
    errorStruct.identifier = 'water_properties:fileNotFound';
    error(errorStruct)
end

% Temperature (C)
temperature = x.temperature;

% Density, rho (kg/m^3)
density = x.density;

% Kinematic Viscosity, nu (m^2/s)
viscosity = x.viscosity;

% Bulk Modulus, K (Pa)
bulk_modulus = x.bulk_modulus;

% Function handle for density
water.rho = @(t) interp1(temperature,density,t,'spline');

% Function handle for viscosity
water.nu = @(t) interp1(temperature,viscosity,t,'spline');

% Function handle for bulk modulus
water.K = @(t) interp1(temperature,bulk_modulus,t,'spline');

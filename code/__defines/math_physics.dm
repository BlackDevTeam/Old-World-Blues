// Math constants.

#define NUM_E 2.71828183

#define PI						3.1416
#define INFINITY				1e31	//closer then enough

#define SPEED_OF_LIGHT       3e8    // Approximate.
#define SPEED_OF_LIGHT_SQ    9e16

#define R_IDEAL_GAS_EQUATION       8.31    // kPa*L/(K*mol).
#define ONE_ATMOSPHERE             101.325 // kPa.
#define IDEAL_GAS_ENTROPY_CONSTANT 1164    // (mol^3 * s^3) / (kg^3 * L).

// Radiation constants.
#define STEFAN_BOLTZMANN_CONSTANT    5.6704e-8 // W/(m^2*K^4).
#define COSMIC_RADIATION_TEMPERATURE 3.15      // K.
#define AVERAGE_SOLAR_RADIATION      200       // W/m^2. Kind of arbitrary. Really this should depend on the sun position much like solars.
#define RADIATOR_OPTIMUM_PRESSURE    3771      // kPa at 20 C. This should be higher as gases aren't great conductors until they are dense. Used the critical pressure for air.
#define GAS_CRITICAL_TEMPERATURE     132.65    // K. The critical point temperature for air.

/*
	The pipe looks to be thin vertically and wide horizontally, so we'll assume that it's
	three centimeters thick, one meter wide, and only explosed to the sun 3 degrees off of edge-on.
	Since the radiatior is uniform along it's length, the ratio of surface area touched by sunlight
	to the total surface area is the same as the ratio of the perimeter of the cross-section.
*/
#define RADIATOR_EXPOSED_SURFACE_AREA_RATIO 0.04 // (3 cm + 100 cm * sin(3deg))/(2*(3+100 cm)). Unitless ratio.
#define HUMAN_EXPOSED_SURFACE_AREA          5.2 //m^2, surface area of 1.7m (H) x 0.46m (D) cylinder

#define T0C  273.15 //    0.0 degrees celcius
#define T20C 293.15 //   20.0 degrees celcius
#define TCMB 2.7    // -270.3 degrees celcius

#define QUANTIZE(variable) (round(variable,0.0001))

#define SIMPLE_SIGN(X) ((X) < 0 ? -1 : 1)
#define SIGN(X)        ((X) ? SIMPLE_SIGN(X) : 0)

#define Clamp(value, low, high) 	(value <= low ? low : (value >= high ? high : value))
#define CLAMP01(x) 		(Clamp(x, 0, 1))

#define CEILING(x, y) ( -round(-(x) / (y)) * (y) )

// round() acts like floor(x, 1) by default but can't handle other values
#define FLOOR(x, y) ( round((x) / (y)) * (y) )


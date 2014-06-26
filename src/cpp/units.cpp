#include <iostream>

#include <boost/units/conversion.hpp>
#include <boost/units/systems/si/energy.hpp>
#include <boost/units/systems/si/pressure.hpp>
#include <boost/units/systems/si/force.hpp>
#include <boost/units/systems/si/length.hpp>
#include <boost/units/systems/si/electric_potential.hpp>
#include <boost/units/systems/si/resistance.hpp>
#include <boost/units/systems/si/volume.hpp>
#include <boost/units/systems/si/temperature.hpp>
#include <boost/units/systems/si/io.hpp>

using namespace boost::units;
using namespace boost::units::si;

quantity<energy>
work(const quantity<force>& F, const quantity<length>& dx)
{
    return F * dx; // Defines the relation: work = force * distance.
}

int main()
{
    auto mmHg = 133.322 * newton / (meter*meter );
    std::cout << "mmHg=" << mmHg << std::endl;
    auto Cgaz = 62.36e-3*cubic_meter*mmHg/(kelvin*mole);
    std::cout << "Cgaz=" << Cgaz << std::endl;

    auto body_temp = 300*kelvin;
    auto rho = Cgaz * body_temp;
    std::cout << "rho=" << rho << std::endl;

    auto mmL = 1e-6*cubic_meter;
    std::cout << "mmL=" << mmL << std::endl;
    auto mu_mol = 1e-6*mole;
    std::cout << "muMol=" << mu_mol << std::endl;
    auto C1=306.64*mu_mol/mmL;
    auto C2=325.02*mu_mol/mmL;
    std::cout << "C1=" << C1 << "  , C2 = " << C2 << std::endl;
    auto DeltaPis = rho*(C1-C2);
    std::cout << "DeltaPis = " << DeltaPis << std::endl;
    std::cout << "DeltaPis(mmHg) = " << DeltaPis /133.322<< std::endl;
///std::cout << "DeltaPis(mmHg)= " << boost::units::conversion_factor(pascal,133.322 * newton / (meter*meter )) << std::endl;
    std::cout << "DeltaPis(thoeritical) = " << (400.*mmHg) << std::endl;


    return 0;
}

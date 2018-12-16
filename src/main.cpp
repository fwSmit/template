#include <iostream>
#include <armadillo>
#include <SFML/Graphics.hpp>
#include <TGUI/TGUI.hpp>

int main()
{
	std::cout << "Opening window" << std::endl;
	sf::RenderWindow window(sf::VideoMode(500, 500), "Template works!");
	tgui::Gui gui(window);
	tgui::Button::Ptr button;
	arma::fvec2 circlePos {250, 250};
	sf::CircleShape shape(100.f);
	shape.setOrigin(shape.getRadius(), shape.getRadius());
	shape.setPosition(circlePos[0], circlePos[1]);
	shape.setFillColor(sf::Color::Green);

	while (window.isOpen())
	{
		sf::Event event;
		while (window.pollEvent(event))
		{
			switch (event.type){
				case sf::Event::Closed:
					window.close();
					break;
				default:
					break;
			}
		}

		window.clear();
		window.draw(shape);
		window.display();
	}
}

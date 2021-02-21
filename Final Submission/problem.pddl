(define (problem tour_planner_problem)
    (:domain tour_planner)

    (:objects
        TourTravelsBus - transport;TourTravelsBus is the tour bus
        Home Teknaf SaintMartin CoxBazar  - location;4 locations has been set
        spot0 spot1 spot2 spot3 spot4 spot5 spot6 spot7 spot8 spot9 spot10 - spot;10 different named spots within 4 locations
    )

    (:init
        (= (already_visited) 0);initially no spot visited
        (at TourTravelsBus Home);tour bus at starting location
        (spot_visiting Teknaf spot2);spots within Teknaf
        (spot_visiting SaintMartin spot5);spots withi SaintMartin
        (spot_visiting CoxBazar spot4);spots within CoxBazar
        (rating_order spot0 spot1);spot1 higher rated than spot0
        (rating_order spot1 spot2)
        (rating_order spot2 spot3)
        (rating_order spot3 spot4)
        (rating_order spot4 spot5)
        (rating_order spot5 spot6)
        (rating_order spot6 spot7)
        (rating_order spot7 spot8)
        (rating_order spot8 spot9)
        (rating_order spot9 spot10)
        (= (distance Home Home) 0)
        (= (distance Home Teknaf) 711);distance from Home to SaintMartin is 711 km
        (= (distance Home SaintMartin) 896)
        (= (distance Home CoxBazar) 600)
        (= (distance Teknaf Home) 711)
        (= (distance Teknaf Teknaf) 0)
        (= (distance Teknaf SaintMartin) 145)
        (= (distance Teknaf CoxBazar) 183)
        (= (distance SaintMartin Home) 896)
        (= (distance SaintMartin Teknaf) 145)
        (= (distance SaintMartin SaintMartin) 0)
        (= (distance SaintMartin CoxBazar) 323)
        (= (distance CoxBazar Home) 600)
        (= (distance CoxBazar Teknaf) 183)
        (= (distance CoxBazar SaintMartin) 323)
        (= (distance CoxBazar CoxBazar) 0)
        (= (per_km_cost TourTravelsBus) 2.59);per kilometer cost of the bus is Tk. 2.59
        (= (total-cost) 0);initially total cost is tk 0
        (= (food-cost) 20);food cost has been set as tk 20
        (= (transport-cost) 10);transport cost to roam a particular location is set tk 10
    )

    (:goal (and 
            (= (already_visited) 10);spots need to visited
            (spot_visiting Teknaf spot0);number of remaining spots in Teknaf is 0
            (spot_visiting SaintMartin spot0)
            (spot_visiting CoxBazar spot0)
            (at TourTravelsBus Home);tour bus again back at initial position
            (tour_ending_spot Home);tour ending spot is Home from where we started
           )
	)

    (:metric minimize (total-cost));plan in a way that total-cost is minimized
)

(define (problem tour_planner_problem)
    (:domain tour_planner)

    (:objects
        TourTravelsBus - transport
        Home Teknaf SaintMartin CoxBazar  - location
        spot0 spot1 spot2 spot3 spot4 spot5 spot6 spot7 spot8 spot9 spot10 - spot
    )

    (:init
        (= (already_visited) 0)
        (at TourTravelsBus Home)
        (spot_visiting Teknaf spot2)
        (spot_visiting SaintMartin spot5)
        (spot_visiting CoxBazar spot4)
        (rating_order spot0 spot1)
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
        (= (distance Home Teknaf) 711)
        (= (distance Home SaintMartin) 896)
        (= (distance Home CoxBazar) 300)
        (= (distance Teknaf Home) 711)
        (= (distance Teknaf Teknaf) 0)
        (= (distance Teknaf SaintMartin) 185)
        (= (distance Teknaf CoxBazar) 183)
        (= (distance SaintMartin Home) 896)
        (= (distance SaintMartin Teknaf) 185)
        (= (distance SaintMartin SaintMartin) 0)
        (= (distance SaintMartin CoxBazar) 323)
        (= (distance CoxBazar Home) 300)
        (= (distance CoxBazar Teknaf) 183)
        (= (distance CoxBazar SaintMartin) 323)
        (= (distance CoxBazar CoxBazar) 0)
        (= (per_km_cost TourTravelsBus) 2.59)
        (= (total-cost) 0)
        (= (food-cost) 20)
        (= (transport-cost) 0)
    )

    (:goal (and 
            (= (already_visited) 10)
            (spot_visiting Teknaf spot0)
            (spot_visiting SaintMartin spot0)
            (spot_visiting CoxBazar spot0)
            (at TourTravelsBus Home)
            (tour_ending_spot Home)
           )
	)

    
)

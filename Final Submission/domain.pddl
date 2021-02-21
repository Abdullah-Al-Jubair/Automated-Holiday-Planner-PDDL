(define (domain tour_planner)
    (:requirements :strips :typing :action-costs)

    (:types
        location transport spot - object
    )

    (:predicates
        (at ?transport - transport ?location - location) ;transport is located at location
        (spot_visiting ?location - location ?spot_no - spot) ;visit status of a spot within a location
        (rating_order ?spot1 ?spot2 - spot) ;spot2 is more popular/rated than spot1
        (tour_ending_spot ?location - location) ;indicates the end location of tour
        (moved) ;whether moved to new location or not
        (food_cost_added) ;when food cost is added or not
        (had_food) ;whether enjoyed food or not
        (enjoyed) ;whether a spot is visited or not
        
        
        
    )

    (:functions
        (distance ?location1 ?location2 - location) ;returns distance between two locations
        (per_km_cost ?transport - transport) ;returns per kilometer cost of a transport
        (total-cost) ;indicates total cost of the tour
        (transport-cost) ;indicates transport cost after moving from a location to another
        (food-cost) ;indicates food cost after moving from a location to another
        (already_visited) ;returns count of already visited places
    )
   
    (:action Enjoying_Spot ;using this action tourist roam around the spots of a location
        :parameters (?t - transport ?l - location ?place ?placeLessOne  - spot)
        :precondition (and 
                        (at ?t ?l) ;transport need to be in this location
                        (not(tour_ending_spot ?l)) ;this is not the end position of the tour
		                (spot_visiting ?l ?place) 
		                (rating_order ?placeLessOne ?place) ;popularity of a spot is greater than another
		                (moved) ;already moved to this location
		                (not(enjoyed)) ;the spot is not explored already
		              )  
        :effect (and 
                (not (spot_visiting ?l ?place)) 
		        (spot_visiting ?l ?placeLessOne)
		        (not(had_food)) ;not enjoyed the food yet
		        (enjoyed) ;explored the spot
		        )
    )
    
    
    (:action Having_Foood ;enjoying food from the spots
        :parameters (?t - transport ?l - location ?place - spot )
        :precondition (and 
                        (at ?t ?l) ;transport need to be in this location
		                (spot_visiting ?l ?place)
		                (not(had_food));not enjoyed the food yet
		                (enjoyed);explored the spot
		 
		              )  
        :effect (and 
		        (had_food);enjoyed the food
		        (increase (already_visited) 1);increment the number of visited spot by 1
		         (not(enjoyed));toggle the explored location status so that enjoyed_spot can be executed again
		        )
    )
    
    (:action Move_to_Location;used for moving to a particular location
        :parameters (?t - transport ?from ?loc - location)
        :precondition (and
                        (not(moved));not moved to the new location already
                        (not(tour_ending_spot ?from));this is not the ending position of the tour
                        (at ?t ?from);transport need to be in the initial stating location
                      )
        :effect (and 
                (not (at ?t ?from));transport is not in stating location
		        (at ?t ?loc);transport is in new location
		        (increase (total-cost) (* (distance ?from ?loc) (per_km_cost ?t)));total-cost=total-cost+distance*per kilometer cost
		        (moved);already moved to new location
		        
                )
    )
    
    (:action add_food_cost;adding food cost of a location to the total-cost
        :parameters (?t - transport ?from - location)
        :precondition (and
        		 (at ?t ?from);transport is in this location
                        (moved);already moved to a new location
                        (had_food);already enjoyed the food
                        (not(food_cost_added));food cost not added yet
                        (not(tour_ending_spot ?from));this is not the tour ending spot
                      )
        :effect (and 
		        (increase (total-cost) (food-cost));total-cost = total-cost + food-cost
		        (food_cost_added);food cost added
                )
    )
    
    (:action add_transport_cost;used for adding transport cost
        :parameters (?t - transport ?from  - location)
        :precondition (and
        		 (at ?t ?from);transport is in this location
        		 (moved);already moved to a new location
                        (food_cost_added);food cost added
                        (not(tour_ending_spot ?from));this is not the tour ending spot
                      )
        :effect (and 
               (not(food_cost_added));toggle food cost adding status so that it can be executed later
               (not(moved));toggle moved status so that Move_to_Location can be executed later
		        (increase (total-cost) (transport-cost));total-cost = total-cost + transport-cost
                )
    )

    (:action Get_Back_Home;used for safe return to home after the trip
        :parameters (?t - transport ?l - location)
        :precondition (and
                        (= (already_visited) 10);visited the number of spots tourists wanted to visit
                        (at ?t ?l);transport is in this location
                      )
        :effect (and
                (at ?t ?l);;transport is in this location
                (tour_ending_spot ?l);this location is the tour ending location
                )
    )
)

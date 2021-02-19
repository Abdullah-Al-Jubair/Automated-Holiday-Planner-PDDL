(define (domain tour_planner)
    (:requirements :strips :typing :action-costs)

    (:types
        location transport spot - object
    )

    (:predicates
        (at ?transport - transport ?location - location)
        ; (visited_spots ?transport - transport ?spot_no - spot)
        (spot_visiting ?location - location ?spot_no - spot)
        (rating_order ?spot1 ?spot2 - spot)
        (tour_ending_spot ?location - location)
    )

    (:functions
        (distance ?location1 ?location2 - location)
        (per_km_cost ?transport - transport)
        (total-cost)
        (transport-cost)
        (food-cost)
        (already_visited)
    )
   
    (:action Enjoying_Location
        :parameters (?t - transport ?l - location ?d ?d_less_one  - spot)
        :precondition (and 
                        (at ?t ?l)
                        (not(tour_ending_spot ?l))
		                (spot_visiting ?l ?d)
		              ;  (visited_spots ?t ?c)
		                (rating_order ?d_less_one ?d)  
		              ;  (rating_order ?c_less_one ?c)
		              )  
        :effect (and 
                (not (spot_visiting ?l ?d))
		        (spot_visiting ?l ?d_less_one)
		      ;  (not (visited_spots ?t ?c))
		      ;  (visited_spots ?t ?c_less_one)
		        (increase (already_visited) 1)
		        )
    )

    (:action Move_to_Location
        :parameters (?t - transport ?from ?to - location)
        :precondition (and
                        (not(tour_ending_spot ?from))
                        (at ?t ?from)
                      )
        :effect (and 
                (not (at ?t ?from))
		        (at ?t ?to)
		        (increase (total-cost) (+ (+ (* (distance ?from ?to) (per_km_cost ?t))(food-cost))(transport-cost)))
                )
    )

    (:action Get_Back_Home
        :parameters (?t - transport ?l - location)
        :precondition (and
                        (= (already_visited) 10)
                        (at ?t ?l)
                      )
        :effect (and
                (at ?t ?l)
                (tour_ending_spot ?l)
                )
    )
)
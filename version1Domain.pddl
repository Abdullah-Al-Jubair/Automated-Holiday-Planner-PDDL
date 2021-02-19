(define (domain tour_planner)
    (:requirements :strips :typing :action-costs)

    (:types
        location transport quantity - object
    )

    (:predicates
        (at ?transport - transport ?location - location)
        (visited_spots ?transport - transport ?spot_no - quantity)
        (spot_visiting ?location - location ?spot_no - quantity)
        (plus1 ?quantity1 ?quantity2 - quantity)
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
        :parameters (?t - transport ?l - location ?d ?d_less_one ?c ?c_less_one - quantity)
        :precondition (and 
                        (at ?t ?l)
                        (not(tour_ending_spot ?l))
		                (spot_visiting ?l ?d)
		                (visited_spots ?t ?c)
		                (plus1 ?d_less_one ?d)  
		                (plus1 ?c_less_one ?c)
		              )  
        :effect (and 
                (not (spot_visiting ?l ?d))
		        (spot_visiting ?l ?d_less_one)
		        (not (visited_spots ?t ?c))
		        (visited_spots ?t ?c_less_one)
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
                        (= (already_visited) 40)
                        (at ?t ?l)
                      )
        :effect (and
                (at ?t ?l)
                (tour_ending_spot ?l)
                )
    )
)
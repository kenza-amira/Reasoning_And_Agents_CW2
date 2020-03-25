(define (domain travelling4)
    (:requirements :adl  :action-costs)

    (:types
        car
        agent
        location
    )

    (:constants
        ;; You should not need to add any additional constants
        Agent - agent
    )

    (:predicates
	(Car ?x - car) ;; x is a car
    (RentalCar ?x - car) ;; x is a rentalcar
	(Agent ?x - agent) ;; x is an agent
    (connectedByRoad ?x - location ?y - location) ;; You can drive from x to y
    (connectedByPlane ?x - location ?y - location) ;; You can take a plane from x to y
    (carIsAt ?car - car ?x - location) ;; The car is at x
    (agentIsAt ?x - location) ;; The agent is at x
    (visited ?x - location) ;; x is visited
    (rentalCarIsAt ?x - car ?l - location) ;; rentalCar x is originally at location l
    (CarCompanyIsAt ?x -car ?l - location) ;; The car company x is at l
    )
    (:functions 
        (total-cost) - number
    )

    ;; Drive the car from one location to another if they are connected by road and the car is in the Agent's
    ;; location.
    (:action Drive 
      :parameters (?agent - agent ?car - car ?from - location ?to - location)
      :precondition (and
      (Agent ?agent)
      (Car ?car)
      (agentIsAt ?from)
      (carIsAt ?car ?from)
      (connectedByRoad ?from ?to)
      )
      :effect (and
	  (not (carIsAt ?car ?from))
      (not (agentIsAt ?from))
      (carIsAt ?car ?to)
      (agentIsAt ?to)
      (increase (total-cost) 1)
          )
    )

    ;; Fly by plane between two locations connected via air, but only in the direction of air route
    (:action Fly
        :parameters (?agent - agent ?from - location ?to - location)
        :precondition (and 
        (Agent ?agent)
        (agentIsAt ?from)
        (connectedByPlane ?from ?to)
        )
        :effect (and 
        (not (agentIsAt ?from))
        (agentIsAt ?to)
        (increase (total-cost) 10)
        )
    )
    ;; Visit a location if it is in that location and has not been visited before
    (:action Visit
        :parameters (?agent - agent ?location - location)
        :precondition (and 
        (Agent ?agent)
        (agentIsAt ?location)
        (not(visited ?location))
        )
        :effect (visited ?location)
    )
    ;; Agent takes the bus between any two locations which are connected by road.
    (:action Bus
        :parameters (?agent - agent ?from - location ?to - location)
        :precondition (and
        (Agent ?agent)
        (agentIsAt ?from)
        (connectedByRoad ?from ?to)
        )
        :effect (and 
        (not (agentIsAt ?from))
        (agentIsAt ?to)
        (increase (total-cost) 5)
        )
    )
    ;;The agent can hire a car from a specific location
    (:action HireCar
        :parameters (?agent - agent, ?rentalcar - car, ?location - location)
        :precondition (and
        (RentalCar ?rentalcar) 
        (Agent ?agent)
        (agentIsAt ?location)
        (rentalCarIsAt ?rentalcar ?location)
        )
        :effect (and 
        (not (rentalCarIsAt ?rentalcar ?location))
        (not (RentalCar ?rentalcar))
        (Car ?rentalcar)
        (carIsAt ?rentalcar ?location)
        )
    )
    
    ;; The agent returns the car to the right location after hiring it
    (:action ReturnCar
        :parameters (?agent - agent, ?rentalcar - car, ?location -location)
        :precondition (and
        (Car ?rentalcar)
        (Agent ?agent)
        (carIsAt ?rentalcar ?location)
        (agentIsAt ?location)
        (not(rentalCarIsAt ?rentalcar ?location))
        (CarCompanyIsAt ?rentalcar ?location) ;; makes sure that it's returning to the right location
        )
        :effect (and
        (rentalCarIsAt ?rentalcar ?location)
        (not (Car ?rentalcar))
        (RentalCar ?rentalcar)
        (not(carIsAt ?rentalcar ?location))
        )
    )
    
)

(define (problem travelling-33)
    (:domain travelling4)
    (:objects
	car - car
	A B C D E F G H I - location
    Toyota - car
    Volvo - car
    Renault - car
    )

    (:init
    (= (total-cost) 0)
    (Agent agent)
    (agentIsAt E)
    (RentalCar Volvo)
    (RentalCar Toyota)
    (RentalCAr Renault)
    (rentalCarIsAt Volvo E)
    (rentalCarIsAt Toyota C)
    (rentalCarIsAt Renault A)
    (CarCompanyIsAt Volvo E)
    (CarCompanyIsAt Toyota C)
    (CarCompanyIsAt Renault A)
    (connectedByRoad A E)
    (connectedByRoad E A)
    (connectedByRoad A I)
    (connectedByRoad I A)
    (connectedByRoad H I)
    (connectedByRoad I H)
    (connectedByRoad B H)
    (connectedByRoad H B)
    (connectedByRoad H G)
    (connectedByRoad G H)
    (connectedByRoad G F)
    (connectedByRoad F G)
    (connectedByRoad D F)
    (connectedByRoad F D)
    (connectedByRoad C F)
    (connectedByRoad F C)
    (connectedByRoad D C)
    (connectedByRoad C D)
    (connectedByPlane A B)
    (connectedByPlane B A)
    (connectedByPlane A C)
    (connectedByPlane C B)
    )

    (:goal (and
    (visited D)
    (visited B)
    (agentIsAt E)
    (rentalCarIsAt Volvo E)
    (rentalCarIsAt Toyota C)
    (rentalCarIsAt Renault A)
    (<= (total-cost) 40)
    )
    )
    
)
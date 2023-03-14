// Agent consumer_charles in project multi-agent_coordination_project

/* Initial beliefs and rules */

myName("consumer_charles").

//tour operators
tour_agent("tour_operator_one").
//tour_agent("tour_operator_two").

//destination intended
destination("vilnius").
budget(100).
minRep(60).

 
!introduce.

+!introduce <- 
	.my_name(Me);
	.print(Me,": introducing to tour_operator_one");
	if(destination(Dest) & budget(Budg) & minRep(Rep)){
		.send(tour_operator_one,tell, destinationBudgetRep(Me, Dest,Budg, Rep)[source(self)]);
	}else{
		.print("I do not have any travel plans for now");
	}.

+!reviewProposal(TotalPriceOffer)[source(SourceAgent)]:budget(Budget) & myName(MyName) & destination(MyDestination)
	<- .print("Total Price Offer: ", TotalPriceOffer);
	   .print("My Budget: ", Budget);
	if(TotalPriceOffer <= Budget){
			//accept
			.print("Accepting offer...");
			.send(SourceAgent, achieve, accepted(MyName, MyDestination)[source(self)])
		}else{
			//decline
			.print("Declining offer...");
			.print("Total Price Offer: ", TotalPriceOffer);
			.print("My Budget: ", Budget);
			.send(SourceAgent, tell, declined(MyName)[source(self)])
		}
		.




{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
{ include("$moiseJar/asl/org-obedient.asl") }



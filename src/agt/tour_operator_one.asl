// Agent tour_operator_one in project multi-agent_coordination_project

/* Initial beliefs and rules */

//holiday packages
holiday_package("transport").
holiday_package("accomodation").
holiday_package("diving").
holiday_package("extreme_jumping").


//service company agents
sca("service_coy_agent_one").
sca("service_coy_agent_two").

sumForConsumer(0).

/* Initial goals */

!plan_tour.

/* Plans */
// plan for building the house with two sub-goals: contract and execute
+!plan_tour
   <- !waitConsumerIntroduction; // hire the companies that will build the house
   	   !retrieveServicesFromSCA;
   	   !proposeOfferToConsumer;
   	   .wait(10000);
   	   !go;
      .
// recovery plan for the failure of the achievement of the goal have_a_house
-!plan_tour[error(E),error_msg(Msg),code(Cmd),code_src(Src),code_line(Line)]
   <- .print("Failed to organise tour due to: ",Msg," (",E,"). Command: ",Cmd, " on ",Src,":", Line).


+!waitConsumerIntroduction <- .wait(3000);
								.print("These consumers introduced: ");
								for(destinationBudgetRep(Consumer, Destination,Budget, MinRep)[source(SourceConsumer)]){
									.print(Consumer, " intends to go to ",Destination, " and has a budget of ", Budget, ". Accepts services with rep >= ", MinRep);
								}.
							
+!retrieveServicesFromSCA <- .print("contract phase started...") ;
				for(sca(ServiceAgentName)){
					//get all services and prices from all agents
					.send(ServiceAgentName, achieve, sendServicesAndPrice);
					//wait to receive services information from service agents
					
				}
				.wait(3000).
				
+!proposeOfferToConsumer <- .print("Sending proposals to consumers...");
							for(destinationBudgetRep(Consumer, Destination,Budget, MinRep)[source(ConsumerName)]){
								for(holiday_package(Package)){
									.findall(PackageBudget,serviceWithRep(Package,Destination,PackageBudget, Rep) [source(ServiceAgentName)] & Rep >= MinRep, PackagePrices);
  									.min(PackagePrices,BestPrice);
  									if(sumForConsumer(Sum,ConsumerName)){
  										-+sumForConsumer(Sum+BestPrice,ConsumerName);
  									}else{
  										+sumForConsumer(BestPrice,ConsumerName)
  									}
  									+bestDealForConsumer(ConsumerName, Package, BestPrice, Destination);
								}
							 //send proposal to consumer
							 if(sumForConsumer(TotalPrice,ConsumerName)){
							 	 .send(ConsumerName, achieve, reviewProposal(TotalPrice)[source(self)]);
							 }
							
							}.
							

+!accepted(ConsumerName,Destination)[source(SourceConsumer)] 
//send contract to applicable agents to serve this customer
	<- for(holiday_package(Package)){
		if(bestDealForConsumer(SourceConsumer,Package,Price,Destination)){
			//find the agent with this same price for the package and contract
			if(serviceWithRep(Package,Destination,Price, Rep)[source(SCAgent)]){
				.send(SCAgent, tell, signedContract(SourceConsumer,Package,Destination,Price));
			}
		}
	}
.

+!go<-
	println;
      println("*** Execution Phase ***");
      println("Waiting the `execute` from the user");
.

+!execute <- 
	for(sca(ServiceAgent)){
		.send(ServiceAgent, achieve, organise);
	} 
	

.
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }

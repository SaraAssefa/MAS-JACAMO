// Agent service_coy_agent_two in project multi-agent_coordination_project

/* Initial beliefs and rules */
myName("service_coy_agent_two").

//destinations offered
destination("hawasa").
destination("kaunas").
destination("lagos").

myName("service_coy_agent_two").

//hawasa
service("transport", "addis-ababa", 15, 100).
service("accomodation", "addis-ababa", 30, 90).
service("diving", "addis-ababa", 25, 85).
service("extreme_jumping", "addis-ababa", 85).

reputation(95).

//vilnius
service("transport", "vilnius", 18).
service("accomodation", "vilnius", 20).
service("diving", "vilnius", 28).
service("extreme_jumping", "vilnius", 30).

//abuja
service("transport", "abuja", 15).
service("accomodation", "abuja", 24).
service("diving", "abuja", 13).
service("extreme_jumping", "abuja", 25).

/* Initial goals */


+!sendServicesAndPrice[source(RequestingAgent)] <- .print("sending my services detals to ", RequestingAgent);
	for(reputation(Rep)){
		for(service(ServiceName,City,Price)){
			.send(RequestingAgent,tell, serviceWithRep(ServiceName,City,Price, Rep)[source(self)]);
		}
	}.

+!organise <- for(signedContract(SourceConsumer, Package,Destination,Price)){
	.print("Organising ", Package, " plans for ",SourceConsumer, " in ", Destination);
	.wait(1500);
	.print(Package, " plans for ",SourceConsumer, " in ", Destination, " organised.");
}
.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }

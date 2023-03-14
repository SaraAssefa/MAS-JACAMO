// Agent service_coy_agent_one in project multi-agent_coordination_project

/* Initial beliefs and rules */

//destinations offered
destination("addis-ababa").
destination("vilnius").
destination("abuja").

myName("service_coy_one").

reputation(50).

//addis-ababa

service("transport", "addis-ababa", 10).
service("accomodation", "addis-ababa", 20).
service("diving", "addis-ababa", 20).
service("extreme_jumping", "addis-ababa", 20).

//vilnius
service("transport", "vilnius", 12).
service("accomodation", "vilnius", 15).
service("diving", "vilnius", 22).
service("extreme_jumping", "vilnius", 18).

//abuja
service("transport", "abuja", 10).
service("accomodation", "abuja", 20).
service("diving", "abuja", 10).
service("extreme_jumping", "abuja", 20).

/* Initial goals */


+!sendServicesAndPrice[source(RequestingAgent)] <- .print("sending my services detals to ", RequestingAgent);
	for(reputation(Rep)){
		for(service(ServiceName,City,Price)){
			.send(RequestingAgent,tell, serviceWithRep(ServiceName,City,Price, Rep)[source(self)]);
		}
	}.

+!organise <- for(signedContract(SourceConsumer,Package,Destination,Price)){
	.print("Organising ", Package, " plans for ",SourceConsumer, " in ", Destination);
	.wait(1500);
	.print(Package, " plans for ",SourceConsumer, " in ", Destination, " organised.");
}.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }

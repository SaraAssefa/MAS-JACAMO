// Agent common in project multi-agent_coordination_project

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true <- .print("hello world.").

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
+!sendServicesAndPrice[source(RequestingAgent)] <- .print("sending my services detals to ", RequestingAgent);
	for(service(ServiceName,City,Price)){
		.send(RequestingAgent,tell, service(ServiceName,City,Price, Rep)[source(self)]);
	}.

+!organise <- for(signedContract(SourceConsumer,Package,Destination,Price)){
	.print("Organising ", Package, " plans for ",SourceConsumer, " in ", Destination);
	.wait(1500);
	.print(Package, " plans for ",SourceConsumer, " in ", Destination, " organised.");
}.
// CArtAgO artifact code for project multi_agent_coordination_project

package tools;

import cartago.*;

public class Counter extends Artifact {
	void init(int initialValue) {
		defineObsProperty("count", initialValue);
	}

	@OPERATION
	void inc() {
		ObsProperty prop = getObsProperty("count");
		prop.updateValue(prop.intValue()+1);
		signal("tick");
	}
}


// Give all tactical actors the poise effect when they are initialized.
::mods_hookChildren("entity/tactical/actor", function(o) {
	local original_onAfterInit;
	if ("onAfterInit" in o) {
		original_onAfterInit = o.onAfterInit;
	} else {
		original_onAfterInit = function(){};
	}
	o.onAfterInit = function() {
		original_onAfterInit();
		this.getSkills().add(new("scripts/skills/effects/poise"));
	}
});

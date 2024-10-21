// Give all tactical actors the poise effect when they are initialized.
::mods_hookExactClass("entity/tactical/actor", function(o) {
	while(!("onInit" in o)) o = o[o.SuperName];

	local original_onInit = o.onInit;
	o.onInit = function() {
		original_onInit();
		this.m.Skills.add(new("scripts/skills/effects/poise_effect"));
		this.m.Skills.add(new("scripts/skills/effects/action_point_tooltip"));
		this.m.Skills.add(new("scripts/skills/actives/recover_skill"));
		// this.m.Skills.add(new("scripts/skills/actives/defensive_stance"));
	}
});

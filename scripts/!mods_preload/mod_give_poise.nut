// Give all tactical actors the poise effect when they are initialized.
::mods_hookBaseClass("entity/tactical/actor", function(o) {
	local original_onInit = o.onInit;
	o.onInit = function() {
		original_onInit();
		this.getSkills().add(new("scripts/skills/effects/poise"));
	}
});

action_point_tooltip <- inherit("scripts/skills/skill", {
	m = {}

	function create() {
		m.ID					= "effects.ap_tooltip";
		m.Name					= "AP Tooltip";
		m.Icon					= "ui/perks/perk_25.png";
		//m.IconMini				= "perk_25_mini";
		m.Overlay				= "perk_25";
		m.Type					= Const.SkillType.StatusEffect;
		m.IsActive				= false;
		m.IsStacking			= false
		m.IsRemovedAfterBattle	= true;
	}

	function getDescription() {
		local waiting_status = "";
		if (getContainer().getActor().m.IsWaitActionSpent) {
			waiting_status = ", waiting";
		}
		return "" + getContainer().getActor().getActionPoints() + " AP" + waiting_status;
	}

	function getTooltip() {
		return [
					{ id = 1, type = "title", text = getName() }
					{ id = 2, type = "description", text = getDescription() }
				];
	}

	function getName() {
		return getDescription();
	}

	function onAfterUpdate(_properties) {
		if (getContainer().getActor().getActionPoints() == 0 ||
		getContainer().getActor().m.IsTurnDone) {
			m.Icon = "ui/perks/perk_25_sw.png";
		} else {
			m.Icon = "ui/perks/perk_25.png";
		}
	}

	function isHidden()
	{
		return !this.getContainer().getActor().isPlacedOnMap();
	}
});

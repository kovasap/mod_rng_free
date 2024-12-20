poise_effect <- inherit("scripts/skills/skill", {
	m = {
		Count = -1
		Max = -1
		Refresh = 1
	}

	function create() {
		m.ID					= "effects.poise";
		m.Name					= "Poise";
		m.Icon					= "ui/perks/perk_19.png";
		m.IconMini			= "perk_19_mini";
		m.Overlay				= "perk_19";
		m.Type					= Const.SkillType.StatusEffect;
		m.IsActive				= false;
		m.IsStacking			= false;
		m.IsRemovedAfterBattle	= true;
	}

	function getDescription() {
		return "This character is prepared to dodge [color=" + Const.UI.Color.PositiveValue + "]" + m.Count + "[/color] more blows and will accumulate " + m.Refresh + " poise per turn, up to a max of " + m.Max + ".";
	}

	function getTooltip() {
		return [
					{ id = 1, type = "title", text = getName() }
					{ id = 2, type = "description", text = getDescription() }
				];
	}

	function getName() {
		setMax();
		return m.Name + " (" + m.Count + "/" + m.Max + ")";
	}

	function getActor() {
	  return getContainer().getActor();
	}

	function getActorProperties() {
	  return getActor().getCurrentProperties();
	}

	function setMax() {
	  m.Max = Math.max(Math.floor(getActor().getFatigueMax() / 15), 6);
	}

	function onAdded() {
	  // This happens too early for the effect to work with actor properties,
		// since it seems they aren't set yet?
	}

	function onRefresh() {
		getContainer().update();
	}

	function onUpdate(_properties) {
	}

	function onAfterUpdate(_properties) {
		setMax()
		if (m.Count == 0) {
			m.Icon = "ui/perks/perk_19_sw.png";
		} else {
			m.Icon = "ui/perks/perk_19.png";
		}
	}
	
	function canDodge(skillToDodge) {
		if (skillToDodge.m.ActionPointCost > 4) {
			return m.Count > 1;
		} else {
			return m.Count > 0;
		}
	}

	function useToDodge(skillToDodge) {
		if (skillToDodge.m.ActionPointCost > 4) {
			m.Count -= 2;
		} else {
			m.Count -= 1;
		}
	}

	function onRoundEnd() {
		setMax();
		if (m.Count == -1) {
			m.Count = m.Max;
			this.logDebug(getActor().getName() + " has " + getActor().getFatigueMax() + " stamina and will therefore start with " + m.Count + " poise.");
		}
		m.Count += m.Refresh;
		if (m.Count > m.Max) {
			m.Count = m.Max;
		}
	}

	function isHidden()
	{
		return !this.getContainer().getActor().isPlacedOnMap();
	}
});

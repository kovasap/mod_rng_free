poise_effect <- inherit("scripts/skills/skill", {
	m = {
		Count = 1
		Max = 4
		Refresh = 2
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
		if (m.Count <= 1)
			return m.Name;
		else
			return m.Name + " (x" + m.Count + ")";
	}

	function getActorProperties() {
	  return getContainer().getActor().getCurrentProperties();
	}

	function setMax() {
		local def_sum = getActorProperties().MeleeDefense + getActorProperties().RangedDefense;
		m.Max = 2 + Math.floor(def_sum / 10);
	}

	function onAdded() {
		setMax();
		m.Count = m.Max;
	}

	function onRefresh() {
		getContainer().update();
	}

	function onUpdate(_properties) {
	}

	function onAfterUpdate(_properties) {
		setMax()
		if (getContainer().getActor().isArmedWithShield()) {
			m.Refresh = 3;
		}
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

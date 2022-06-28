

local tbDefault	= Npc:GetClass("default");

function tbDefault:OnDialog()
	local szMsg	= string.format("%s: Xin chào %s!", him.szName, me.szName);
	Dialog:Say(szMsg, {});
end;

function tbDefault:OnDeath(pNpcKiller)
end;

function tbDefault:OnTriggerBubble()
	local nBubbleGroupTotleWeight = self:GetBubbleGroupTotleWeight();
	if (nBubbleGroupTotleWeight <= 0) then
		return;
	end
	
	local nGroupRandom = MathRandom(nBubbleGroupTotleWeight);
	local nSum = 0;
	local tbSelectedBubble = nil;
	for _,item in pairs(Npc.BubbleProperty) do
		nSum = nSum + item.Weight;
		if (nSum >= nGroupRandom) then -- 选择了组
			if (not item.nIndex) then
				return;
			end
			
			tbSelectedBubble = self:GetSelectedBubble(item.nIndex);
			break;
		end
	end
	
	if (not tbSelectedBubble) then
		return;
	end
	
	if (tbSelectedBubble.tbConditions) then
		for _,cond in ipairs(tbSelectedBubble.tbConditions) do
			if (dostring(self:ReadBubbleConditionFaction(cond))() ~= 1) then
				return;
			end
		end
	end
		
	local szMsg = tbSelectedBubble.szMsg;
	
	him.SetBubble(szMsg);
	
	if (tbSelectedBubble.tbCallBacks) then
		for _,callback in ipairs(tbSelectedBubble.tbCallBacks) do
			Lib:CallBack(callback);
		end
	end
end


function tbDefault:GetBubbleGroupTotleWeight()
	local nSum = 0;
	for _,item in pairs(Npc.BubbleProperty) do
		nSum = nSum + item.Weight;
	end
	
	return nSum;
end

function tbDefault:GetSelectedBubble(nIndex)
	local tbBubbleGroup = self.tbBubble[nIndex];
	if (not tbBubbleGroup) then
		return;
	end
	local nItemTotleWeight = self:GetTotleWeightInSingleGroup(nIndex);
	if (nItemTotleWeight <= 0) then
		return;
	end
	
	local nBubbleRandom = MathRandom(nItemTotleWeight);
	local nSum = 0;
	for _, item in pairs(self.tbBubble[nIndex]) do
		nSum = nSum + item.nProbability;
		if (nSum >= nBubbleRandom) then
			return item;
		end
	end
end

function tbDefault:GetTotleWeightInSingleGroup(nIndex)
	local nSum = 0;
	if (not self.tbBubble[nIndex]) then
		print(nnIndex)
		assert(false);
	end
	for _, item in pairs(self.tbBubble[nIndex]) do
		nSum = nSum + item.nProbability;
	end
	
	return nSum
end

function tbDefault:ReadBubbleConditionFaction(tbFunction)
	local szFuncName	= "";
	local szFuncParam	= "";
	szFuncName = tbFunction[1];
	for i = 2, #tbFunction do
		szFuncParam	= table.concat(tbFunction[i], ",");	
	end

	return szFuncName.."("..szFuncParam..")";
end



local tbSeriesSkill	= {
	[Env.SERIES_NONE]	= 1,
	[Env.SERIES_METAL]	= 2,
	[Env.SERIES_WOOD]	= 3,
	[Env.SERIES_WATER]	= 4,
	[Env.SERIES_FIRE]	= 5,
	[Env.SERIES_EARTH]	= 6,
}
local function GetSkillId(nSeries, nLevel)
	return tbSeriesSkill[nSeries];
end;

tbDefault.tbLevelData	= {	-- 当NPC的ClassName为default时，调用一下技能数值脚本
	AIMode		= 4,	
	AIParam1	= 0,	
	AIParam2	= 0,
	AIParam3	= 0,	
	AIParam4	= 0,					
	AIParam5	= 0,
	AIParam6	= 0,
	AIParam7	= 0,
	AIParam8	= 0,
	AIParam9	= 0,
	AIParam10	= 0,	
	AIParam11	= 0,	
	
	Skill1				= 0,
	Level1				= 0,
	Skill2				= 0,
	Level2				= 0,
	Skill3				= 0,
	Level3				= 0,
	Skill4				= 0,
	Level4				= 0,
	Exp					= 0,
	Life				= 100,
	LifeReplenish		= 0,
	AR					= 0,
	Defense				= 0,
	MinDamage			= 0,
	MaxDamage			= 0,
	FireResist			= 0,
	ColdResist			= 0,
	LightResist			= 0,
	PoisonResist		= 0,
	PhysicsResist		= 0,
	PhysicalDamageBase	= 0,
	PhysicalMagicBase	= 0,
	PoisonDamageBase	= 0,
	PoisonMagicBase		= 0,
	ColdDamageBase		= 0,
	ColdMagicBase		= 0,
	FireDamageBase		= 0,
	FireMagicBase		= 0,
	LightingDamageBase	= 0,
	LightingMagicBase	= 0,
	AuraSkillId			= 0,
	AuraSkillLevel		= 0,
	PasstSkillId		= 0,
	PasstSkillLevel		= 0,
};

function tbDefault:no()
end

function tbDefault:cancel()
end

tbDefault.tbBubble = 
{
	[Npc.BubbleProperty.Normal.nIndex] 	= 
	{
		{
			nProbability = 1, 
			szMsg = "Xin chào <pic=1>, tìm ta có việc gì không?",
		},
		{
			nProbability = 1, 
			szMsg = "<pic=2> mong là ngươi không làm lãng phí thời gian của ta!",
		},
		{
			nProbability = 1,
			szMsg = "<pic=3> sự tuyệt vời của Kiếm Thế cần phải tận hưởng từ từ!",
		},
		{
			nProbability = 1,
			szMsg = "<pic=4> chào mừng đến với Kiếm Thế!",
		},
	},
}

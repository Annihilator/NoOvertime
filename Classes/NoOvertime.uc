// No Overtime
// Mutator for UT2004 by Annihilator
// Reuses code from:
// * End Game Mutator by SPDT
// * SmartCTF by ravimohan1991
// * UT2Vote by ProAsm

#exec OBJ LOAD FILE=..\Sounds\AnnouncerMain.uax

class NoOvertime extends Mutator;

function PostBeginPlay()
{
	local NoOvertimeGameRules G;
	
	Super.PostBeginPlay();
	G = spawn(class'NoOvertime.NoOvertimeGameRules');
	G.NOMut = self;
	if(Level.Game.GameRulesModifiers == None)
		Level.Game.GameRulesModifiers = G;
	else    
		Level.Game.GameRulesModifiers.AddGameRules(G);
}

function NOEndGame(PlayerController Admin, bool bForce)
{
	local Controller C;
	local PlayerController P;
	local name EndSound;
	local Sound EndSoundSound;
	local string sNick;

	EndSound = 'That_was_a_close_match';
	EndSoundSound = sound'AnnouncerMain.That_was_a_close_match';
	TeamGame(Level.Game).EndGameSoundName[0] = EndSound;
	TeamGame(Level.Game).EndGameSoundName[1] = EndSound;
	TeamGame(Level.Game).AltEndGameSoundName[0] = EndSound;
	TeamGame(Level.Game).AltEndGameSoundName[1] = EndSound;
	DeathMatch(Level.Game).RemainingTime = 0;
	Level.Game.GameReplicationInfo.RemainingTime = 0;
	Level.Game.GameReplicationInfo.RemainingMinute = 0;
	Level.Game.bGameEnded = True;
	C = Level.ControllerList;
	loop:
	if (C != None)
	{
		if (!C.IsA('ScriptedTriggerController'))
		{
			sNick = C.PlayerReplicationInfo.PlayerName;
			if ((MessagingSpectator(C) == None) && (sNick != "WebAdmin") && (sNick != "BullShit") && (sNick != "DemoRecSpectator"))
				if (C.IsA('PlayerController') || C.PlayerReplicationInfo.bBot)
				{
					C.ClientGameEnded();
					C.GameHasEnded();
					P = PlayerController(C);
					P.ClientPlaySound(EndSoundSound);
				}
		}
		C = C.nextController;
		goto loop;
	}
	Level.Game.TriggerEvent('EndGame',self,None);
	Level.Game.EndLogging("Draw");
	BroadcastLocalizedMessage(class'NoOvertimeDrawMessage');
	return;
}

defaultproperties
{
	bAddToServerPackages=False
	FriendlyName="No Overtime"
	Description="No Overtime Mutator"
}

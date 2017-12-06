package classes.Scenes {
import classes.CoC;
import classes.Scenes.Areas.*;
import classes.Scenes.Areas.Forest.KitsuneScene;
import classes.Scenes.Combat.Combat;
import classes.Scenes.Dungeons.D3.D3;
import classes.Scenes.Dungeons.DungeonEngine;
import classes.Scenes.Dungeons.HelDungeon.BrigidScene;
import classes.Scenes.Explore.*;
import classes.Scenes.Monsters.*;
import classes.Scenes.NPCs.*;
import classes.Scenes.Places.*;
import classes.Scenes.Quests.UrtaQuest;

public class SceneLib {
    public static var camp:Camp = new Camp(/*campInitialize*/);

    public static var combat:Combat = new Combat();

    public static var exploration:Exploration = new Exploration();

    public static var followerInteractions:FollowerInteractions = new FollowerInteractions();

    public static var inventory:Inventory = new Inventory(CoC.instance.saves);

    public static var masturbation:Masturbation = new Masturbation();

    public static var beach:Beach = new Beach();

    public static var blightridge:BlightRidge = new BlightRidge();

    public static var bog:Bog = new Bog();

    public static var deepsea:DeepSea = new DeepSea();

    public static var desert:Desert = new Desert();

    public static var forest:Forest = new Forest();

    public static var glacialRift:GlacialRift = new GlacialRift();

    public static var highMountains:HighMountains = new HighMountains();

    public static var lake:Lake = new Lake();

    public static var mountain:Mountain = new Mountain();

    public static var ocean:Ocean = new Ocean();

    public static var plains:Plains = new Plains();

    public static var swamp:Swamp = new Swamp();

    public static var volcanicCrag:VolcanicCrag = new VolcanicCrag();

    public static var brigidScene:BrigidScene = new BrigidScene();

    public static var d3:D3 = new D3();

    public static var gargoyle:Gargoyle = new Gargoyle();

    public static var lumi:Lumi = new Lumi();

    public static var giacomoShop:Giacomo = new Giacomo();

    public static var goblinScene:GoblinScene = new GoblinScene();

    public static var impScene:ImpScene = new ImpScene();

    public static var goblinAssassinScene:GoblinAssassinScene = new GoblinAssassinScene();

    public static var goblinWarriorScene:GoblinWarriorScene = new GoblinWarriorScene();

    public static var goblinShamanScene:GoblinShamanScene = new GoblinShamanScene();

    public static var goblinElderScene:GoblinElderScene = new GoblinElderScene();

    public static var amilyScene:AmilyScene = new AmilyScene();

    public static var anemoneScene:AnemoneScene = new AnemoneScene();

    public static var arianScene:ArianScene = new ArianScene();

    public static var ayaneFollower:AyaneFollower = new AyaneFollower();

    public static var ceraphScene:CeraphScene = new CeraphScene();

    public static var ceraphFollowerScene:CeraphFollowerScene = new CeraphFollowerScene();

    public static var chichiScene:ChiChiFollower = new ChiChiFollower();

    public static var ceaniScene:CeaniScene = new CeaniScene();

    public static var electraScene:ElectraFollower = new ElectraFollower();

    public static var emberScene:EmberScene = new EmberScene();

    public static var etnaScene:EtnaFollower = new EtnaFollower();

    public static var evangelineFollower:EvangelineFollower = new EvangelineFollower();

    public static var exgartuan:Exgartuan = new Exgartuan();

    public static var helFollower:HelFollower = new HelFollower();

    public static var helScene:HelScene = new HelScene();

    public static var helSpawnScene:HelSpawnScene = new HelSpawnScene();

    public static var holliScene:HolliScene = new HolliScene();

    public static var isabellaScene:IsabellaScene = new IsabellaScene();

    public static var isabellaFollowerScene:IsabellaFollowerScene = new IsabellaFollowerScene();

    public static var izmaScene:IzmaScene = new IzmaScene();

    public static var jojoScene:JojoScene = new JojoScene();

    public static var joyScene:JoyScene = new JoyScene();

    public static var kihaFollower:KihaFollower = new KihaFollower();

    public static var kihaScene:KihaScene = new KihaScene();

    public static var kindraFollower:KindraFollower = new KindraFollower();

    public static var latexGirl:LatexGirl = new LatexGirl();

    public static var marbleScene:MarbleScene = new MarbleScene();

    public static var marblePurification:MarblePurification = new MarblePurification();

    public static var milkWaifu:MilkWaifu = new MilkWaifu();

    public static var raphael:Raphael = new Raphael();

    public static var rathazul:Rathazul = new Rathazul();

    public static var sheilaScene:SheilaScene = new SheilaScene();

    public static var shouldraFollower:ShouldraFollower = new ShouldraFollower();

    public static var shouldraScene:ShouldraScene = new ShouldraScene();

    public static var sophieBimbo:SophieBimbo = new SophieBimbo();

    public static var sophieFollowerScene:SophieFollowerScene = new SophieFollowerScene();

    public static var sophieScene:SophieScene = new SophieScene();

    public static var tedScene:TedScenes = new TedScenes();

    public static var urta:Urta = new Urta();

    public static var urtaHeatRut:UrtaHeatRut = new UrtaHeatRut();

    public static var urtaPregs:UrtaPregs = new UrtaPregs();

    public static var valeria:Valeria = new Valeria();

    public static var vapula:Vapula = new Vapula();

    public static var bazaar:Bazaar = new Bazaar();

    public static var boat:Boat = new Boat();

    public static var farm:Farm = new Farm();

    public static var owca:Owca = new Owca();

    public static var telAdre:TelAdre = new TelAdre();

    public static var dungeons:DungeonEngine = new DungeonEngine();

    public static var ingnam:Ingnam = new Ingnam();

    public static var prison:Prison = new Prison();

    public static var hexindao:HeXinDao = new HeXinDao();

    public static var kitsuneScene:KitsuneScene = new KitsuneScene();

    public static var urtaQuest:UrtaQuest = new UrtaQuest();

    public static var debugMenu:DebugMenu = new DebugMenu();

    public static var soulforce:Soulforce = new Soulforce();

    public static var metamorph:Metamorph = new Metamorph();

    public static var crafting:Crafting = new Crafting();

    public function SceneLib() {
    }
}
}

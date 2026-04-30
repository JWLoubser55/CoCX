package classes.internals {
import classes.Appearance;
import classes.BaseContent;
import classes.BodyParts.*;
import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.IMutationPerkType;
import classes.ItemTemplate;
import classes.ItemType;
import classes.Items.*;
import classes.PerkLib;
import classes.PerkTree;
import classes.PerkType;
import classes.Player;
import classes.Race;
import classes.Stats.BuffableStat;
import classes.Stats.IStat;
import classes.Stats.PrimaryStat;
import classes.Stats.RawStat;
import classes.Stats.StatUtils;
import classes.StatusEffectType;
import classes.StatusEffects.CombatStatusEffect;
import classes.VaginaClass;

import coc.view.CoCLoader;

import flash.net.FileReference;
import flash.utils.ByteArray;

public class GamedataExporter extends BaseContent {
	public function GamedataExporter() {
	}
    public function exportGameData():void {
        var p:Player           = new Player();
        var k:String;
        var entry:Object;
        var subentry:Object;
        var file:FileReference = new FileReference();
        var bytes:ByteArray    = new ByteArray();
        // see devTools/saveEditor/js/gamedata.d.ts
        var gamedata:Object    = {
            version: CoC.instance.ver,
            versionNumber: CoC.instance.modSaveVersion,
            /* key: flag_id, value: IGDFlag */
            flags: {},
            /* key: perk_id, value: IGDPerk */
            perks: {},
            /* key: perk_id, value: IGDMutation */
            mutations: {},
            /* key: slot_id, value: IGDMutationSlot */
            mutation_slots: {
                "": {name: "Other"}
            },
            /* key: item_category, subkey: item_id, value: IGDItem */
            items: {
                armor: {},
                consumable: {},
                flyingsword: {},
                headjewelry: {},
                jewelry: {},
                miscjewelry: {},
                necklace: {},
                shield: {},
                /* value: IGDItemUndergarment */
                undergarment: {},
                useable: {},
                vehicle: {},
                weapon: {},
                weaponrange: {},

                other: {}
            },
            itemTemplates: {},
            // key: status_id
            statuses: {},
            // key: keyitem_id
            keyitems: {},
            // key: part
            // subkey: type_id
            bptypes: {
                antennae: {},
                arms: {},
                beard: {},
                claws: {},
                ears: {},
                eyes: {},
                face: {},
                gills: {},
                hair: {},
                hairstyle: {},
                horns: {},
                // extra properties: legCount, taur, noTail, tail
                legs: {},
                materials: {},
                rear: {},
                // extra properties: base, coat
                skin: {},
                // extra properties: base, coat
                pattern: {},
                tail: {},
                tongue: {},
                vagina: {},
                wings: {}
            },
            // value: { name:string, rgb:string }
            colors: [],
            // value: { id, name, type="primary"|"buffable"|"raw", isPercentage }
            stats: [],
            maxBreastCup: Appearance.BREAST_CUP_NAMES.length - 1,
            breastCups: Appearance.BREAST_CUP_NAMES,
            itemSlotCount: p.itemSlots.length
        };
        // flags
        for each(k in keys(kFLAGS, true)) {
            if (kFLAGS[k] is Number) {
                gamedata.flags[kFLAGS[k]] = {id: kFLAGS[k], name: k, desc: ""};
            }
        }
        // perks & mutations
        var monsterPerks:Array = PerkLib.enemyPerkList();
        var levelupPerks:Array = PerkTree.obtainablePerks();
        // perk requirement type -> list of extra properties
        const perkRequirementMappings:Object = {
            "custom":[],
            "level": ["value"],
            "attr": ["attr", "value"],
            "attr-lt": ["attr", "value"],
            "ng+": ["value"],
            "minlust": ["value"],
            "minsensitivity": ["value"],
            "soulforce": ["value"], // max soulforce
            "mana": ["value"], // max mana
            "venom_web": ["value"], // max venom/web
            "advanced": [], // free advanced job slot
            "prestige": [], // free prestige job slot
            "mutationslot": ["slot"],
            "dragonmutation": [], // free dragon mutation slot
            "kitsunemutation": [], // free kitsune mutation slot
            "hungerflag": [], // hunger enabled
            "effect": ["effect"],
            "race": ["race", "tier"],
            "anyrace": ["races"],
            "perk": ["perk"],
            "anyperk": ["perks"],
            "allperks": ["allperks"],
            "mutation": ["perk"]
        };
        function exportValue(v:*):* {
            if (v is StatusEffectType) {
                return (v as StatusEffectType).id;
            } else if (v is PerkType) {
                return (v as PerkType).id;
            } else if (v is Race) {
                return (v as Race).id;
            } else if (v is Array) {
                return v.map(varargify(exportValue));
            } else {
                return v;
            }
        }
        for (k in PerkType.getPerkLibrary()) {
            var pt:PerkType          = PerkType.lookupPerk(k);
            var mt:IMutationPerkType = pt as IMutationPerkType;
            var tags:Array           = [];
            if (mt) {
                gamedata.mutations[k] = {
                    id: k,
                    name: mt.name(null),
                    desc: mt.desc(null),
                    maxLevel: mt.maxLvl,
                    tags: tags,
                    slot: mt.slot
                }
            } else {
                if (monsterPerks.indexOf(pt) >= 0) tags.push('monster');
                else if (levelupPerks.indexOf(pt) >= 0) tags.push('levelup');
                else tags.push('unobtainable');
                entry = {
                    id: k,
                    name: pt.name(null),
                    desc: pt.desc(null),
                    tags: tags,
                    defaultValues: [pt.defaultValue1, pt.defaultValue2, pt.defaultValue3, pt.defaultValue4],
                    requirements: [],
                    unlocks: []
                };
                for each (var pt2:PerkType in CoC.instance.perkTree.listUnlocks(pt)) {
                    entry.unlocks.push(pt2.id);
                }
                for each (var r:Object in pt.requirements) {
                    subentry = {
                        text: r.text is String ? r.text : r.statictext,
                        type: r.type
                    };
                    if (r.type in perkRequirementMappings) {
                        for each (var k2:String in perkRequirementMappings[r.type]) {
                            subentry[k2] = exportValue(r[k2]);
                        }
                    }
                    entry.requirements.push(subentry);
                }
                gamedata.perks[k] = entry;
            }
        }
        // mutation slots
        for (k in IMutationPerkType.Slots) {
            gamedata.mutation_slots[k] = {id:k, name:IMutationPerkType.Slots[k].name};
        }
        // items
        for (k in ItemType.getItemLibrary()) {
            var it:ItemType = ItemType.lookupItem(k);
            var itemEffects:Array = [];
            for each (var ie:ItemEffect in it.itemEffects) {
                var jie:Object = {name:ie.type.name, power:ie.power};
                function sanitizeIEValue(value:*):* {
                    if (value is Race) return "Race["+(value as Race).name+"]"
                    return value;
                }
                if (ie.value1 !== undefined) jie.value1 = sanitizeIEValue(ie.value1);
                if (ie.value2 !== undefined) jie.value2 = sanitizeIEValue(ie.value2);
                if (ie.value3 !== undefined) jie.value3 = sanitizeIEValue(ie.value3);
                if (ie.value4 !== undefined) jie.value4 = sanitizeIEValue(ie.value4);
                itemEffects.push(jie);
            }
            entry = {name: it.longName, id: k, tags:keys(it.tags), effects:itemEffects};
            try {
                entry.desc = it.description;
            } catch (e:*) {
                entry.desc = '';
            }
            if (it is Armor) {
                entry.category = "armor";
                gamedata.items.armor[k] = entry;
            } else if (it is Consumable) {
                entry.category = "consumable";
                gamedata.items.consumable[k] = entry;
            } else if (it is FlyingSwords) {
                entry.category = "flyingsword";
                gamedata.items.flyingsword[k] = entry;
            } else if (it is HeadJewelry) {
                entry.category = "headjewelry";
                gamedata.items.headjewelry[k] = entry;
            } else if (it is Jewelry) {
                entry.category = "jewelry";
                gamedata.items.jewelry[k] = entry;
            } else if (it is MiscJewelry) {
                entry.category = "miscjewelry";
                gamedata.items.miscjewelry[k] = entry;
            } else if (it is Necklace) {
                entry.category = "necklace";
                gamedata.items.necklace[k] = entry;
            } else if (it is Shield) {
                entry.category = "shield";
                gamedata.items.shield[k] = entry;
            } else if (it is Undergarment) {
                entry.category = "undergarment";
                entry.type = (it as Undergarment).type;
                gamedata.items.undergarment[k] = entry;
            } else if (it is Vehicles) {
                entry.category = "vehicle";
                gamedata.items.vehicle[k] = entry;
            } else if (it is Weapon) {
                entry.category = "weapon";
                entry.type = (it as Weapon).type;
                entry.size = (it as Weapon).size;
                entry.dual = (it as Weapon).isDual();
                gamedata.items.weapon[k] = entry;
            } else if (it is WeaponRange) {
                entry.category = "weaponrange";
                gamedata.items.weaponrange[k] = entry;
            } else if (it is Useable) {
                entry.category = "useable";
                gamedata.items.useable[k] = entry;
            } else {
                entry.category = "other";
                gamedata.items.other[k] = entry;
            }
        }
        // item templates
        for (k in ItemTemplate.getLibrary()) {
            var tem:ItemTemplate = ItemTemplate.lookupTemplate(k);
            gamedata.itemTemplates[tem.templateId] = {
                id: tem.templateId,
                name: tem.name,
                metadata: deepCopy(tem.metadata)
            }
        }
        // statuses
        for (k in StatusEffectType.getStatusEffectLibrary()) {
            var st:StatusEffectType = StatusEffectType.lookupStatusEffect(k);
            gamedata.statuses[k] = {
                id: k,
                combat: st.create(0,0,0,0) is CombatStatusEffect
            }
        }
        // body part types
        // [target, enumValues, extraProperties]
        // extra props - array of propname or [nameInSource, nameInTarget]
        var bprec:Array = [
            [gamedata.bptypes.antennae, Antennae.Types],
            [gamedata.bptypes.arms, Arms.Types],
            [gamedata.bptypes.beard, Beard.Types],
            [gamedata.bptypes.claws, Claws.Types],
            [gamedata.bptypes.ears, Ears.Types],
            [gamedata.bptypes.eyes, Eyes.Types],
            [gamedata.bptypes.face, Face.Types],
            [gamedata.bptypes.gills, Gills.Types],
            [gamedata.bptypes.hair, Hair.Types],
            [gamedata.bptypes.hairstyle, Hair.Styles],
            [gamedata.bptypes.horns, Horns.Types],
            [gamedata.bptypes.legs, LowerBody.Types, ["legCount","canTaur","noTail","tail"]],
            [gamedata.bptypes.materials, BodyMaterial.Types],
            [gamedata.bptypes.rear, RearBody.Types],
            [gamedata.bptypes.skin, Skin.SkinTypes, ["base","coat",["name","desc"],"adj"]],
            [gamedata.bptypes.pattern, Skin.PatternTypes, ["base","coat"]],
            [gamedata.bptypes.tail, Tail.Types],
            [gamedata.bptypes.tongue, Tongue.Types],
            [gamedata.bptypes.vagina, VaginaClass.Types],
            [gamedata.bptypes.wings, Wings.Types, ["desc"]]
        ];
        for each (var a:Array in bprec) {
            // a = [ target, EnumValue[], extra_props ]
            for each (var ev:Object in a[1]) {
                if (!ev) continue;
                entry = {
                    value: ev.value,
                    name: ev.name,
                    id: ev.id
                };
                if (a[2]) {
                    for each (var o:* in a[2]) {
                        if (o is Array) {
                            // [exported_name, enumvalue_name]
                            entry[o[1]] = ev[o[0]]
                        } else {
                            entry[o] = ev[o];
                        }
                    }
                }
                a[0][ev.value] = entry;
            }
        }
        // colors
        var model:XML = XML(CoCLoader.getEmbedText("res/model.xml"));
        var map:Object = {}
        for each(var prop:XML in model.palette.property) {
            for each (var color:XML in prop.color) {
                k = color.@name.toString();
                map[k] = {
                    name: k,
                    rgb: color.text().toString()
                };
            }
        }
        for each(color in model.palette.common.color) {
            k = color.@name.toString();
            map[k] = {
                name: k,
                rgb: color.text().toString()
            };
        }
        gamedata.colors = values(map).sort();
        // stats
        for each (var stat:IStat in p.statStore.allStats()) {
            entry = {
                id: stat.statName,
                name: StatUtils.nameOfStat(stat.statName),
                isPercentage: StatUtils.isPercentageStat(stat.statName)
            };
            if (stat is BuffableStat) {
                entry.type = "buffable";
                entry.base = (stat as BuffableStat).base;
                entry.aggregate = (stat as BuffableStat).aggregate;
            } else if (stat is RawStat) {
                entry.type = "raw";
            } else if (stat is PrimaryStat) {
                entry.type = "primary";
            } else {
                entry.type = "unknown"
            }
            gamedata.stats.push(entry);
        }

        bytes.writeUTFBytes(
                "// GENERATED FOR " + CoC.instance.version + "\n" +
                "/** @type {IExportedGameData} */\n" +
                "let ExportedGamedata=");
        bytes.writeUTFBytes(JSON.stringify(gamedata));
        file.save(bytes, "gamedata.js");
    }
}
}

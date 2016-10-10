//
//  LevelThreeQuestion.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/26/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
enum LevelThreeQuestion:Int {
    
    init()
    {
        self = .QuestionOne
    }
    
    init?(number:Int)
    {
        switch number
        {
        case 0: self = .NilQuestion
        case 1: self = .QuestionOne
        case 2: self = .QuestionTwo
        case 3: self = .QuestionThree
        case 4: self = .QuestionFour
        case 5: self = .QuestionFive
        case 6: self = .QuestionSix
        case 7: self = .QuestionSeven
        case 8: self = .QuestionEight
        case 9: self = .QuestionNine
        case 10: self = .QuestionTen
        default:
            return nil
        }
    }
    
    case NilQuestion=0, QuestionOne, QuestionTwo, QuestionThree, QuestionFour, QuestionFive, QuestionSix, QuestionSeven, QuestionEight, QuestionNine, QuestionTen
    
    var imageName:String {
        get {
            
            switch self
            {
                case .NilQuestion: return "nil"
                case .QuestionOne: return "L3-S1-morphine-final"
                case .QuestionTwo: return "L3-S2-acetone-final"
                case .QuestionThree: return "L3-S3-coniine-final"
                case .QuestionFour: return "L3-S4-muscarine-final"
                case .QuestionFive: return "L3-S5-cadaverine-final"
                case .QuestionSix: return "L3-S6-piperine-final"
                case .QuestionSeven: return "L3-S7-diethylether-final"
                case .QuestionEight: return "L3-S8-Vanillin-final"
                case .QuestionNine: return "L3-S9-capsaicin-final"
                case .QuestionTen: return "L3-S10-aceticacid-final"
            }
        }
    }
    
    var imageSol:String {
        get
        {
            return self.imageName.stringByAppendingString("solution")
        }
        
    }
    
    var solutions:[String] {
        get {
            switch self {
                case .NilQuestion: return []
                case .QuestionOne: return ["h-bonding", "vanderwaals", "ionic"]
                case .QuestionTwo: return ["dipole-dipole"]
                case .QuestionThree: return ["h-bonding"]
                case .QuestionFour: return ["ionic", "h-bonding"]
                case .QuestionFive: return ["h-bonding", "h-bonding"]
                case .QuestionSix: return ["vanderwaals", "vanderwaals"]
                case .QuestionSeven: return ["dipole-dipole"]
                case .QuestionEight: return ["h-bonding", "vanderwaals", "dipole-dipole"]
                case .QuestionNine: return ["h-bonding", "dipole-dipole", "h-bonding", "vanderwaals", "vanderwaals"]
                case .QuestionTen: return ["h-bonding"]
            }
        }
    }
    
    var itemName:String {
        get {
            switch self {
            case .QuestionOne: return "Morphine"
            case .QuestionTwo: return "Acetone"
            case .QuestionThree: return "Coniine"
            case .QuestionFour: return "Muscarine"
            case .QuestionFive: return "Cadaverine"
            case .QuestionSix: return "Piperine"
            case .QuestionSeven: return "Diethylether"
            case .QuestionEight: return "Vanillin"
            case .QuestionNine: return "Capsaicin"
            case .QuestionTen: return "Acetic acid"
            default:
                return ""
            }
        }
    }
    var positionsIpad:[Position] {
        get {
            switch self {
            case .NilQuestion: return []
            case .QuestionOne: return [Position(x: 0.214, y: 0.813), Position(x: 0.522, y: 0.627), Position(x: 0.565, y: 0.399)]//done1
            case .QuestionTwo: return [Position(x:0.41, y:0.53)]//done1
            case .QuestionThree: return [Position(x:0.479, y:0.586)]//done1
            case .QuestionFour: return [Position(x:0.168, y:0.773), Position(x:0.573, y:0.252)]//done1
            case .QuestionFive: return [Position(x:0.15, y:0.602), Position(x:0.591, y:0.401)]//dne1
            case .QuestionSix: return [Position(x:0.311, y:0.649), Position(x:0.217, y:0.358)]//done1
            case .QuestionSeven: return [Position(x:0.45, y:0.50)]//done1
            case .QuestionEight: return [Position(x:0.165, y:0.726),Position(x:0.417, y:0.677),Position(x:0.554, y:0.288)]//done1
            case .QuestionNine: return [Position(x:0.427, y:0.774),Position(x:0.609, y:0.751),Position(x:0.099, y:0.642),Position(x:0.37, y:0.50),Position(x:0.389, y:0.375)]//done1
            case .QuestionTen: return [Position(x:0.36, y:0.38)]//done1
            }
        }
    }
    
    var positions:[Position] {
        get {
            switch self {
            case .NilQuestion: return []
            case .QuestionOne: return [Position(x: 0.256, y: 0.821), Position(x: 0.505, y: 0.630), Position(x: 0.55, y: 0.40)]//done
            case .QuestionTwo: return [Position(x:0.41, y:0.53)]//done
            case .QuestionThree: return [Position(x:0.48, y:0.62)]
            case .QuestionFour: return [Position(x:0.205, y:0.799), Position(x:0.54, y:0.22)]//done
            case .QuestionFive: return [Position(x:0.15, y:0.62), Position(x:0.59, y:0.38)]
            case .QuestionSix: return [Position(x:0.309, y:0.690), Position(x:0.21, y:0.31)]//done
            case .QuestionSeven: return [Position(x:0.45, y:0.50)]
            case .QuestionEight: return [Position(x:0.17, y:0.778),Position(x:0.44, y:0.71),Position(x:0.54, y:0.23)]
            case .QuestionNine: return [Position(x:0.415, y:0.80),Position(x:0.566, y:0.76),Position(x:0.14, y:0.645),Position(x:0.37, y:0.50),Position(x:0.37, y:0.369)]//done
            case .QuestionTen: return [Position(x:0.36, y:0.38)]//done
            }
        }
    }
    
    var facts:[String] {
        get {
            switch self {
            case .NilQuestion: return []
            case .QuestionOne: return["Morphine binds to its receptor in the body by 3 interactions: a van der Waal’s, a hydrogen bond and an ionic bond.","Morphine (Opium) was used as a narcotic in Sumerian cultures in Asia Minor as early as 4000 B.C.","The Swiss physician (and alchemist) Paracelsus (1493-1541) popularized Opium/Morphine use in Europe with the introduction of laudanum, a tincture, or alcoholic solution, of opium.","Morphine has a pentacyclic structure with a benzylisoquinoline nucleus supporting ether, hydroxyl, and olefinic functions.","Morphine is extracted from opium in a series of extraction and purification steps involving water, organic solvents, and pH adjustments.","Opioid analgesics, including morphine and codeine, all have an aromatic ring and a quaternary carbon atom linked to a tertiary amine group by two other carbon atoms. This is known as the morphine rule.","Morphine is commercially available in a variety of products as the free base monohydrate and as hydrochloride, sulphate, tartrate, and other salts.","Investigators learned about morphine’s mode of action by applying it and other opiates to guinea-pig intestines (a case of nominative determinism perhaps).","In the late 1800s, hoping to come up with a non-addictive painkiller, the Bayer chemical company tried to acetylate both morphine’s hydroxyl groups (in a similar way to how salicylic acid was converted to into aspirin). Sadly, they invented heroin in the process.","Early attempts to unlock the mysteries of opium and morphine provided a major stimulus to the development of organic chemistry."]

            case .QuestionTwo: return ["Acetone is commonly found as the active ingredient in a number of household products including nail polish remover and paint thinner.","Acetone has been proposed as a fuel additive; the idea is that a small amount helps vaporize the gasoline, leading to better fuel efficiency.","Acetone is one of three ketone bodies that occur naturally throughout the body. It can be formed endogenously in the mammalian body from fatty acid oxidation via decarboxylation of ketone bodies.","Acetone is a colourless, volatile, flammable liquid, and is the simplest ketone.","Acetone was the name of an American alternative rock band formed in 1992 in Los Angeles, California. They toured with British band 'The Verve' for a while.","Most acetone is made during the production of phenol.  Phenol is mostly used to make polymers like plastics; it was also the first antiseptic to be discovered.","Acetone is a very popular and versatile chemical than often goes 'missing' in organic chemistry labs. Some people get round this by relabeling the bottles dimethyl ketone, 2-propanone, or beta-ketopropane.","The German chemist August Kekulé published the modern structural formula for acetone in 1865.","Acetone is used as a polar, aprotic solvent in a variety of organic reactions, such as SN2 reactions.","Acetone is a common building block in organic chemistry and is also well used by organic chemists for cleaning glassware."]
                
            case .QuestionThree: return ["Coniine is a poisonous alkaloid found in the poison hemlock (Conium maculatum) and several other plants. Less than 0.1-0.2g is fatal to humans, with death caused by respiratory paralysis.","Coniine is the poison used to kill Amyas Crale in Five Little Pigs, one of Agatha Christie's Hercule Poirot mysteries, published in 1943.","Coniine is one of the simplest alkaloids and was the first to be synthesized (by Albert Ladenburg in 1886).","Coniine has two stereoisomers: (S)-(+)-coniine, and (R)-(−)-coniine; interestingly, these enantiomers do not have identical biological properties.","Since Coniine affects the nervous system, it has been used in the past as a sedative and to calm muscle spasms.","Coniine can be detected via colour test. The addition of sodium nitroprusside (Na2[Fe(CN)5NO],) to diluted Coniine forms a complex that gives a red colour to the solution. Because Coniine is less soluble in hot water than cold water the colour fades after boiling but returns after cooling.","Coniine is a piperidine alkaloid, (based on the piperidine structure); its chemical name is 2-propyl piperidine.","Pure coniine is a colourless, oily liquid with a bitter taste and unpleasant odour.","Coniine paralyses muscles by blocking the nicotinic receptor on the post-synaptic membrane of the neuromuscular junction. Symptoms of paralysis occur within a half-hour, but death may take several hours.","Coniine's molecular formula is C8H17N. It has an average mass of 127.227 amu and a monoisotopic mass 127.136101 amu."]
                
            case .QuestionFour: return ["Ionic boding is important in biological systems for such things as drug-receptor interactions.","Muscarine can form an ionic type intermolecular bond with a negatively charged atom or ion.","There are three chiral centres in Muscarine and thus four possible pairs of enantiomers.","Infrared spectroscopy was used to show that the hydroxyl group of Muscarine was located in the tetrahydrofuran ring and not in the side chain.","Muscarine is one of many mushroom toxins. It is produced by many specied of the Inocybe and Clitocybe genera (e.g., Inocybe geophylla, Clitocybe dealbata).","Muscarine mimics the action of the neurotransmitter acetylcholine by binding muscarinic acetylcholine receptors. These receptors were actually named after muscarine.","Muscarine can be synthesized in various ways and from many different starting materials, particularly from 2,5-dimethyl-3-carboxymethyl flurane.","Muscarine is a the quaternary trimethylammonium salt of 2-methyl-3-hydroxy-5-(aminomethyl)tetrahydrofuran.","As a quaternary trimethylammonium salt Muscarine is less completely absorbed from the gastrointestinal tract than tertiary amines (although it can cross the blood-brain barrier).","Muscarine was first extracted from Amanita muscaria in 1869, but this mushroom does not contain enough muscarine to cause toxicity."]
                
            case .QuestionFive: return ["Cadaverine (pentane-1,5-diamine) and Putrescine (butane-1,4-diamine) are foul-smelling compounds produced when amino acids decompose in decaying (dead) animals. They are also found in small amounts in living cells.","Cadaverine is produced in the body (and after death) by the decarboxylation of lysine.","Wild Tasmanian devils (Sarcophilus harrisii) often have high levels of Cadaverine in their blood since carrion forms a large part if their diet.","Cadaverine is palindromic in chemical structure (if not in name).","Cadaverine is a colourless to light yellow liquid with a very unpleasant smell","Cadaverine can be made at home (at your own risk!) by heating lysine in a glass container with a small amount of sodium bicarbonate (baking soda). Just don't smell the end product, it has a very strong smell and is hard to get rid of.","Alternative names for Cadaverine include 1,5-Diaminopentane and 1,5-Pentamethylenediamine.","Cadaverine and the related compound Putrescine were was first described in 1885 by the Berlin physician Ludwig Brieger.","Cadaverine is used in the production of polymers, as a chemical intermediate, and in biological research.","Because cadaverine smells so bad and is produced in dead bodies it is used as a tool for training search and rescue dogs."]
            case .QuestionSix: return ["Piperine, and its isomers, are the compounds responsible for the strong, sharp smell and taste of black pepper. It has also has been used as an organic insecticide.","The full chemical name of Piperine is 1-[5-(1,3-Benzodioxol-5-yl)-1-oxo-2,4-pentadienyl]piperidine.","Piperine has four diastereomeric geometric isomers.","Pepper (and thus piperine) has been used as a spice in India for over 4000 years.","Despite being found in black pepper piperine itself is a yellow powder.","Piperine can irritate nerve ending in the nose, which is why black pepper can cause sneezing.","Piperine is slightly soluble in water and more so in alcohol, ether or chloroform the solution in alcohol has a pepper-like taste.","Australian researchers have shown that the drug 3,4-methylenedioxy-N-methylamphetamine (MDMA or ecstasy) can be made from piperine (and vanillin).","Piperine yields salts only with strong acids.","Piperine was discovered in 1819 by the Danish physicist and chemist Hans Christian Ørsted - who also discovered that electric currents create magnetic fields."]
                
            case .QuestionSeven: return ["Diethyl ether is a colourless, volatile, highly flammable chemical with a powerful, characteristic odour and a hot, sweetish taste.","Diethyl ether sometimes finds use as a recreational drug due to its dissociative and euphoric effects, quick onset of effects and its short-lived nature.","During prohibition era America (1920-1933), Diethyl Ether consumption surfaced as an alternative to alcohol.","Ethyl ether is manufactured by the distillation of ethyl alcohol with sulphuric acid. Pure ether is prepared by washing the crude ether with a saturated aqueous solution of calcium chloride, then treating with sodium.","Ethyl ether is an excellent solvent for extractions and for a wide variety of chemical reactions.  It is particularly important in the production of cellulose plastics such as cellulose acetate.","Because ether molecules cannot engage in hydrogen bonding with each other they have much lower boiling points than do alcohols with similar molecular weights.","The unique properties of ethers (i.e., that they are strongly polar, with nonbonding electron pairs but no hydroxyl group) enhance the formation and use of many reagents. For example, Grignard reagents cannot form unless an ether is present to share its lone pair of electrons with the magnesium atom.","Diethyl ether is often called just ethyl ether, it is used as a solvent as well as in various household products such as engine starting fluid.","Other names for Diethyl ether include Dether, Solvent ether, Ethyl ether, Ethyl oxide, 3-Oxapentane, Ethoxyethane and Diethyl oxide.","Diethyl ether has limited solubility in water and this, coupled with its high volatility, makes it ideal for use as the non-polar solvent in liquid-liquid extractions."]
                
            case .QuestionEight: return ["The strongest type of intermolecular force that vanillin can make is a hydrogen bond.","The strongest type of intermolecular forces present between molecules of Vanillin are hydrogen bonds.","Molecular features of Vanillin, including hydrophobicity, efficacy for forming hydrogen bonds and a reactive carbonyl group.","π- π stacking of aromatic rings in vanillin, stemming from the innate hydrophobicity of aromatic compounds contributes to the tendency of vanillin to form aggregates.","As it gives coloured spots with a range of different compounds acidic solutions of vanillin in ethanol are often used as a developing (visualising) agents for thin layer chromatography plates.","Vanillin is widely used in chemical synthesis, for example in the manufacture of L-dopa, for treatment of Parkinson's disease, of the antibacterial compound trimethoprim, and of the heart drug papaverin.","Small molecules such as vanillin and guiaicol are formed when wood is burnt at low temperatures and are responsible for the smell and taste of smoked food.","Vanillin is a phenolic aldehyde. Its functional groups include an aldehyde, a hydroxyl group and an ether.","Vanillin can be made from Lignin from wood. In 1981, a single paper mill in Thorold, Ontario supplied 60% of the world market for synthetic vanillin.","Vanillin can trigger allergic reactions, as well as migraine headaches in some people."]
                
            case .QuestionNine: return ["Capsaicin displays cis/trans isomerism because the double bond prevents internal rotation.","Regions of the Capsaicin molecule include an aromatic ring, an amide bond and a hydrophobic side chain.","Experiments have estimated that in mice, the median lethal dose of Capsaicin is around 47.2mg/kg. The large amount needed and the low concentration of capsaicin in chilli makes accidental poisoning by chilli consumption in humans exceedingly unlikely however.","Capsaicin is currently used in concentrations of between 0.025% and 0.075% in topical ointments to relieve the pain caused by shingles.","Capsaicin (at, at least 1% concentration) is the active ingredient in the chemical riot control agent pepper spray.","Contrary to popular belief, the highest concentration of Capsaicin, therefore the majority of the heat, is to be found in the placenta of the chilli fruit, not the seeds (which are often bitter).","Chemists have been working on using capsaicinoid derivatives not found naturally to quantify capsaicinoid compounds present in chilli peppers.","Chillies have been eaten since at least 7000 B.C. in South America, and at one point were apparently used as currency.","Capsaicinoids can be isolated (at your own risk!) from crushed/powdered chillies using ethanol extraction for 24 hours followed by filtration, evaporation and precipitation to yield a brick-red oil which is about 40% Capsaicin, and about 60% other capsaicinoids.","The Mayans had a word 'Huuyub' meaning 'to draw breath with a puckered mouth after eating chillies'."]
                
            case .QuestionTen: return ["Acetic acid, systematically named ethanoic acid, is the second simplest carboxylic acid.","Vinegar is actually a solution of 4-8% of acetic acid that is dissolved in water and other substances.","In the popular volcano science experiment seen in many schools the 'lava' is Acetic acid in vinegar reacting with baking soda coloured with red food dye.","Water free acetic acid is sometimes called glacial acetic acid. The German name for this is Eisessig (literally, ice-vinegar).","The term acetate is used when referring to the carboxylate anion (CH3COO-) or any of the salts or esters of acetic acid.","In households, diluted acetic acid is often used in descaling agents.","The most common and official abbreviation for acetic acid is AcOH or HOAc where Ac stands for the acetyl group (not the chemical element actinium).","The presence of water in vinegar has such a profound effect on acetic acid's properties that for centuries many chemists believed that glacial (water free) acetic acid and the acid found in vinegar were two different substances.","Acetic acid is corrosive to many metals including iron, magnesium, and zinc, forming hydrogen gas and metal salts called acetates.","Liquid acetic acid is a hydrophilic (polar) protic solvent, similar to ethanol and water. It can dissolve both polar compounds and non-polar compounds."]
                
            }
        }
    }
    
    static func getQuestions() ->[LevelThreeQuestion] {
        return [QuestionOne, QuestionTwo, QuestionThree, QuestionFour, QuestionFive, QuestionSix,
                QuestionSeven, QuestionEight, QuestionNine, QuestionTen, NilQuestion]
    }
    
}

//
//  LevelOneModel.swift
//  Rmitium
//
//  Created by Thinh Tran on 17/08/2016.
//  Copyright © 2016 Spencer and Jones. All rights reserved.
//

import Foundation

enum LevelOneQuestion:Int{
    
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
        default:
            return nil
        }
    }
    
    case NilQuestion=0, QuestionOne=1, QuestionTwo, QuestionThree, QuestionFour, QuestionFive, QuestionSix, QuestionSeven,QuestionEight, QuestionNine
    
    var imageName:String{
        get{
            
           switch self
           {
           case .NilQuestion: return "nil"
           case .QuestionOne: return "S1-morphine-final"
           case .QuestionTwo: return "S2-meropenem-final"
           case .QuestionThree: return "S3-theobromine-final"
           case .QuestionFour: return "S4-muscarine-final"
           case .QuestionFive: return "S5-diltazem-final"
           case .QuestionSix: return "S6-quinine-final"
           case .QuestionSeven: return "S7-Tamiflu-final"
           case .QuestionEight: return "S8-Vanillin-final"
           case .QuestionNine: return "S9-capsaicin-final"
            }
        }
    }
    var itemName:String{
        
        get{
        
            switch self {
            case .QuestionOne: return "Morphine"
            case .QuestionTwo: return "Meropenem"
            case .QuestionThree: return "Theobromine"
            case .QuestionFour: return "Muscarine"
            case .QuestionFive: return "Diltazem"
            case .QuestionSix: return "Quinine"
            case .QuestionSeven: return "Tamiflu"
            case .QuestionEight: return "Vanillin"
            case .QuestionNine: return "Capsaicin"
            default:
                return ""
            }
        }
    }
    
    var imageSol:String
        {
        get
        {
            return self.imageName.stringByAppendingString("solution")
        }
        
    }
    
    var solutions:[String]{
        get {
            switch self {
            case .NilQuestion: return ["nil"]
            case .QuestionOne: return ["phenol","ether","amine","alcohol","alkene"]
            case .QuestionTwo: return ["acid","amide","thioether","alcohol","alkene","amine","amide"]
            case .QuestionThree: return ["amide","amine","amide","amine"]
            case .QuestionFour: return ["amine","ether","alcohol"]
            case .QuestionFive: return ["ether","thioether","ester","amide","amine"]
            case .QuestionSix: return ["alkene","amine","alcohol","ether"]
            case .QuestionSeven: return ["ether","alkene","acid","amide","amine"]
            case .QuestionEight: return ["phenol","ether","aldehyde"]
            case .QuestionNine: return ["phenol","amide","ether","alkene"]
            }
        }
    }
    var positionsIpad:[Position]{
        get {
            switch self {
            case .NilQuestion: return []
            case .QuestionOne: return [Position(x:0.30,y: 0.80),Position(x:0.160,y: 0.488), Position(x:0.551,y: 0.380),Position(x:0.127 ,y: 0.263),Position(x:0.405,y: 0.205)]//done1
            case .QuestionTwo: return [Position(x:0.329,y: 0.804),Position(x:0.213,y: 0.729),Position(x:0.41,y: 0.649),Position(x:0.114,y: 0.440),Position(x:0.285,y: 0.404),Position(x:0.559,y: 0.457),Position(x:0.451,y: 0.185)]//done1
            case .QuestionThree: return [Position(x:0.19,y: 0.73),Position(x:0.519,y: 0.782),Position(x:0.183,y: 0.221),Position(x:0.506,y: 0.31)]//done1
            case .QuestionFour: return [Position(x:0.145,y: 0.78),Position(x:0.367,y: 0.669),Position(x:0.558,y: 0.223)]//done1
            case .QuestionFive: return [Position(x:0.44,y: 0.815),Position(x:0.285,y: 0.63),Position(x:0.47,y: 0.55),Position(x:0.36,y: 0.34),Position(x:0.273,y: 0.192)]//done1
            case .QuestionSix: return [Position(x:0.134,y: 0.80),Position(x:0.469,y: 0.760),Position(x:0.551,y: 0.667),Position(x:0.19,y: 0.51)]//done1
            case .QuestionSeven: return [Position(x:0.218,y: 0.696),Position(x:0.387,y: 0.665),Position(x:0.492,y: 0.494),Position(x:0.079,y: 0.371),Position(x:0.441,y: 0.342)]//done1
            case .QuestionEight: return [Position(x:0.259,y: 0.755),Position(x:0.141,y: 0.251),Position(x:0.548,y: 0.251)]//done1
            case .QuestionNine: return [Position(x:0.220,y: 0.779),Position(x:0.431,y: 0.815),Position(x:0.145,y: 0.504),Position(x:0.372,y: 0.359)]//done1
            }
        }
    }
    var positions:[Position]{
        get {
            switch self {
            case .NilQuestion: return []
            case .QuestionOne: return [Position(x:0.30,y: 0.80),Position(x:0.19,y: 0.48), Position(x:0.505,y: 0.388),Position(x:0.168 ,y: 0.258),Position(x:0.384,y: 0.19)]//done
            case .QuestionTwo: return [Position(x:0.329,y: 0.804),Position(x:0.23,y: 0.74),Position(x:0.41,y: 0.649),Position(x:0.14,y: 0.43),Position(x:0.30,y: 0.40),Position(x:0.52,y: 0.45),Position(x:0.41,y: 0.18)]//done
            case .QuestionThree: return [Position(x:0.19,y: 0.73),Position(x:0.47,y: 0.785),Position(x:0.218,y: 0.217),Position(x:0.46,y: 0.30)]//done
            case .QuestionFour: return [Position(x:0.19,y: 0.78),Position(x:0.36,y: 0.67),Position(x:0.51,y: 0.22)]//done
            case .QuestionFive: return [Position(x:0.41,y: 0.81),Position(x:0.285,y: 0.63),Position(x:0.47,y: 0.55),Position(x:0.36,y: 0.34),Position(x:0.295,y: 0.18)]//done
            case .QuestionSix: return [Position(x:0.17,y: 0.80),Position(x:0.43,y: 0.77),Position(x:0.49,y: 0.68),Position(x:0.226,y: 0.518)]//done
            case .QuestionSeven: return [Position(x:0.218,y: 0.74),Position(x:0.386,y: 0.742),Position(x:0.492,y: 0.494),Position(x:0.08,y: 0.33),Position(x:0.44,y: 0.29)]//done
            case .QuestionEight: return [Position(x:0.27,y: 0.77),Position(x:0.16,y: 0.23),Position(x:0.51,y: 0.23)]//done
            case .QuestionNine: return [Position(x:0.249,y: 0.777),Position(x:0.406,y: 0.820),Position(x:0.177,y: 0.50),Position(x:0.35,y: 0.36)]//done
            }
        }
    }
    
    var facts:[String]{
        get {
            switch self{
            case .NilQuestion: return []
            case .QuestionOne: return["Morphine has a high potential for addiction; during the American Civil War, around 400 000 soldiers became addicted to morphine.","Morphine is primarily used to treat both acute and chronic pain.","Morphine comes from the opium poppy (which is also a valuable ornamental plant) but is also produced synthetically.","Morphine is the most abundant of opium’s 24 alkaloids, accounting for 9 to 14% of opium-extract by mass.","Morphine is named after Morpheus, the Roman god of dreams (who also later became the god of slumber).","Less popular and less mentioned effects of Morphine use include nausea, vomiting and decreased gastrointestinal motility.","Only 1g of Morphine hydrate will dissolve In 5L of water so pharmaceutical companies produce sulphate and hydrochloride salts of the drug that are over 300 times more water-soluble.","The three dimensional structure of morphine consists of five rings, three of which are approximately in the same plane; the other two are each at right angles to this trio.","If you substitute morphine’s methyl group with a propenyl group, you create nalorphine, an antagonist which counters morphine’s effects.","Morphine is a precursor for producing heroin, which can be produced by adding two acetyl groups to the molecule morphine."]
            case .QuestionTwo: return ["Meropenum (hydrate) is an ultra-broad spectrum injectable antibiotic.","Meropenum is used to treat a wide variety of infections, including meningitis and pneumonia.","Meropenem is a beta-lactam and hence is related to the penicillins.","A remarkable feature of MEROPEN® agent is that it is much less toxic than other carbapenem antibiotics.","In contrast to other beta-lactam antibiotics, Meropenum is highly resistant to degradation by bacterial enzymes such as β-lactamases or cephalosporinases.","Meropenem exerts its antibacterial activity by penetrating bacterial cells readily and interfering with the synthesis of vital cell wall components.","Meropenem is a carbapenem antibiotic; other compounds in this class include imipenem and ertapenem.","Meropenem must be administered intravenously.","Meropenem has a complex chemical structure with 6 asymmetric carbons and a total of 64 stereo- and optical- isomers despite being a comparatively small molecule (molecular weight: 437.51 amu).","Meropenem was originally developed by Dainippon Sumitomo Pharma of Japan."]
            case .QuestionThree: return ["Theobromine is sometimes known as xantheose.","Theobromine belongs to a class of alkaloid molecules known as methylxanthines.","Theobromine affects humans similarly to caffeine, but on a much smaller scale.","If you N-methylate theobromine (via SN2 substitution) you get caffeine.","Different types of chocolate contain different amounts of theobromine. In general, theobromine levels are higher in dark chocolates (approximately 10 g/kg) than in milk chocolates (1-5 g/kg).","Theobromine containing chocolate products may be toxic or lethal to dogs and other domestic animals such as horses because these animals metabolize theobromine more slowly than humans.","Despite its name, theobromine contains no bromine—the name comes from Theobroma, the name of the genus of the cacao tree.","Although usually found in chocolate, pure theobromine is white or colourless.","Theobromine was formerly used as a diuretic and in the treatment of angina and hypertension.","Theobromine has also been shown to improve the microhardness of tooth enamel, which could potentiality increase resistance to tooth decay."]
            case .QuestionFour: return ["Muscarine is a toxic component of a number of mushroom species.","Muscarine was first isolated from Amanita muscaria (fly agaric) by German chemists Oswald Schmiedeberg and Richard Koppe in 1869.","Muscarine mimics the function of the natural neurotransmitter acetylcholine in the 'muscarinic' part of the cholinergic nervous system, despite the less flexible structure due to the five-membered ring which acetylcholine does not have.","There are two mirror forms of muscarine, named: 2S-muscarine and 2R- muscarine.","The specific antidote for Muscarine poisoning is atropine. Atropine inhibits acetylcholine and thus muscarine by binding to muscarinic receptors.","Muscarine is toxic and causes profound activation of the parasympathetic nervous system that may end in convulsions and death.","Muscarine is a foundation stone of modern pharmacology, being one of the first substances known which reproduced some of the responses to stimulation of the parasympathetic nervous system.","The lethal dose of muscarine for humans is not precisely known, with estimates ranging from 40 mg to 495 mg.","Muscarine is similar to acetylcholine but as it does not contain an ester linkage it is not metabolised by the cholinesterase enzyme in the body.","Muscarine is a quaternary ammonium salt."]
            case .QuestionFive: return ["Diltiazem is used to treat high blood pressure and to control chest pain (angina).","Diltiazem is a calcium channel blocker. It works by relaxing the muscles of the heart and blood vessels.","Grapefruit and grapefruit juice may interact with Diltiazem and lead to unwanted side effects.","Diltiazem is a common adulterant of cocaine seized in the UK.","Diltiazem is teratogenic* (*any agent that can disturb the development of an embryo or fetus)","Diltiazim is a derivative of benzothiazepine.","Diltiazim is sometimes used for treating hypertension in athletes and other physically active patients.","You should not use Diltiazem if you have very low blood pressure or a serious heart condition.","Side effects of Diltiazem can include headache, dizziness, weakness, nausea and flushing.","Diltiazem's full name is [(2S,3S)-5-[2-(dimethylamino)ethyl]-2-(4- methoxyphenyl)-4-oxo-2,3-dihydro-1,5-benzothiazepin-3-yl] acetate (try saying that five times fast)."]
            case .QuestionSix: return ["Quinine's chemical name is (R)-(6-Methoxyquinolin-4-yl)[(1S,2S,4S,5R)-5- vinylquinuclidin-2-yl]methanol.","Quinine was extracted from the bark of the South American cinchona tree, and isolated and named in 1820 by French researchers Pierre Joseph Pelletier and Joseph Caventou.","Quinine was first used to treat malaria in Rome in 1631. During the 1600s, malaria was endemic to the swamps and marshes surrounding Rome and, over time, malaria was responsible for the death of several Popes, many Cardinals, and countless common citizens of the city.","Quinine is an extremely basic compound and is therefore always presented as a salt. This makes quinine dosing very complicated, because each of the different salts has a different weight.","Despite its widespread use to treat malaria exactly how quinine works is not completely clear.","Quinine is a white crystalline alkaloid and is a stereoisomer of quinidine.","Quinine is very bitter and must be mixed with something sweet to be taken orally.","Because of its relatively constant and well-known fluorescence quantum yield, quinine is also used in photochemistry as a common fluorescence standard.","Tonic water will glow under UV light due to the presence of quinine.","People may develop sensitivities and allergies to quinine as a result of occasional tonic water consumption, only to experience a full-blown reaction years later, upon taking a medicinal dose of quinine."]
            case .QuestionSeven: return ["Tamiflu's full name is ethyl (3R,4R,5S)-5-amino-4-acetamido-3-(pentan-3- yloxy)-cyclohex-1-ene-1-carboxylate.","Tamiflu is also known as Oseltamivir.","Tamiflu is usually administered as the inactive phosphate form which is hydrolysed in the liver to produce the active drug.","Tamiflu is on the World Health Organization's List of Essential Medicines, a list of the most important medications needed in a basic health system; but its risk-benefit ratio is controversial.","Tamiflu was discovered by scientists at Gilead Sciences in the USA using shikimic acid as a starting point for synthesis.","Tamiflu was widely used during the H5N1 avian influenza epidemic in Southeast Asia in 2005. Stockpiles of the drug at that time lead to worldwide shortages of the drug.","Tamiflu is thought to work by blocking enzymes called neuraminidases on the surfaces of influenza viruses, interfering with host cell release of complete viral particles.","Tamiflu does not enjoy patent protection in Thailand, the Philippines, Indonesia, and several other countries. The patents that do exist began to expire in 2016.","Common side effects of Tamiflu (occurring in over 1 % of people) include nausea and vomiting.","The biological half-life of Tamiflu after oral administration is 1 to 3 hours in most people."]
            case .QuestionEight: return ["Pure Vanillin forms as white or slightly yellow needles or crystalline powder with a sweet, creamy, vanilla odour.","Vanillin was first isolated as a relatively pure substance in 1858 by French scientist, Nicolas-Theodore Gobley, who obtained it by evaporating a vanilla extract to dryness, and recrystallizing the resulting solids from hot water.","Synthetic vanillin and ethylvanillin are used by the food industry; ethylvanillin is more expensive but has a stronger note. It differs from vanillin by having an ethoxy group instead of a methoxy group.","Genuine vanilla extract is up to 200 times more expensive than vanilla essence using synthetic vanillin.","If you just want to make a few grams, a very convenient laboratory synthesis of vanillin involves electrophilic bromination of 4-hydroxybenzaldehyde, followed by copper-catalysed methoxylation.","A classic early method for industrial scale synthesis of vanillin starts from eugenol. This isomerises to isoeugenol in alkaline solution, which in turn can be oxidised (by nitrobenzene) to vanillin. Other oxidising agents can be used but the OH group has to be protected by acetylation prior to oxidation.","Natural 'vanilla extract' is a mixture of several hundred different compounds in addition to vanillin.","Vanillin is chemically, 4-hydroxy-3-methoxybenzaldehyde (much easier to call it vanillin).","Vanillin comes from the seed pods of the orchid Vanilla planifola.","Two classic perfumes Jicky (1889) and Shalimar (1925) use vanillin molecules as key elements."]
            case .QuestionNine: return ["Capsaicin is a vanilloid (chemically N-Vanillyl-8-methyl-6-(E)-noneamide), the heaviest of this class of compound in nature.","Capsaicin is a chili pepper extract.","Capsicum is an irritant for mammals, including humans but not for birds as they lack the receptors that capsaicin binds to.","Capsaicin is the most common capsaicinoid; others are dihydrocapsaicin, nordihydrocapsaicin, homocapsaicin and homodihydrocapsaicin.","Capsaicin is a banned substance in equestrian sports because of its hypersensitizing and pain-relieving properties. At the show jumping events of the 2008 Summer Olympics, four horses tested positive for it, which resulted in disqualification.","From a plant metabolic perspective, capsaicin is costly as the molecule is relatively large and contains lots of nitrogen, which is critical for building proteins and DNA.","Capsaicin binds to transient receptor potential (TRP) channels triggering calcium ions to enter nearby neurons. When these neurons are agitated by calcium ions, it results in that characteristic burning sensation which many people love.","Pure capsaicin is a volatile, hydrophobic, colourless, odourless, crystalline to waxy compound.","The Scoville scale is a measure of the 'hotness' of a chilli pepper or anything derived from chilli peppers, i.e. hot sauce. The scale is named after Wilbur Scoville who developed the test in 1912.","Used topically, capsaicin aids in controlling peripheral nerve pain."]

            }
        }
    }
    
    static func getQuestions() ->[LevelOneQuestion]{
        return [QuestionOne, QuestionTwo, QuestionThree, QuestionFour, QuestionFive, QuestionSix,
        QuestionSeven, QuestionEight, QuestionNine, NilQuestion]
    }
    
}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

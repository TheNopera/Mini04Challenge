//
//  RecomendationModel.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 20/03/24.
//

import Foundation

enum UF:String{
    case AC
    case AL
    case AP
    case AM
    case BA
    case CE
    case DF
    case ES
    case GO
    case MA
    case MT
    case MS
    case MG
    case PA
    case PB
    case PR
    case PE
    case PI
    case RJ
    case RN
    case RS
    case RO
    case RR
    case SC
    case SP
    case SE
    case TO
}

class RecomendationModel {
    var recomendationCamping: [UF: [String]] = [
        .SP: ["Morro do Saboó – São Roque", "Pico do Jaraguá – Serra da Cantareira"],
        .RJ: ["Praia do Sono – Paraty", "Morro do Couto – Resende"],
        .ES: ["Pedra do Camelo – Pancas"],
        .MG: ["Complexo do Tira Prosa – Carrancas", "Paraíso Perdido – Capitólio"],
        .SC: ["Praia do Ferrugem – Garopaba", "Lagoinha do Leste – Florianópolis"],
        .PR: ["Ilha do Mel – Baía de Paranaguá"],
        .RS: ["Pico do Monte Negro – São José dos Ausentes"],
        .MS: ["Serra da Bodoquena – Pantanal"],
        .GO: ["Chapada dos Veadeiros"],
        .BA: ["Cumuruxatiba, Prado", "Reserva da Sapiranga – Mata de São João"],
        .AM: ["Serra do Aracá – Barcelos"],
        .PA: ["Floresta Nacional dos Tapajós – Belterra"]
    ]

    var recomendationBeach: [UF: [String]] = [
        .AL: ["Praia do Gunga – Roteiro", "Praia de Antunes – Maragogi"],
        .BA: ["Praia do Espelho – Trancoso", "Praia de Jeribucaçu – Itacaré", "Ilha do Amor – Alter do Chão", "Taipu de Fora – Península de Maraú"],
        .SP: ["Praia do Félix – Ubatuba", "Praia do Bonete – Ilhabela"],
        .RJ: ["Prainhas – Arraial do Cabo", "Praia do Aventureiro – Ilha Grande"],
        .PE: ["Praia dos Carneiros – Tamandaré", "Porto de Galinhas – Ipojuca"],
        .PB: ["Praia de Tambaba – Conde"],
        .RN: ["Praia do Madeiro – Pipa", "Parrachos de Maracajaú – Maracajaú"],
        .PI: ["Barra Grande – Cajueiro da Praia"],
        .CE: ["Praia de Jericoacoara – Jericoacoara", "Morro Branco – Beberibe"],
        .SC: ["Ilha do Campeche – Florianópolis", "Guarda do Embaú – Palhoça"],
        .PA: ["Ilha do Amor – Alter do Chão"],
        .AM: ["Praia do Tupé – Manaus"]
    ]

    var recomendationForest: [UF: [String]] = [
        .RJ: ["Parque Nacional da Tijuca - Rio de Janeiro"],
        .SP: ["Parque Estadual da Cantareira - Núcleo Pedra Grande"],
        .PA: ["Floresta Nacional dos Tapajós"],
        .AM: ["Parque Nacional Anavilhanas - Manaus", "Parque Nacional Jaú"],
        .MT: ["Chapada dos Guimarães", "Parque Florestal de Sinop"],
        .MS: ["Bonito"]
    ]

    var recomendationMontain: [UF: [String]] = [
        .RJ: ["Dedo de Deus, Serra dos Órgãos", "Agulhas Negras, Itatiaia"],
        .SP: ["Pedra do Baú, São Bento do Sapucaí"],
        .RR: ["Monte Roraima, Serra de Pacaraíma"],
        .MG: ["Pedra Riscada, São José do Divino", "Pedra da Mina, Serra da Mantiqueira"],
        .PR: ["Pico Paraná, Serra do Mar"],
        .ES: ["Pedra Azul, Domingos Martins"],
        .BA: ["Morro do Pai Inácio, Chapada Diamantina"]
    ]

    


//    var recomendacoes:[String] = ["Brasília", "São Paulo", "Rio de Janeiro", "Curitiba"]
//    var categorias:[String] = ["Acampamento", "Praia", "Montanhas", "Floresta"]
//    var maisProcurados:[String] = ["Rio de Janeiro", "Amapa", "Volta Redonda"]

    //var recomendacoes:[String:String] = ["MG":""]

    
}




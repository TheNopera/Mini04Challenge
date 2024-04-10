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




var recomendationCamping: [PlaceCardModel] = [
    PlaceCardModel(cityName: "São Roque", placeName: "Morro do Saboó"),
    PlaceCardModel(cityName: "Serra da Cantareira", placeName: "Pico do Jaraguá"),
    PlaceCardModel(cityName: "Paraty", placeName: "Praia do Sono"),
    PlaceCardModel(cityName: "Resende", placeName: "Morro do Couto"),
    PlaceCardModel(cityName: "Pancas", placeName: "Pedra do Camelo"),
    PlaceCardModel(cityName: "Carrancas", placeName: "Complexo do Tira Prosa"),
    PlaceCardModel(cityName: "Capitólio", placeName: "Paraíso Perdido"),
    PlaceCardModel(cityName: "Garopaba", placeName: "Praia do Ferrugem"),
    PlaceCardModel(cityName: "Florianópolis", placeName: "Lagoinha do Leste"),
    PlaceCardModel(cityName: "Baía de Paranaguá", placeName: "Ilha do Mel"),
    PlaceCardModel(cityName: "São José dos Ausentes", placeName: "Pico do Monte Negro"),
    PlaceCardModel(cityName: "Pantanal", placeName: "Serra da Bodoquena"),
    PlaceCardModel(cityName: "Chapada dos Veadeiros", placeName: "Chapada dos Veadeiros"),
    PlaceCardModel(cityName: "Prado", placeName: "Cumuruxatiba"),
    PlaceCardModel(cityName: "Mata de São João", placeName: "Reserva da Sapiranga"),
    PlaceCardModel(cityName: "Barcelos", placeName: "Serra do Aracá"),
    PlaceCardModel(cityName: "Belterra", placeName: "Floresta Nacional dos Tapajós")
]

var recomendationBeach: [PlaceCardModel] = [
    PlaceCardModel(cityName: "Roteiro", placeName: "Praia do Gunga"),
    PlaceCardModel(cityName: "Maragogi", placeName: "Praia de Antunes"),
    PlaceCardModel(cityName: "Trancoso", placeName: "Praia do Espelho"),
    PlaceCardModel(cityName: "Itacaré", placeName: "Praia de Jeribucaçu"),
    PlaceCardModel(cityName: "Alter do Chão", placeName: "Ilha do Amor"),
    PlaceCardModel(cityName: "Península de Maraú", placeName: "Taipu de Fora"),
    PlaceCardModel(cityName: "Ubatuba", placeName: "Praia do Félix"),
    PlaceCardModel(cityName: "Ilhabela", placeName: "Praia do Bonete"),
    PlaceCardModel(cityName: "Arraial do Cabo", placeName: "Prainhas"),
    PlaceCardModel(cityName: "Ilha Grande", placeName: "Praia do Aventureiro"),
    PlaceCardModel(cityName: "Tamandaré", placeName: "Praia dos Carneiros"),
    PlaceCardModel(cityName: "Ipojuca", placeName: "Porto de Galinhas"),
    PlaceCardModel(cityName: "Conde", placeName: "Praia de Tambaba"),
    PlaceCardModel(cityName: "Pipa", placeName: "Praia do Madeiro"),
    PlaceCardModel(cityName: "Maracajaú", placeName: "Parrachos de Maracajaú"),
    PlaceCardModel(cityName: "Cajueiro da Praia", placeName: "Barra Grande"),
    PlaceCardModel(cityName: "Jericoacoara", placeName: "Praia de Jericoacoara"),
    PlaceCardModel(cityName: "Beberibe", placeName: "Morro Branco"),
    PlaceCardModel(cityName: "Florianópolis", placeName: "Ilha do Campeche"),
    PlaceCardModel(cityName: "Palhoça", placeName: "Guarda do Embaú"),
    PlaceCardModel(cityName: "Alter do Chão", placeName: "Ilha do Amor"),
    PlaceCardModel(cityName: "Manaus", placeName: "Praia do Tupé")
]

var recomendationForest: [PlaceCardModel] = [
    PlaceCardModel(cityName: "Rio de Janeiro", placeName: "Parque Nacional da Tijuca"),
    PlaceCardModel(cityName: "Núcleo Pedra Grande", placeName: "Parque Estadual da Cantareira"),
    PlaceCardModel(cityName: "Floresta Nacional dos Tapajós", placeName: "Floresta Nacional dos Tapajós"),
    PlaceCardModel(cityName: "Manaus", placeName: "Parque Nacional Anavilhanas"),
    PlaceCardModel(cityName: "Parque Nacional Jaú", placeName: "Parque Nacional Jaú"),
    PlaceCardModel(cityName: "Chapada dos Guimarães", placeName: "Chapada dos Guimarães"),
    PlaceCardModel(cityName: "Parque Florestal de Sinop", placeName: "Parque Florestal de Sinop"),
    PlaceCardModel(cityName: "Bonito", placeName: "Bonito")
]

var recomendationMontain: [PlaceCardModel] = [
    PlaceCardModel(cityName: "Serra dos Órgãos", placeName: "Dedo de Deus"),
    PlaceCardModel(cityName: "Itatiaia", placeName: "Agulhas Negras"),
    PlaceCardModel(cityName: "São Bento do Sapucaí", placeName: "Pedra do Baú"),
    PlaceCardModel(cityName: "Serra de Pacaraíma", placeName: "Monte Roraima"),
    PlaceCardModel(cityName: "São José do Divino", placeName: "Pedra Riscada"),
    PlaceCardModel(cityName: "Serra da Mantiqueira", placeName: "Pedra da Mina"),
    PlaceCardModel(cityName: "Serra do Mar", placeName: "Pico Paraná"),
    PlaceCardModel(cityName: "Domingos Martins", placeName: "Pedra Azul"),
    PlaceCardModel(cityName: "Chapada Diamantina", placeName: "Morro do Pai Inácio")
]
    





//
//  APIManager.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 13/03/24.
//

import Foundation
import Alamofire

class APIManager : ObservableObject{
    var ENV : APIKeyable {
        return ProdENV()
    }
    
    var API_BASE_URL = "https://places.googleapis.com/v1/"
    
    
    //MARK: FUNÇÃO PARA RETORNAR PONTOS TURISTICOS EM CIDADE ESPECIFICA
    func getTouristAttractions(city : String) async throws -> PlacesResponse? {
        //O body do request
        let parameters : [String:Any] = [
            "textQuery" : "Pontos turisticos \(city)",
            "languageCode" : "pt-br"
        ]
        
        //Configuração do header do request
        let headers : HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Goog-Api-Key": ENV.SERVICE_API_KEY,
            "X-Goog-FieldMask": "places.displayName,places.editorialSummary,places.photos" // Informações que você quer que a API retorne
        ]
        
        let data = try await AF.request("\(API_BASE_URL)places:searchText", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).serializingDecodable(PlacesResponse.self).value
        
        return data
    }
    
    
    //MARK: FUNÇÃO PARA RETORNAR IMAGEM DE UM LOCAL
    func getPlaceImage(imageName : String) async throws-> Data? {
        let maxHeight : Int = 400
        let maxWidht  : Int = 400
        
        let data = try await AF.request("\(API_BASE_URL+imageName)/media?maxHeightPx=\(maxHeight)&maxWidthPx=\(maxWidht)&key=\(ENV.SERVICE_API_KEY)").serializingData().value
        
        return data
    }
    
}


var mockData = """
{
    "places": [
        {
            "displayName": {
                "text": "Cristo Redentor",
                "languageCode": "pt"
            },
            "editorialSummary": {
                "text": "Estátua de Jesus Cristo de 38 m de altura no topo da montanha, com paisagens da cidade e acessível por trem.",
                "languageCode": "pt-br"
            },
            "photos": [
                {
                    "name": "places/ChIJP6FKmNV_mQAR3gKVAdeEyZ0/photos/ATplDJZLlBPFHAQkbvF1p_rS5V4eC5q_0ashInfCVAilmUqPNe9QY7w70Q00-nB-87skO_xKMVDZbPWsmqwJKeb_msjx-E0FDSCrhfHNjyT0HVe0xzSlBhGCEiIWnBXo5x_iu3gZdu5kg-WWLgNBV9-Zx1v4ZoFT257b4Sv-",
                    "widthPx": 1284,
                    "heightPx": 856,
                    "authorAttributions": [
                        {
                            "displayName": "__lintrann_",
                            "uri": "//maps.google.com/maps/contrib/117356564150471735804",
                            "photoUri": "//lh3.googleusercontent.com/a-/ALV-UjX3x5kMiL45G5zcpdR7WGUoB_rr2bVCCgH6yKezFslWkM4=s100-p-k-no-mo"
                        }
                    ]
                },
                {
                    "name": "places/ChIJP6FKmNV_mQAR3gKVAdeEyZ0/photos/ATplDJZNIto5LQfTY2l5WrFXDgxarvEkyMg1VUuZPNv2Q5GHsq2jMrQeIOV2tEDU5ZZZ4J-iOc7muK_0wZxiP4XFjEiS1iX2Av3XkE8HhZ8CLJMLaLv4Ih94gIkx_dRASrYMbtFhfkS2QXUEHE1_0xoY0N0KkMZtpZKpf1sv",
                    "widthPx": 6000,
                    "heightPx": 4000,
                    "authorAttributions": [
                        {
                            "displayName": "Fakhrul Hossain",
                            "uri": "//maps.google.com/maps/contrib/110738258430134741032",
                            "photoUri": "//lh3.googleusercontent.com/a/ACg8ocLWydClAwCorFOgrz_mNZPUXiFxCQzzQLREdjVgEi3c=s100-p-k-no-mo"
                        }
                    ]
                },
                {
                    "name": "places/ChIJP6FKmNV_mQAR3gKVAdeEyZ0/photos/ATplDJbazol1nfx6VzI129CnPcuzI5XxRdl2TuTA3TzuLNfaZ7l9uqi7S9RkPd5QEbsv_GSkaJF3O3T27QV8rxUWVDkuf24WaLyEcw_a_CjGrWLLViJPg6frN_Czu1WLrINSQ6xpnk9MCdpEA6J9HJsQUun5ShTKjUhnXO2i",
                    "widthPx": 12000,
                    "heightPx": 9000,
                    "authorAttributions": [
                        {
                            "displayName": "Jhenny Ferreira Taborda",
                            "uri": "//maps.google.com/maps/contrib/112041046480486466341",
                            "photoUri": "//lh3.googleusercontent.com/a-/ALV-UjUgXUL6BQATAds3ByoD-6jBPbkn4n7S13NDEpiHTWhC7p9n=s100-p-k-no-mo"
                        }
                    ]
                },
                {
                    "name": "places/ChIJP6FKmNV_mQAR3gKVAdeEyZ0/photos/ATplDJYGDiJW0Y3i9x5vb0p5BEJduY4syc4UY_LqnnmoQsmDHnQxe39aPu1bpwT4Yjb-Jn1wWPkb6CP5e52MKdeCjeJQq0V5-dRyesVVmEbxaztFGrBxmvd_qxYh-iYX2G0kux3DbBgdZrYt7Z956ZEpQN7G60PUzUHJz3Kv",
                    "widthPx": 1600,
                    "heightPx": 1204,
                    "authorAttributions": [
                        {
                            "displayName": "Danilo Julião",
                            "uri": "//maps.google.com/maps/contrib/107334073758601370532",
                            "photoUri": "//lh3.googleusercontent.com/a-/ALV-UjUrAaa--mfKM-FGLImkSnl-Pso8GHwSsI-22zJSpkEusFnI=s100-p-k-no-mo"
                        }
                    ]
                },
                {
                    "name": "places/ChIJP6FKmNV_mQAR3gKVAdeEyZ0/photos/ATplDJaJveRNPnt2eexhWRallMFKuUaIDKUcjVOA59jGJDxgSVxayXVHV8jHT7HE0DNv-oJIrqzMKbxz45V593vGCGQ1ULUh7V2bUehT-VVy5zwF6ud-saTaTiW0zmHlpXDThR7-Eiv5T3MzaAoWKMAt4pY_-98SCnkGtcm1",
                    "widthPx": 3472,
                    "heightPx": 4624,
                    "authorAttributions": [
                        {
                            "displayName": "semen matrasov",
                            "uri": "//maps.google.com/maps/contrib/101720010123412458524",
                            "photoUri": "//lh3.googleusercontent.com/a-/ALV-UjWwEWia9JLWFVH-lnu3aEtMUmHv9IIMEYt1cIUdOXh57A=s100-p-k-no-mo"
                        }
                    ]
                },
                {
                    "name": "places/ChIJP6FKmNV_mQAR3gKVAdeEyZ0/photos/ATplDJZMNvbvDCmjUyQDcwcsdk8eqGDjoUrvgq9WorTHWkutJ5zaieJQ857ugKALzwmKfY-RaqPGFFVZreKOirqg7PIA2wqv8u4EvIv8YjSrX6PP3o9jBR_7lqj0U87RS2JbZSLoN1i6qJV-DNtLRysi9gXOME831c06ISnf",
                    "widthPx": 4032,
                    "heightPx": 2268,
                    "authorAttributions": [
                        {
                            "displayName": "Naba Barkakati",
                            "uri": "//maps.google.com/maps/contrib/103493761972758985359",
                            "photoUri": "//lh3.googleusercontent.com/a-/ALV-UjV0zoXm6LD-noIHQAZAq2h2A3u6N-gd1PXXKwgzVku8qSdv=s100-p-k-no-mo"
                        }
                    ]
                },
                {
                    "name": "places/ChIJP6FKmNV_mQAR3gKVAdeEyZ0/photos/ATplDJa86T9E0-m2dAE2UZ69MStN-9Hq7wtjn1qX0b0LIc1gvFXJj1lRMa4ym_vKAP33IN3E9zbiohTHJRnzOvk9UYaiPE7vyj8b4UoeTq9qrxZh-8UnYkHG_biB4j6vqvsXyaQi1o7WxmR4ahBqTt8ajnhvxHzSA6UBT89n",
                    "widthPx": 3000,
                    "heightPx": 4000,
                    "authorAttributions": [
                        {
                            "displayName": "Débora de Souza Queiroz",
                            "uri": "//maps.google.com/maps/contrib/106297724517371097297",
                            "photoUri": "//lh3.googleusercontent.com/a-/ALV-UjUAq1UQspPNG2pHaSM93rgumhMxooxmOFMnwXS7Cosj8Vuq=s100-p-k-no-mo"
                        }
                    ]
                },
                {
                    "name": "places/ChIJP6FKmNV_mQAR3gKVAdeEyZ0/photos/ATplDJZD8iIpEMMp6lsVbyFXqmKesp7FEXYxp-TXIQY4kYCjGCmddQFDwRV7-rBU11EtD3pvdbCRDw1S2RWYEHbm9F1eQNf-LvrVW8b7nr-B3bN40TDrYaOfWVRgCHBQM-nTxoSkU8lfhbrAZMTd9mucFh_cbm7bC2KLN6m9",
                    "widthPx": 4320,
                    "heightPx": 3240,
                    "authorAttributions": [
                        {
                            "displayName": "Kishor Khule",
                            "uri": "//maps.google.com/maps/contrib/108025171277315853522",
                            "photoUri": "//lh3.googleusercontent.com/a-/ALV-UjWHU6abmE_zFOoAzwOzlIO2dd7pDhDkeDaPlTf7nuwyJGJb=s100-p-k-no-mo"
                        }
                    ]
                },
                {
                    "name": "places/ChIJP6FKmNV_mQAR3gKVAdeEyZ0/photos/ATplDJbRkpeHYmqmyX9Xz9ZxXwssRU__--Pg7PZO7OdIj9f-Fpi-A5t6Bs6uyQSOJiN6xjorhm170wW4eaznEQif8rcoEU3yqiWdihA8RWX_GJWoT29pQIwSMS73MaRpzXWXxrPV-3QlA17ZZuESVXol4BTZ9ar1pmcVMaVB",
                    "widthPx": 3024,
                    "heightPx": 4032,
                    "authorAttributions": [
                        {
                            "displayName": "Patricia Leonel",
                            "uri": "//maps.google.com/maps/contrib/109916473242918180412",
                            "photoUri": "//lh3.googleusercontent.com/a/ACg8ocK7UPhZmmE03m7ouXR3G-VpEha2sVel1CzW-xssXaSTANw=s100-p-k-no-mo"
                        }
                    ]
                },
                {
                    "name": "places/ChIJP6FKmNV_mQAR3gKVAdeEyZ0/photos/ATplDJYhgESbD1la1MtJJF7pQcjPWZNX-3_ZMW00-e1PZR5kegT8ogDCZx8a8EdHUig209nhN7LR8M8ezowQN1FfMLMnjax989NdDJHxTuxkVVTE8IIV5d3zYOKa-rB5GxF_Xt7qQg17OqyqaM4qDhLWF5IGVISKFV36pacI",
                    "widthPx": 3000,
                    "heightPx": 3000,
                    "authorAttributions": [
                        {
                            "displayName": "Leandro Lozano",
                            "uri": "//maps.google.com/maps/contrib/105598366181732050431",
                            "photoUri": "//lh3.googleusercontent.com/a-/ALV-UjUdJuBddmAFNQMaWLo9CU7Dh_ofvnWht036fNZr_wHhaM0=s100-p-k-no-mo"
                        }
                    ]
                }
            ]
        }
    ]
}
"""

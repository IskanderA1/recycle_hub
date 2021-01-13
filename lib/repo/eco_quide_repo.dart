import 'package:recycle_hub/model/eco_guide_models/container_response.dart';

class EcoGuideRepository {
  String containerMainUrl;

  ContainerResponse getContainers() {
    var source = [
      {
        "name": "Бумага",
        "allowed": [
          {
            "name": "Бумага в офисе",
            "subjects": [
              {"name": "Старые документы", "photo": "Фото"}
            ]
          },
          {
            "name": "Блокноты и тетради",
            "subjects": [
              {"name": "Ежедневники", "photo": "Фото"}
            ]
          },
        ],
        "forbidden": [
          {"name": "Старые документы", "photo": "Фото"}
        ]
      },
      {
        "name": "Пластик",
        "allowed": [
          {
            "name": "Пластикова упаковка",
            "subjects": [
              {"name": "Бутылки от молока, напитков и пр.", "photo": "Фото"}
            ]
          }
        ],
        "forbidden": [
          {"name": "Лотки от яиц", "photo": "Фото"}
        ]
      },
      {
        "name": "Стекло",
        "allowed": [
          {
            "name": "Бутылки",
            "subjects": [
              {"name": "Бутылки от напитков и пива", "photo": "Фото"}
            ]
          }
        ],
        "forbidden": [
          {"name": "Оконное и мебельное стекло", "photo": "Фото"}
        ]
      },
      {
        "name": "Мусор",
        "allowed": [
          {
            "name": "Общий мусор",
            "subjects": [
              {"name": "Органические отходы", "photo": "Фото"}
            ]
          }
        ],
        "forbidden": [
          {"name": "Старые документы", "photo": "Фото"}
        ]
      },
      {
        "name": "Отходы",
        "allowed": [
          {
            "name": "Батарейки и аккумуляторы",
            "subjects": [
              {"name": "Старые документы", "photo": "Фото"}
            ]
          }
        ],
        "forbidden": [
          {"name": "Старые документы", "photo": "Фото"}
        ]
      },
    ];
    print(source.toList());
    List data = source.toList();
    print(data[0]);
    return ContainerResponse.fromJson(data);
  }
}

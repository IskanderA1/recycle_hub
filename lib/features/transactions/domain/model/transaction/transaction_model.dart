/* import 'package:recycle_hub/features/transactions/domain/model/transaction/t_filter_type_model.dart';
import 't_rec_point_model.dart';
import 't_user_model.dart';

class Transaction {
    Transaction({
        this.from,
        this.id,
        this.to,
        this.ammount,
        this.filterType,
        this.image,
        this.reward,
        this.status,
    });

    From from;
    String id;
    To to;
    double ammount;
    FilterType filterType;
    String image;
    int reward;
    String status;

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        from: From.fromJson(json["_from"]),
        id: json["_id"],
        to: To.fromJson(json["_to"]),
        ammount: json["ammount"],
        filterType: FilterType.fromJson(json["filter_type"]),
        image: json["image"],
        reward: json["reward"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "_from": from.toJson(),
        "_id": id,
        "_to": to.toJson(),
        "ammount": ammount,
        "filter_type": filterType.toJson(),
        "image": image,
        "reward": reward,
        "status": status,
    };
}











 */
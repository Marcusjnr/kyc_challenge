import 'package:dio/dio.dart';
import 'package:kyc/data/level_upgrade/level_upgrade_data.dart';
import 'package:kyc/models/level_upgrade/level_upgrade_request.dart';
import 'package:kyc/utils/operation.dart';

class _LevelUpgradeRepo{

  levelUpgrade(Dio dio, LevelUpgradeRequest  upgradeRequest,String baseUrl, OperationCompleted levelUpgradeCompleted){
    levelUpgradeData.levelUpgrade(dio, upgradeRequest, baseUrl).then((data) => levelUpgradeCompleted(data));
  }
}

_LevelUpgradeRepo levelUpgradeRepo = _LevelUpgradeRepo();
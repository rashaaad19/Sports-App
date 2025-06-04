import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

//* Coming Soon Dialog
class ComingSoonDialog extends StatelessWidget {
  const ComingSoonDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Icon(
          Icons.warning_outlined,
          size: 48.sp,
          color: const Color(0xFF90C02A),
        ),
      ),
      content: Text('Coming Soon...', style: TextStyle(fontSize: 16.sp)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK', style: TextStyle(color: Color(0xFF36AC19))),
        ),
      ],
    );
  }
}

//* Player stats dialog

class PlayerStatsDialog extends StatelessWidget {
  final dynamic player;

  const PlayerStatsDialog({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //* Player Information
              CircleAvatar(
                radius: 40.r,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.network(
                    player.playerImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.person, size: 75.r, color: Colors.grey);
                    },
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              Text(
                player.playerName,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),

              Text(
                player.playerCountry,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
              ),

              SizedBox(height: 16.h),

              //* Player Stats
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _statRow('Number', player.playerNumber),
                    _statRow('Position', player.playerType),
                    _statRow('Age', player.playerAge),
                    _statRow('Goals', player.playerGoals),
                    _statRow('Assists', player.playerAssists),
                    _statRow('Yellow Cards', player.playerYellowCards),
                    _statRow('Red Cards', player.playerRedCards),
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              //* Close Button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                  icon: Icon(Icons.share, color: Colors.black87, size: 24.sp),
                  onPressed: () async {
                    await SharePlus.instance.share(
                      ShareParams(
                        title: player.playerName,
                        text: 'Checkout ${player.playerName} stats!',
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statRow(String title, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        trailing: Text(
          value?.isNotEmpty == true ? value! : 'N/A',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

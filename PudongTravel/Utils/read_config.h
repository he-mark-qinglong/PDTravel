#ifndef __READ_CONFIG_H__
#define __READ_CONFIG_H__

#include <iostream>
#include <vector>
#include <list>
#include <set>
#include <map>
#include "libjson.h"
#include "JSONNode.h"
#include "ls_xtype.h"
namespace Ls {
//跑商配置表格
struct Business
{
	 LsInt32 SideBySideAddition; //互为跑商收益百分比加成
	 LsInt32 ShortageAddition; //输出紧缺物资百分比加成
	 LsInt32 SameZoneAddition; //同一区域沙盘百分比加成
};

//奇遇相关配置文件
struct HappyEncount
{
	 std::string OpenTime ; //时间点：每天10点，12点，13点，14点四个时间点
	 LsInt32 NpcNum; //奇遇NPC总个数
	 LsInt32 JoinNum; //每个角色每天参与奇遇活动的次数上限
	 LsInt32 JoinLevel; //需求等级
};

//国战配置
struct War
{
	 std::string OpenTime; //国战报名时间
	 std::string EndTime; //国战结束时间
	 LsInt32 apply; //国战报名持续时间单位秒
	 LsInt32 warTime; //国战战斗持续时间单位秒
	 std::string OpenTime0; //国战报名时间
	 std::string EndTime0; //国战结束时间
};

//redis配置
struct RedisCfg
{
	 std::string ip; //Add comment here
	 LsUInt16 port; //Add comment here
	 LsUInt16 dbidx; //数据库索引
};

//创角色福利
struct RoleInit
{
	 LsInt32 vip; //vip等级
	 LsInt32 vipexp; //vip经验
	 LsInt32 gold; //厨师黄金
};

//配置
struct config
{
	 std::string LocalIP; //服务器地址
	 LsUInt16 ListenPort; //服务器端口
	 std::string SessionSvrAddr; //场景服务器地址
	 LsUInt16 SessionSvrPort; //场景服务器端口
	 std::string DBSvrAddr; //db服务器地址
	 LsUInt16 DBSvrPort; //db服务器端口
	 std::string BattleSvrAddr; //战斗服务器地址
	 LsUInt16 BattleSvrPort; //战斗服务器端口
	 std::string DBAddr; //数据库地址
	 std::string DBUser; //数据库账号
	 std::string DBPasswd; //数据库密码
	 std::string DBName; //数据库名
	 LsUInt16 DBPort; //数据库端口
	 LsUInt16 DBThread; //数据库线程数
	 RedisCfg redisCfg; //redis配置
	 std::string LogFile; //日志文件名
	 LsUInt32 LogSize; //日志大小
	 LsUInt32 TraceLevel; //级别
	 std::string StatLogFile; //日志文件名
	 LsUInt32 StatLogSize; //日志大小
	 LsUInt32 SLSaveInterval; //级别
	 LsUInt32 PhysicsID; //物理机ID，不同服务器不能相同
	 LsUInt32 AntiAddiction; //防沉迷是否启动
	 LsUInt32 MaxUser; //最大用户数
	 std::string StatusDBName; //日志服务器名
	 std::string RechargeKey; //充值验证密匙
	 std::string SessionKey; //session登录验证密匙
	 Business business; //跑商配置
	 HappyEncount happy; //奇遇相关配置
	 War war; //国战配置
	 RoleInit roleInit; //创角色福利
};

//此处添加注释
struct Info
{
	 LsInt32 id; //Add comment here
	 std::string title; //Add comment here
	 std::string detail; //Add comment here
};

//此处添加注释
struct LjzViewDetail
{
};

};

std::ostream& operator<<( std::ostream& src, const Ls::Business& s);
std::ostream& operator<<( std::ostream& src, const Ls::HappyEncount& s);
std::ostream& operator<<( std::ostream& src, const Ls::War& s);
std::ostream& operator<<( std::ostream& src, const Ls::RedisCfg& s);
std::ostream& operator<<( std::ostream& src, const Ls::RoleInit& s);
std::ostream& operator<<( std::ostream& src, const Ls::config& s);
std::ostream& operator<<( std::ostream& src, const Ls::Info& s);
std::ostream& operator<<( std::ostream& src, const Ls::LjzViewDetail& s);
void WriteToJson( const Ls::Business& s,  JSONNode& n);
bool ReadFromJson( Ls::Business& s,  const JSONNode& n );
void WriteToJsonStr( const Ls::Business& s,  std::string& str, bool bFormat);
void ReadFromJsonStr( Ls::Business& s,  std::string& str);
void WriteToJson( const Ls::HappyEncount& s,  JSONNode& n);
bool ReadFromJson( Ls::HappyEncount& s,  const JSONNode& n );
void WriteToJsonStr( const Ls::HappyEncount& s,  std::string& str, bool bFormat);
void ReadFromJsonStr( Ls::HappyEncount& s,  std::string& str);
void WriteToJson( const Ls::War& s,  JSONNode& n);
bool ReadFromJson( Ls::War& s,  const JSONNode& n );
void WriteToJsonStr( const Ls::War& s,  std::string& str, bool bFormat);
void ReadFromJsonStr( Ls::War& s,  std::string& str);
void WriteToJson( const Ls::RedisCfg& s,  JSONNode& n);
bool ReadFromJson( Ls::RedisCfg& s,  const JSONNode& n );
void WriteToJsonStr( const Ls::RedisCfg& s,  std::string& str, bool bFormat);
void ReadFromJsonStr( Ls::RedisCfg& s,  std::string& str);
void WriteToJson( const Ls::RoleInit& s,  JSONNode& n);
bool ReadFromJson( Ls::RoleInit& s,  const JSONNode& n );
void WriteToJsonStr( const Ls::RoleInit& s,  std::string& str, bool bFormat);
void ReadFromJsonStr( Ls::RoleInit& s,  std::string& str);
void WriteToJson( const Ls::config& s,  JSONNode& n);
bool ReadFromJson( Ls::config& s,  const JSONNode& n );
void WriteToJsonStr( const Ls::config& s,  std::string& str, bool bFormat);
void ReadFromJsonStr( Ls::config& s,  std::string& str);
void WriteToJson( const Ls::Info& s,  JSONNode& n);
bool ReadFromJson( Ls::Info& s,  const JSONNode& n );
void WriteToJsonStr( const Ls::Info& s,  std::string& str, bool bFormat);
void ReadFromJsonStr( Ls::Info& s,  std::string& str);
void WriteToJson( const Ls::LjzViewDetail& s,  JSONNode& n);
bool ReadFromJson( Ls::LjzViewDetail& s,  const JSONNode& n );
void WriteToJsonStr( const Ls::LjzViewDetail& s,  std::string& str, bool bFormat);
void ReadFromJsonStr( Ls::LjzViewDetail& s,  std::string& str);
#endif

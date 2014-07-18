#include "read_config.h"
std::ostream& operator<<( std::ostream& src, const Ls::Business& s)
{
	src <<"\t\tSideBySideAddition:"<< s.SideBySideAddition;
	src <<"\t\tShortageAddition:"<< s.ShortageAddition;
	src <<"\t\tSameZoneAddition:"<< s.SameZoneAddition;
	src<<std::endl;
	return src;
}


std::ostream& operator<<( std::ostream& src, const Ls::HappyEncount& s)
{
	src <<"\t\tOpenTime :"<< s.OpenTime ;
	src <<"\t\tNpcNum:"<< s.NpcNum;
	src <<"\t\tJoinNum:"<< s.JoinNum;
	src <<"\t\tJoinLevel:"<< s.JoinLevel;
	src<<std::endl;
	return src;
}


std::ostream& operator<<( std::ostream& src, const Ls::War& s)
{
	src <<"\t\tOpenTime:"<< s.OpenTime;
	src <<"\t\tEndTime:"<< s.EndTime;
	src <<"\t\tapply:"<< s.apply;
	src <<"\t\twarTime:"<< s.warTime;
	src <<"\t\tOpenTime0:"<< s.OpenTime0;
	src <<"\t\tEndTime0:"<< s.EndTime0;
	src<<std::endl;
	return src;
}


std::ostream& operator<<( std::ostream& src, const Ls::RedisCfg& s)
{
	src <<"\t\tip:"<< s.ip;
	src <<"\t\tport:"<< s.port;
	src <<"\t\tdbidx:"<< s.dbidx;
	src<<std::endl;
	return src;
}


std::ostream& operator<<( std::ostream& src, const Ls::RoleInit& s)
{
	src <<"\t\tvip:"<< s.vip;
	src <<"\t\tvipexp:"<< s.vipexp;
	src <<"\t\tgold:"<< s.gold;
	src<<std::endl;
	return src;
}


std::ostream& operator<<( std::ostream& src, const Ls::config& s)
{
	src <<"\t\tLocalIP:"<< s.LocalIP;
	src <<"\t\tListenPort:"<< s.ListenPort;
	src <<"\t\tSessionSvrAddr:"<< s.SessionSvrAddr;
	src <<"\t\tSessionSvrPort:"<< s.SessionSvrPort;
	src <<"\t\tDBSvrAddr:"<< s.DBSvrAddr;
	src <<"\t\tDBSvrPort:"<< s.DBSvrPort;
	src <<"\t\tBattleSvrAddr:"<< s.BattleSvrAddr;
	src <<"\t\tBattleSvrPort:"<< s.BattleSvrPort;
	src <<"\t\tDBAddr:"<< s.DBAddr;
	src <<"\t\tDBUser:"<< s.DBUser;
	src <<"\t\tDBPasswd:"<< s.DBPasswd;
	src <<"\t\tDBName:"<< s.DBName;
	src <<"\t\tDBPort:"<< s.DBPort;
	src <<"\t\tDBThread:"<< s.DBThread;
	src <<"\t\tredisCfg:"<< s.redisCfg;
	src <<"\t\tLogFile:"<< s.LogFile;
	src <<"\t\tLogSize:"<< s.LogSize;
	src <<"\t\tTraceLevel:"<< s.TraceLevel;
	src <<"\t\tStatLogFile:"<< s.StatLogFile;
	src <<"\t\tStatLogSize:"<< s.StatLogSize;
	src <<"\t\tSLSaveInterval:"<< s.SLSaveInterval;
	src <<"\t\tPhysicsID:"<< s.PhysicsID;
	src <<"\t\tAntiAddiction:"<< s.AntiAddiction;
	src <<"\t\tMaxUser:"<< s.MaxUser;
	src <<"\t\tStatusDBName:"<< s.StatusDBName;
	src <<"\t\tRechargeKey:"<< s.RechargeKey;
	src <<"\t\tSessionKey:"<< s.SessionKey;
	src <<"\t\tbusiness:"<< s.business;
	src <<"\t\thappy:"<< s.happy;
	src <<"\t\twar:"<< s.war;
	src <<"\t\troleInit:"<< s.roleInit;
	src<<std::endl;
	return src;
}


std::ostream& operator<<( std::ostream& src, const Ls::Info& s)
{
	src <<"\t\tid:"<< s.id;
	src <<"\t\ttitle:"<< s.title;
	src <<"\t\tdetail:"<< s.detail;
	src<<std::endl;
	return src;
}


std::ostream& operator<<( std::ostream& src, const Ls::LjzViewDetail& s)
{
	src<<std::endl;
	return src;
}


bool ReadFromJson( Ls::Business& s,  const JSONNode& n )
{
	JSONNode::const_iterator i = n.begin();
	while (i != n.end()){
		// get the node name and value as a string
		std::string node_name = i -> name();
		if (node_name == "SideBySideAddition"){
			s.SideBySideAddition = i->as_int();
		}
		else if (node_name == "ShortageAddition"){
			s.ShortageAddition = i->as_int();
		}
		else if (node_name == "SameZoneAddition"){
			s.SameZoneAddition = i->as_int();
		}
		++i;
	}
	return true;
}
void WriteToJson( const Ls::Business& s,  JSONNode& n)
{
	n.push_back(JSONNode("SideBySideAddition", s.SideBySideAddition));
	n.push_back(JSONNode("ShortageAddition", s.ShortageAddition));
	n.push_back(JSONNode("SameZoneAddition", s.SameZoneAddition));
}


void WriteToJsonStr( const Ls::Business& s,  std::string& str, bool bFormat)
{
	JSONNode n(JSON_NODE);
	WriteToJson( s, n );
	if (bFormat)
		str = n.write_formatted();
	else
		str = n.write();
}
void ReadFromJsonStr( Ls::Business& s,  std::string& str)
{
	JSONNode n = libjson::parse(str);
	ReadFromJson( s, n );
}
bool ReadFromJson( Ls::HappyEncount& s,  const JSONNode& n )
{
	JSONNode::const_iterator i = n.begin();
	while (i != n.end()){
		// get the node name and value as a string
		std::string node_name = i -> name();
		if (node_name == "OpenTime "){
			s.OpenTime  = i->as_string();
		}
		else if (node_name == "NpcNum"){
			s.NpcNum = i->as_int();
		}
		else if (node_name == "JoinNum"){
			s.JoinNum = i->as_int();
		}
		else if (node_name == "JoinLevel"){
			s.JoinLevel = i->as_int();
		}
		++i;
	}
	return true;
}
void WriteToJson( const Ls::HappyEncount& s,  JSONNode& n)
{
	n.push_back(JSONNode("OpenTime ", s.OpenTime ));
	n.push_back(JSONNode("NpcNum", s.NpcNum));
	n.push_back(JSONNode("JoinNum", s.JoinNum));
	n.push_back(JSONNode("JoinLevel", s.JoinLevel));
}


void WriteToJsonStr( const Ls::HappyEncount& s,  std::string& str, bool bFormat)
{
	JSONNode n(JSON_NODE);
	WriteToJson( s, n );
	if (bFormat)
		str = n.write_formatted();
	else
		str = n.write();
}
void ReadFromJsonStr( Ls::HappyEncount& s,  std::string& str)
{
	JSONNode n = libjson::parse(str);
	ReadFromJson( s, n );
}
bool ReadFromJson( Ls::War& s,  const JSONNode& n )
{
	JSONNode::const_iterator i = n.begin();
	while (i != n.end()){
		// get the node name and value as a string
		std::string node_name = i -> name();
		if (node_name == "OpenTime"){
			s.OpenTime = i->as_string();
		}
		else if (node_name == "EndTime"){
			s.EndTime = i->as_string();
		}
		else if (node_name == "apply"){
			s.apply = i->as_int();
		}
		else if (node_name == "warTime"){
			s.warTime = i->as_int();
		}
		else if (node_name == "OpenTime0"){
			s.OpenTime0 = i->as_string();
		}
		else if (node_name == "EndTime0"){
			s.EndTime0 = i->as_string();
		}
		++i;
	}
	return true;
}
void WriteToJson( const Ls::War& s,  JSONNode& n)
{
	n.push_back(JSONNode("OpenTime", s.OpenTime));
	n.push_back(JSONNode("EndTime", s.EndTime));
	n.push_back(JSONNode("apply", s.apply));
	n.push_back(JSONNode("warTime", s.warTime));
	n.push_back(JSONNode("OpenTime0", s.OpenTime0));
	n.push_back(JSONNode("EndTime0", s.EndTime0));
}


void WriteToJsonStr( const Ls::War& s,  std::string& str, bool bFormat)
{
	JSONNode n(JSON_NODE);
	WriteToJson( s, n );
	if (bFormat)
		str = n.write_formatted();
	else
		str = n.write();
}
void ReadFromJsonStr( Ls::War& s,  std::string& str)
{
	JSONNode n = libjson::parse(str);
	ReadFromJson( s, n );
}
bool ReadFromJson( Ls::RedisCfg& s,  const JSONNode& n )
{
	JSONNode::const_iterator i = n.begin();
	while (i != n.end()){
		// get the node name and value as a string
		std::string node_name = i -> name();
		if (node_name == "ip"){
			s.ip = i->as_string();
		}
		else if (node_name == "port"){
			s.port = i->as_int();
		}
		else if (node_name == "dbidx"){
			s.dbidx = i->as_int();
		}
		++i;
	}
	return true;
}
void WriteToJson( const Ls::RedisCfg& s,  JSONNode& n)
{
	n.push_back(JSONNode("ip", s.ip));
	n.push_back(JSONNode("port", s.port));
	n.push_back(JSONNode("dbidx", s.dbidx));
}


void WriteToJsonStr( const Ls::RedisCfg& s,  std::string& str, bool bFormat)
{
	JSONNode n(JSON_NODE);
	WriteToJson( s, n );
	if (bFormat)
		str = n.write_formatted();
	else
		str = n.write();
}
void ReadFromJsonStr( Ls::RedisCfg& s,  std::string& str)
{
	JSONNode n = libjson::parse(str);
	ReadFromJson( s, n );
}
bool ReadFromJson( Ls::RoleInit& s,  const JSONNode& n )
{
	JSONNode::const_iterator i = n.begin();
	while (i != n.end()){
		// get the node name and value as a string
		std::string node_name = i -> name();
		if (node_name == "vip"){
			s.vip = i->as_int();
		}
		else if (node_name == "vipexp"){
			s.vipexp = i->as_int();
		}
		else if (node_name == "gold"){
			s.gold = i->as_int();
		}
		++i;
	}
	return true;
}
void WriteToJson( const Ls::RoleInit& s,  JSONNode& n)
{
	n.push_back(JSONNode("vip", s.vip));
	n.push_back(JSONNode("vipexp", s.vipexp));
	n.push_back(JSONNode("gold", s.gold));
}


void WriteToJsonStr( const Ls::RoleInit& s,  std::string& str, bool bFormat)
{
	JSONNode n(JSON_NODE);
	WriteToJson( s, n );
	if (bFormat)
		str = n.write_formatted();
	else
		str = n.write();
}
void ReadFromJsonStr( Ls::RoleInit& s,  std::string& str)
{
	JSONNode n = libjson::parse(str);
	ReadFromJson( s, n );
}
bool ReadFromJson( Ls::config& s,  const JSONNode& n )
{
	JSONNode::const_iterator i = n.begin();
	while (i != n.end()){
		// get the node name and value as a string
		std::string node_name = i -> name();
		if (node_name == "LocalIP"){
			s.LocalIP = i->as_string();
		}
		else if (node_name == "ListenPort"){
			s.ListenPort = i->as_int();
		}
		else if (node_name == "SessionSvrAddr"){
			s.SessionSvrAddr = i->as_string();
		}
		else if (node_name == "SessionSvrPort"){
			s.SessionSvrPort = i->as_int();
		}
		else if (node_name == "DBSvrAddr"){
			s.DBSvrAddr = i->as_string();
		}
		else if (node_name == "DBSvrPort"){
			s.DBSvrPort = i->as_int();
		}
		else if (node_name == "BattleSvrAddr"){
			s.BattleSvrAddr = i->as_string();
		}
		else if (node_name == "BattleSvrPort"){
			s.BattleSvrPort = i->as_int();
		}
		else if (node_name == "DBAddr"){
			s.DBAddr = i->as_string();
		}
		else if (node_name == "DBUser"){
			s.DBUser = i->as_string();
		}
		else if (node_name == "DBPasswd"){
			s.DBPasswd = i->as_string();
		}
		else if (node_name == "DBName"){
			s.DBName = i->as_string();
		}
		else if (node_name == "DBPort"){
			s.DBPort = i->as_int();
		}
		else if (node_name == "DBThread"){
			s.DBThread = i->as_int();
		}
		else if (node_name == "redisCfg"){
			ReadFromJson( s.redisCfg, *i );
		}
		else if (node_name == "LogFile"){
			s.LogFile = i->as_string();
		}
		else if (node_name == "LogSize"){
			s.LogSize = i->as_int();
		}
		else if (node_name == "TraceLevel"){
			s.TraceLevel = i->as_int();
		}
		else if (node_name == "StatLogFile"){
			s.StatLogFile = i->as_string();
		}
		else if (node_name == "StatLogSize"){
			s.StatLogSize = i->as_int();
		}
		else if (node_name == "SLSaveInterval"){
			s.SLSaveInterval = i->as_int();
		}
		else if (node_name == "PhysicsID"){
			s.PhysicsID = i->as_int();
		}
		else if (node_name == "AntiAddiction"){
			s.AntiAddiction = i->as_int();
		}
		else if (node_name == "MaxUser"){
			s.MaxUser = i->as_int();
		}
		else if (node_name == "StatusDBName"){
			s.StatusDBName = i->as_string();
		}
		else if (node_name == "RechargeKey"){
			s.RechargeKey = i->as_string();
		}
		else if (node_name == "SessionKey"){
			s.SessionKey = i->as_string();
		}
		else if (node_name == "business"){
			ReadFromJson( s.business, *i );
		}
		else if (node_name == "happy"){
			ReadFromJson( s.happy, *i );
		}
		else if (node_name == "war"){
			ReadFromJson( s.war, *i );
		}
		else if (node_name == "roleInit"){
			ReadFromJson( s.roleInit, *i );
		}
		++i;
	}
	return true;
}
void WriteToJson( const Ls::config& s,  JSONNode& n)
{
	n.push_back(JSONNode("LocalIP", s.LocalIP));
	n.push_back(JSONNode("ListenPort", s.ListenPort));
	n.push_back(JSONNode("SessionSvrAddr", s.SessionSvrAddr));
	n.push_back(JSONNode("SessionSvrPort", s.SessionSvrPort));
	n.push_back(JSONNode("DBSvrAddr", s.DBSvrAddr));
	n.push_back(JSONNode("DBSvrPort", s.DBSvrPort));
	n.push_back(JSONNode("BattleSvrAddr", s.BattleSvrAddr));
	n.push_back(JSONNode("BattleSvrPort", s.BattleSvrPort));
	n.push_back(JSONNode("DBAddr", s.DBAddr));
	n.push_back(JSONNode("DBUser", s.DBUser));
	n.push_back(JSONNode("DBPasswd", s.DBPasswd));
	n.push_back(JSONNode("DBName", s.DBName));
	n.push_back(JSONNode("DBPort", s.DBPort));
	n.push_back(JSONNode("DBThread", s.DBThread));
	JSONNode jnode0;
	jnode0.set_name( "redisCfg");
	WriteToJson( s.redisCfg, jnode0 );
	n.push_back( jnode0 );
	n.push_back(JSONNode("LogFile", s.LogFile));
	n.push_back(JSONNode("LogSize", s.LogSize));
	n.push_back(JSONNode("TraceLevel", s.TraceLevel));
	n.push_back(JSONNode("StatLogFile", s.StatLogFile));
	n.push_back(JSONNode("StatLogSize", s.StatLogSize));
	n.push_back(JSONNode("SLSaveInterval", s.SLSaveInterval));
	n.push_back(JSONNode("PhysicsID", s.PhysicsID));
	n.push_back(JSONNode("AntiAddiction", s.AntiAddiction));
	n.push_back(JSONNode("MaxUser", s.MaxUser));
	n.push_back(JSONNode("StatusDBName", s.StatusDBName));
	n.push_back(JSONNode("RechargeKey", s.RechargeKey));
	n.push_back(JSONNode("SessionKey", s.SessionKey));
	JSONNode jnode1;
	jnode1.set_name( "business");
	WriteToJson( s.business, jnode1 );
	n.push_back( jnode1 );
	JSONNode jnode2;
	jnode2.set_name( "happy");
	WriteToJson( s.happy, jnode2 );
	n.push_back( jnode2 );
	JSONNode jnode3;
	jnode3.set_name( "war");
	WriteToJson( s.war, jnode3 );
	n.push_back( jnode3 );
	JSONNode jnode4;
	jnode4.set_name( "roleInit");
	WriteToJson( s.roleInit, jnode4 );
	n.push_back( jnode4 );
}


void WriteToJsonStr( const Ls::config& s,  std::string& str, bool bFormat)
{
	JSONNode n(JSON_NODE);
	WriteToJson( s, n );
	if (bFormat)
		str = n.write_formatted();
	else
		str = n.write();
}
void ReadFromJsonStr( Ls::config& s,  std::string& str)
{
	JSONNode n = libjson::parse(str);
	ReadFromJson( s, n );
}
bool ReadFromJson( Ls::Info& s,  const JSONNode& n )
{
	JSONNode::const_iterator i = n.begin();
	while (i != n.end()){
		// get the node name and value as a string
		std::string node_name = i -> name();
		if (node_name == "id"){
			s.id = i->as_int();
		}
		else if (node_name == "title"){
			s.title = i->as_string();
		}
		else if (node_name == "detail"){
			s.detail = i->as_string();
		}
		++i;
	}
	return true;
}
void WriteToJson( const Ls::Info& s,  JSONNode& n)
{
	n.push_back(JSONNode("id", s.id));
	n.push_back(JSONNode("title", s.title));
	n.push_back(JSONNode("detail", s.detail));
}


void WriteToJsonStr( const Ls::Info& s,  std::string& str, bool bFormat)
{
	JSONNode n(JSON_NODE);
	WriteToJson( s, n );
	if (bFormat)
		str = n.write_formatted();
	else
		str = n.write();
}
void ReadFromJsonStr( Ls::Info& s,  std::string& str)
{
	JSONNode n = libjson::parse(str);
	ReadFromJson( s, n );
}
bool ReadFromJson( Ls::LjzViewDetail& s,  const JSONNode& n )
{
	JSONNode::const_iterator i = n.begin();
	while (i != n.end()){
		// get the node name and value as a string
		std::string node_name = i -> name();
		++i;
	}
	return true;
}
void WriteToJson( const Ls::LjzViewDetail& s,  JSONNode& n)
{
}


void WriteToJsonStr( const Ls::LjzViewDetail& s,  std::string& str, bool bFormat)
{
	JSONNode n(JSON_NODE);
	WriteToJson( s, n );
	if (bFormat)
		str = n.write_formatted();
	else
		str = n.write();
}
void ReadFromJsonStr( Ls::LjzViewDetail& s,  std::string& str)
{
	JSONNode n = libjson::parse(str);
	ReadFromJson( s, n );
}

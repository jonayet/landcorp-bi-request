using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Web.Script.Services;


namespace BIAdmin
{
    public partial class Dependencies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
        public static string GetObjectType(string IncludeSelectAll, string IsSQLObject, string ExcludeSK_ObjectId)
        {
            DataTable dt = new DataTable("Record");
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Dependencies"].ConnectionString);
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "wsp_Dependency_DropDown_Data_Get";
            sqlCmd.CommandTimeout = 300;
            sqlCmd.Connection = sqlConn;

            SqlParameter pDropDownName = new SqlParameter("DropDownName", SqlDbType.NVarChar);
            pDropDownName.Value = "ObjectType";
            sqlCmd.Parameters.Add(pDropDownName);

            SqlParameter pIncludeSelectAll = new SqlParameter("IncludeSelectAll", SqlDbType.Bit);
            pIncludeSelectAll.Value = IncludeSelectAll;
            sqlCmd.Parameters.Add(pIncludeSelectAll);

            SqlParameter pIsSQLObject = new SqlParameter("IsSQLObject", SqlDbType.Bit);
            if (IsSQLObject.Length == 0)
            {
                pIsSQLObject.Value = DBNull.Value;
            }
            else
            {
                pIsSQLObject.Value = IsSQLObject;
            }
            sqlCmd.Parameters.Add(pIsSQLObject);

            SqlParameter pExcludeSK_ObjectId = new SqlParameter("ExcludeSK_ObjectId", SqlDbType.Int);
            if (ExcludeSK_ObjectId.Length == 0)
            {
                pExcludeSK_ObjectId.Value = 0;
            }
            else
            {
                pExcludeSK_ObjectId.Value = ExcludeSK_ObjectId;
            }
            sqlCmd.Parameters.Add(pExcludeSK_ObjectId);

            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
            da.Fill(dt);
            sqlConn.Close();
            sqlConn.Dispose();

            System.IO.StringWriter writer = new System.IO.StringWriter();
            dt.WriteXml(writer, XmlWriteMode.WriteSchema, false);
            return writer.ToString();
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
        public static string GetObjectServer(string ObjectType, string IncludeSelectAll, string ExcludeSK_ObjectId)
        {
            DataTable dt = new DataTable("Record");
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Dependencies"].ConnectionString);
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "wsp_Dependency_DropDown_Data_Get";
            sqlCmd.CommandTimeout = 300;
            sqlCmd.Connection = sqlConn;

            SqlParameter pDropDownName = new SqlParameter("DropDownName", SqlDbType.NVarChar);
            pDropDownName.Value = "ObjectServer";
            sqlCmd.Parameters.Add(pDropDownName);

            SqlParameter pObjectType = new SqlParameter("ObjectType", SqlDbType.NVarChar);
            if (ObjectType == null || ObjectType == "")
            {
                pObjectType.Value = DBNull.Value;
            }
            else
            {
                pObjectType.Value = ObjectType;
            }

            sqlCmd.Parameters.Add(pObjectType);

            SqlParameter pIncludeSelectAll = new SqlParameter("IncludeSelectAll", SqlDbType.Bit);
            pIncludeSelectAll.Value = IncludeSelectAll;
            sqlCmd.Parameters.Add(pIncludeSelectAll);

            SqlParameter pExcludeSK_ObjectId = new SqlParameter("ExcludeSK_ObjectId", SqlDbType.Int);
            if (ExcludeSK_ObjectId.Length == 0)
            {
                pExcludeSK_ObjectId.Value = 0;
            }
            else
            {
                pExcludeSK_ObjectId.Value = ExcludeSK_ObjectId;
            }
            sqlCmd.Parameters.Add(pExcludeSK_ObjectId);

            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
            da.Fill(dt);
            sqlConn.Close();
            sqlConn.Dispose();

            System.IO.StringWriter writer = new System.IO.StringWriter();
            dt.WriteXml(writer, XmlWriteMode.WriteSchema, false);
            return writer.ToString();
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
        public static string GetObjectCatalog(string ObjectType, string ObjectServer, string IncludeSelectAll, string ExcludeSK_ObjectId)
        {
            DataTable dt = new DataTable("Record");
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Dependencies"].ConnectionString);
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "wsp_Dependency_DropDown_Data_Get";
            sqlCmd.CommandTimeout = 300;
            sqlCmd.Connection = sqlConn;

            SqlParameter pDropDownName = new SqlParameter("DropDownName", SqlDbType.NVarChar);
            pDropDownName.Value = "ObjectCatalog";
            sqlCmd.Parameters.Add(pDropDownName);

            SqlParameter pObjectType = new SqlParameter("ObjectType", SqlDbType.NVarChar);
            if (ObjectType == null || ObjectType == "")
            {
                pObjectType.Value = DBNull.Value;
            }
            else
            {
                pObjectType.Value = ObjectType;
            }
            sqlCmd.Parameters.Add(pObjectType);

            SqlParameter pObjectServer = new SqlParameter("ObjectServer", SqlDbType.NVarChar);
            if (ObjectServer == null || ObjectServer == "")
            {
                pObjectServer.Value = DBNull.Value;
            }
            else
            {
                pObjectServer.Value = ObjectServer;
            }

            sqlCmd.Parameters.Add(pObjectServer);

            SqlParameter pIncludeSelectAll = new SqlParameter("IncludeSelectAll", SqlDbType.Bit);
            pIncludeSelectAll.Value = IncludeSelectAll;
            sqlCmd.Parameters.Add(pIncludeSelectAll);

            SqlParameter pExcludeSK_ObjectId = new SqlParameter("ExcludeSK_ObjectId", SqlDbType.Int);
            if (ExcludeSK_ObjectId.Length == 0)
            {
                pExcludeSK_ObjectId.Value = 0;
            }
            else
            {
                pExcludeSK_ObjectId.Value = ExcludeSK_ObjectId;
            }
            sqlCmd.Parameters.Add(pExcludeSK_ObjectId);

            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
            da.Fill(dt);
            sqlConn.Close();
            sqlConn.Dispose();

            System.IO.StringWriter writer = new System.IO.StringWriter();
            dt.WriteXml(writer, XmlWriteMode.WriteSchema, false);
            return writer.ToString();
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
        public static string GetObjectSchema(string ObjectType, string ObjectServer, string ObjectCatalog, string IncludeSelectAll, string ExcludeSK_ObjectId)
        {
            DataTable dt = new DataTable("Record");
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Dependencies"].ConnectionString);
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "wsp_Dependency_DropDown_Data_Get";
            sqlCmd.CommandTimeout = 300;
            sqlCmd.Connection = sqlConn;

            SqlParameter pDropDownName = new SqlParameter("DropDownName", SqlDbType.NVarChar);
            pDropDownName.Value = "ObjectSchema";
            sqlCmd.Parameters.Add(pDropDownName);

            SqlParameter pObjectType = new SqlParameter("ObjectType", SqlDbType.NVarChar);
            if (ObjectType == null || ObjectType == "")
            {
                pObjectType.Value = DBNull.Value;
            }
            else
            {
                pObjectType.Value = ObjectType;
            }
            sqlCmd.Parameters.Add(pObjectType);

            SqlParameter pObjectServer = new SqlParameter("ObjectServer", SqlDbType.NVarChar);
            if (ObjectServer == null || ObjectServer == "")
            {
                pObjectServer.Value = DBNull.Value;
            }
            else
            {
                pObjectServer.Value = ObjectServer;
            }
            sqlCmd.Parameters.Add(pObjectServer);

            SqlParameter pObjectCatalog = new SqlParameter("ObjectCatalog", SqlDbType.NVarChar);
            if (ObjectCatalog == null || ObjectCatalog == "")
            {
                pObjectCatalog.Value = DBNull.Value;
            }
            else
            {
                pObjectCatalog.Value = ObjectCatalog;
            }
            sqlCmd.Parameters.Add(pObjectCatalog);

            SqlParameter pIncludeSelectAll = new SqlParameter("IncludeSelectAll", SqlDbType.Bit);
            pIncludeSelectAll.Value = IncludeSelectAll;
            sqlCmd.Parameters.Add(pIncludeSelectAll);

            SqlParameter pExcludeSK_ObjectId = new SqlParameter("ExcludeSK_ObjectId", SqlDbType.Int);
            if (ExcludeSK_ObjectId.Length == 0)
            {
                pExcludeSK_ObjectId.Value = 0;
            }
            else
            {
                pExcludeSK_ObjectId.Value = ExcludeSK_ObjectId;
            }
            sqlCmd.Parameters.Add(pExcludeSK_ObjectId);

            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
            da.Fill(dt);
            sqlConn.Close();
            sqlConn.Dispose();

            System.IO.StringWriter writer = new System.IO.StringWriter();
            dt.WriteXml(writer, XmlWriteMode.WriteSchema, false);
            return writer.ToString();
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
        public static string GetObjectName(string ObjectType, string ObjectServer, string ObjectCatalog, string ObjectSchema, string IncludeSelectAll, string ExcludeSK_ObjectId)
        {
            DataTable dt = new DataTable("Record");
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Dependencies"].ConnectionString);
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "wsp_Dependency_DropDown_Data_Get";
            sqlCmd.CommandTimeout = 300;
            sqlCmd.Connection = sqlConn;

            SqlParameter pDropDownName = new SqlParameter("DropDownName", SqlDbType.NVarChar);
            pDropDownName.Value = "ObjectName";
            sqlCmd.Parameters.Add(pDropDownName);

            SqlParameter pObjectType = new SqlParameter("ObjectType", SqlDbType.NVarChar);
            if (ObjectType == null || ObjectType == "")
            {
                pObjectType.Value = DBNull.Value;
            }
            else
            {
                pObjectType.Value = ObjectType;
            }
            sqlCmd.Parameters.Add(pObjectType);

            SqlParameter pObjectServer = new SqlParameter("ObjectServer", SqlDbType.NVarChar);
            if (ObjectServer == null || ObjectServer == "")
            {
                pObjectServer.Value = DBNull.Value;
            }
            else
            {
                pObjectServer.Value = ObjectServer;
            }
            sqlCmd.Parameters.Add(pObjectServer);

            SqlParameter pObjectCatalog = new SqlParameter("ObjectCatalog", SqlDbType.NVarChar);
            if (ObjectCatalog == null || ObjectCatalog == "")
            {
                pObjectCatalog.Value = DBNull.Value;
            }
            else
            {
                pObjectCatalog.Value = ObjectCatalog;
            }
            sqlCmd.Parameters.Add(pObjectCatalog);

            SqlParameter pObjectSchema = new SqlParameter("ObjectSchema", SqlDbType.NVarChar);
            if (ObjectSchema == null || ObjectSchema == "")
            {
                pObjectSchema.Value = DBNull.Value;
            }
            else
            {
                pObjectSchema.Value = ObjectSchema;
            }
            sqlCmd.Parameters.Add(pObjectSchema);

            SqlParameter pIncludeSelectAll = new SqlParameter("IncludeSelectAll", SqlDbType.Bit);
            pIncludeSelectAll.Value = IncludeSelectAll;
            sqlCmd.Parameters.Add(pIncludeSelectAll);

            SqlParameter pExcludeSK_ObjectId = new SqlParameter("ExcludeSK_ObjectId", SqlDbType.Int);
            if (ExcludeSK_ObjectId.Length == 0)
            {
                pExcludeSK_ObjectId.Value = 0;
            }
            else
            {
                pExcludeSK_ObjectId.Value = ExcludeSK_ObjectId;
            }
            sqlCmd.Parameters.Add(pExcludeSK_ObjectId);

            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
            da.Fill(dt);
            sqlConn.Close();
            sqlConn.Dispose();

            System.IO.StringWriter writer = new System.IO.StringWriter();
            dt.WriteXml(writer, XmlWriteMode.WriteSchema, false);
            return writer.ToString();
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
        public static string GetData(string ObjectType, string ObjectServer, string ObjectCatalog, string ObjectSchema)
        {
            DataTable dt = new DataTable("Record");
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Dependencies"].ConnectionString);
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "wsp_Dependency_Data_Get";
            sqlCmd.CommandTimeout = 300;
            sqlCmd.Connection = sqlConn;

            SqlParameter pObjectType = new SqlParameter("ObjectType", SqlDbType.NVarChar);
            if (ObjectType == null || ObjectType == "")
            {
                pObjectType.Value = DBNull.Value;
            }
            else
            {
                pObjectType.Value = ObjectType;
            }
            sqlCmd.Parameters.Add(pObjectType);

            SqlParameter pObjectServer = new SqlParameter("ObjectServer", SqlDbType.NVarChar);
            if (ObjectServer == null || ObjectServer == "")
            {
                pObjectServer.Value = DBNull.Value;
            }
            else
            {
                pObjectServer.Value = ObjectServer;
            }
            sqlCmd.Parameters.Add(pObjectServer);

            SqlParameter pObjectCatalog = new SqlParameter("ObjectCatalog", SqlDbType.NVarChar);
            if (ObjectCatalog == null || ObjectCatalog == "")
            {
                pObjectCatalog.Value = DBNull.Value;
            }
            else
            {
                pObjectCatalog.Value = ObjectCatalog;
            }
            sqlCmd.Parameters.Add(pObjectCatalog);

            SqlParameter pObjectSchema = new SqlParameter("ObjectSchema", SqlDbType.NVarChar);
            if (ObjectSchema == null || ObjectSchema == "")
            {
                pObjectSchema.Value = DBNull.Value;
            }
            else
            {
                pObjectSchema.Value = ObjectSchema;
            }
            sqlCmd.Parameters.Add(pObjectSchema);

            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
            da.Fill(dt);
            sqlConn.Close();
            sqlConn.Dispose();

            System.IO.StringWriter writer = new System.IO.StringWriter();
            dt.WriteXml(writer, XmlWriteMode.WriteSchema, false);
            return writer.ToString();
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
        public static string GetRecordData(string SK_ObjectId)
        {
            DataTable dt = new DataTable("Record");
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Dependencies"].ConnectionString);
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "wsp_Dependency_Data_Get";
            sqlCmd.CommandTimeout = 300;
            sqlCmd.Connection = sqlConn;

            SqlParameter pSK_ObjectId = new SqlParameter("SK_ObjectId", SqlDbType.Int);
            pSK_ObjectId.Value = SK_ObjectId;
            sqlCmd.Parameters.Add(pSK_ObjectId);

            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
            da.Fill(dt);
            sqlConn.Close();
            sqlConn.Dispose();

            System.IO.StringWriter writer = new System.IO.StringWriter();
            dt.WriteXml(writer, XmlWriteMode.WriteSchema, false);
            return writer.ToString();
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Xml)]
        public static string GetDependencies(string SK_ObjectId, string Direction, string Flatten, string MaxDepth)
        {
            DataTable dt = new DataTable("Record");
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Dependencies"].ConnectionString);
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "wsp_Dependency_Dependencies_Get";
            sqlCmd.CommandTimeout = 300;
            sqlCmd.Connection = sqlConn;

            SqlParameter pSK_ObjectId = new SqlParameter("SK_ObjectId", SqlDbType.Int);
            pSK_ObjectId.Value = SK_ObjectId;
            sqlCmd.Parameters.Add(pSK_ObjectId);

            SqlParameter pDirection = new SqlParameter("Direction", SqlDbType.NVarChar);
            pDirection.Value = Direction;
            sqlCmd.Parameters.Add(pDirection);

            SqlParameter pFlatten = new SqlParameter("Flatten", SqlDbType.Bit);
            pFlatten.Value = Flatten;
            sqlCmd.Parameters.Add(pFlatten);

            SqlParameter pMaxDepth = new SqlParameter("MaxDepth", SqlDbType.NVarChar);
            pMaxDepth.Value = MaxDepth;
            sqlCmd.Parameters.Add(pMaxDepth);

            sqlConn.Open();
            SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
            da.Fill(dt);
            sqlConn.Close();
            sqlConn.Dispose();

            System.IO.StringWriter writer = new System.IO.StringWriter();
            dt.WriteXml(writer, XmlWriteMode.WriteSchema, false);
            return writer.ToString();
        }

        [WebMethod]
        public static string SaveObject(string SK_ObjectId, string IsSQLObject, string ObjectType, string ObjectServer, string ObjectCatalog, string ObjectSchema, string ObjectName, string UserId)
        {
            string returnSK_ObjectId = "0";

            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Dependencies"].ConnectionString);
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "wsp_Dependency_Object_Save";
            sqlCmd.CommandTimeout = 300;
            sqlCmd.Connection = sqlConn;

            SqlParameter pSK_ObjectId = new SqlParameter("@SK_ObjectId", SqlDbType.Int);
            SqlParameter pIsSQLObject = new SqlParameter("@IsSQLObject", SqlDbType.Bit);
            SqlParameter pObjectType = new SqlParameter("@ObjectType", SqlDbType.NVarChar);
            SqlParameter pObjectServer = new SqlParameter("@ObjectServer", SqlDbType.NVarChar);
            SqlParameter pObjectCatalog = new SqlParameter("@ObjectCatalog", SqlDbType.NVarChar);
            SqlParameter pObjectSchema = new SqlParameter("@ObjectSchema", SqlDbType.NVarChar);
            SqlParameter pObjectName = new SqlParameter("@ObjectName", SqlDbType.NVarChar);
            SqlParameter pUserId = new SqlParameter("@UserId", SqlDbType.Int);

            pSK_ObjectId.Value = SK_ObjectId;
            pIsSQLObject.Value = IsSQLObject;
            pObjectType.Value = ObjectType;

            if (ObjectServer == "")
            {
                pObjectServer.Value = DBNull.Value;
            }
            else
            {
                pObjectServer.Value = ObjectServer;
            }

            if (ObjectCatalog == "")
            {
                pObjectCatalog.Value = DBNull.Value;
            }
            else
            {
                pObjectCatalog.Value = ObjectCatalog;
            }

            if (ObjectSchema == "")
            {
                pObjectSchema.Value = DBNull.Value;
            }
            else
            {
                pObjectSchema.Value = ObjectSchema;
            }

            if (ObjectName == "")
            {
                pObjectName.Value = DBNull.Value;
            }
            else
            {
                pObjectName.Value = ObjectName;
            }

            pUserId.Value = UserId;

            sqlCmd.Parameters.Add(pSK_ObjectId);
            sqlCmd.Parameters.Add(pIsSQLObject);
            sqlCmd.Parameters.Add(pObjectType);
            sqlCmd.Parameters.Add(pObjectServer);
            sqlCmd.Parameters.Add(pObjectCatalog);
            sqlCmd.Parameters.Add(pObjectSchema);
            sqlCmd.Parameters.Add(pObjectName);
            sqlCmd.Parameters.Add(pUserId);

            sqlConn.Open();
            returnSK_ObjectId = sqlCmd.ExecuteScalar().ToString();
            sqlConn.Close();
            sqlConn.Dispose();

            return returnSK_ObjectId;
        }

        [WebMethod]
        public static string DeleteObject(string SK_ObjectId)
        {
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Dependencies"].ConnectionString);
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "wsp_Dependency_Object_Delete";
            sqlCmd.CommandTimeout = 300;
            sqlCmd.Connection = sqlConn;

            SqlParameter pSK_ObjectId = new SqlParameter("@SK_ObjectId", SqlDbType.Int);
            pSK_ObjectId.Value = SK_ObjectId;
            sqlCmd.Parameters.Add(pSK_ObjectId);

            sqlConn.Open();
            sqlCmd.ExecuteNonQuery();
            sqlConn.Close();
            sqlConn.Dispose();

            return "Deleted";
        }

        [WebMethod]
        public static string DeleteDependancy(string SK_DependencyId)
        {
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Dependencies"].ConnectionString);
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "wsp_Dependency_Object_Dependancy_Delete";
            sqlCmd.CommandTimeout = 300;
            sqlCmd.Connection = sqlConn;

            SqlParameter pSK_DependencyId = new SqlParameter("@SK_DependencyId", SqlDbType.Int);
            pSK_DependencyId.Value = SK_DependencyId;
            sqlCmd.Parameters.Add(pSK_DependencyId);

            sqlConn.Open();
            sqlCmd.ExecuteNonQuery();
            sqlConn.Close();
            sqlConn.Dispose();

            return "Deleted";
        }

        [WebMethod]
        public static string SaveDependancy(string SK_DependencyId, string Direction, string SK_ObjectId, string ObjectType, string ObjectServer, string ObjectCatalog, string ObjectSchema, string ObjectName, string HasTrigger, string TriggerObjectType, string TriggerObjectServer, string TriggerObjectCatalog, string TriggerObjectSchema, string TriggerObjectName, string UserId)
        {
            SqlConnection sqlConn = new SqlConnection(ConfigurationManager.ConnectionStrings["Dependencies"].ConnectionString);
            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "wsp_Dependency_Object_Dependancy_Save";
            sqlCmd.CommandTimeout = 300;
            sqlCmd.Connection = sqlConn;

            SqlParameter pSK_DependencyId = new SqlParameter("@SK_DependencyId", SqlDbType.Int);
            SqlParameter pDirection = new SqlParameter("@Direction", SqlDbType.NVarChar);
            SqlParameter pSK_ObjectId = new SqlParameter("@SK_ObjectId", SqlDbType.Int);
            SqlParameter pObjectType = new SqlParameter("@ObjectType", SqlDbType.NVarChar);
            SqlParameter pObjectServer = new SqlParameter("@ObjectServer", SqlDbType.NVarChar);
            SqlParameter pObjectCatalog = new SqlParameter("@ObjectCatalog", SqlDbType.NVarChar);
            SqlParameter pObjectSchema = new SqlParameter("@ObjectSchema", SqlDbType.NVarChar);
            SqlParameter pObjectName = new SqlParameter("@ObjectName", SqlDbType.NVarChar);

            SqlParameter pHasTrigger = new SqlParameter("@HasTrigger", SqlDbType.Bit);
            SqlParameter pTriggerObjectType = new SqlParameter("@TriggerObjectType", SqlDbType.NVarChar);
            SqlParameter pTriggerObjectServer = new SqlParameter("@TriggerObjectServer", SqlDbType.NVarChar);
            SqlParameter pTriggerObjectCatalog = new SqlParameter("@TriggerObjectCatalog", SqlDbType.NVarChar);
            SqlParameter pTriggerObjectSchema = new SqlParameter("@TriggerObjectSchema", SqlDbType.NVarChar);
            SqlParameter pTriggerObjectName = new SqlParameter("@TriggerObjectName", SqlDbType.NVarChar);

            SqlParameter pUserId = new SqlParameter("@UserId", SqlDbType.Int);

            pSK_DependencyId.Value = SK_DependencyId;
            pDirection.Value = Direction;
            pSK_ObjectId.Value = SK_ObjectId;
            pObjectType.Value = ObjectType;
            pObjectServer.Value = ObjectServer;
            pObjectCatalog.Value = ObjectCatalog;
            pObjectSchema.Value = ObjectSchema;
            pObjectName.Value = ObjectName;

            pHasTrigger.Value = HasTrigger;
            pTriggerObjectType.Value = TriggerObjectType;
            pTriggerObjectServer.Value = TriggerObjectServer;
            pTriggerObjectCatalog.Value = TriggerObjectCatalog;
            pTriggerObjectSchema.Value = TriggerObjectSchema;
            pTriggerObjectName.Value = TriggerObjectName;

            pUserId.Value = UserId;

            sqlCmd.Parameters.Add(pSK_DependencyId);
            sqlCmd.Parameters.Add(pDirection);
            sqlCmd.Parameters.Add(pSK_ObjectId);
            sqlCmd.Parameters.Add(pObjectType);
            sqlCmd.Parameters.Add(pObjectServer);
            sqlCmd.Parameters.Add(pObjectCatalog);
            sqlCmd.Parameters.Add(pObjectSchema);
            sqlCmd.Parameters.Add(pObjectName);

            sqlCmd.Parameters.Add(pHasTrigger);
            sqlCmd.Parameters.Add(pTriggerObjectType);
            sqlCmd.Parameters.Add(pTriggerObjectServer);
            sqlCmd.Parameters.Add(pTriggerObjectCatalog);
            sqlCmd.Parameters.Add(pTriggerObjectSchema);
            sqlCmd.Parameters.Add(pTriggerObjectName);

            sqlCmd.Parameters.Add(pUserId);

            sqlConn.Open();
            sqlCmd.ExecuteNonQuery();
            sqlConn.Close();
            sqlConn.Dispose();

            return "Saved";
        }
    }
}
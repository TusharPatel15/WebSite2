using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Script.Serialization;

using System.Data.SqlClient;
using System.Web.Services;
using Newtonsoft.Json;

public partial class _Default : System.Web.UI.Page
{
  
    protected void Page_Load(object sender, EventArgs e)
    {
        //DataTable dt = new DataTable();

        //dt.Columns.Add("ID");
        //dt.Columns.Add("FirstName");
        //dt.Columns.Add("LastName");
        //dt.Columns.Add("City");
        //dt.Columns.Add("EmailID");
        

        ////dt.Columns.Add("View");   
        //dt.Rows.Add();
        //grdDatatable.DataSource = dt;
        //grdDatatable.DataBind();
      

        //return dt;
    }


    [WebMethod]
    public static string BindDatatable()
    {
        DataTable dt = new DataTable();
        dt.Clear();
        dt.Columns.Add("ID");
        dt.Columns.Add("FirstName");
        dt.Columns.Add("LastName");
        dt.Columns.Add("City");
        dt.Columns.Add("EmailID");
     
        //Creating object to to newrow to add to datatable
        //DataRow NewRowObj = dt.NewRow();
        //NewRowObj["Id"] = "1";
        //NewRowObj["EmpName"] = "Kaviyarasan";
        //NewRowObj["DailyAllowance"] = "500";
        //NewRowObj["Salary"] = "52000";
        //dt.Rows.Add(NewRowObj);

        //NewRowObj = dt.NewRow();
        //NewRowObj["Id"] = "2";
        //NewRowObj["EmpName"] = "Ramkumar";
        //NewRowObj["DailyAllowance"] = "600";
        //NewRowObj["Salary"] = "16000";
        //dt.Rows.Add(NewRowObj);

        //NewRowObj = dt.NewRow();
        //NewRowObj["Id"] = "3";
        //NewRowObj["EmpName"] = "Kannadasan";
        //NewRowObj["DailyAllowance"] = "700";
        //NewRowObj["Salary"] = "37000";
        //dt.Rows.Add(NewRowObj);

        //NewRowObj = dt.NewRow();
        //NewRowObj["Id"] = "4";
        //NewRowObj["EmpName"] = "Xavier";
        //NewRowObj["DailyAllowance"] = "800";
        //NewRowObj["Salary"] = "82000";
        //dt.Rows.Add(NewRowObj);

        //NewRowObj = dt.NewRow();
        //NewRowObj["Id"] = "5";
        //NewRowObj["EmpName"] = "Murugan";
        //NewRowObj["DailyAllowance"] = "1000";
        //NewRowObj["Salary"] = "90000";
        //dt.Rows.Add(NewRowObj);
        string constring = @"Data Source=EDI-2;Initial Catalog=DBEmployee;Integrated Security=True";
        using (SqlConnection con = new SqlConnection(constring))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM TblSample", con))
            {
                cmd.CommandType = CommandType.Text;
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt1 = new DataTable())
                    {
                        sda.Fill(dt);
                        
                    }
                }
            }
        }
    
        
        dt.AcceptChanges();
        
        //Binding Datatable to grid view
        //a grdDatatable.DataSource = dt;
        //a grdDatatable.DataBind();

        //a dvJasonData.InnerText = GetJson(dt);
        return GetJson(dt);
    }

    //Method to convert Datatable to JSON array
    public static string GetJson(DataTable dt)
    {
        JavaScriptSerializer JSSerializer = new JavaScriptSerializer();
        List<Dictionary<string, object>> DtRows = new List<Dictionary<string, object>>();
        Dictionary<string, object> newrow = null;

        //Code to loop each row in the datatable and add it to the dictionary object
        foreach (DataRow drow in dt.Rows)
        {
            newrow = new Dictionary<string, object>();
            foreach (DataColumn col in dt.Columns)
            {
                newrow.Add(col.ColumnName.Trim(), drow[col]);
            }
            DtRows.Add(newrow);
        }

        //Serialising the dictionary object to produce json output
        return JSSerializer.Serialize(DtRows);
    }
    [WebMethod]
    public static void DeleteRecord(string ID)
    {
        string constring = @"Data Source=EDI-2;Initial Catalog=DBEmployee;Integrated Security=True";
        using (SqlConnection con = new SqlConnection(constring))
        {
            using (SqlCommand cmd = new SqlCommand("delete from TblSample where ID=@ID ", con))
                
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@ID", ID);
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt1 = new DataTable())
                    {
                        sda.Fill(dt1);

                    }
                }
            }
        }
    }
    [WebMethod]
    public static void SaveData(string FirstName,string LastName,string City,string EmailID)
    {
        string constring = @"Data Source=EDI-2;Initial Catalog=DBEmployee;Integrated Security=True";
        using (SqlConnection con = new SqlConnection(constring))
        {
            using (SqlCommand cmd = new SqlCommand("INSERT INTO TblSample VALUES(@FirstName, @LastName, @City, @EmailID)"))
            {
                cmd.CommandType = CommandType.Text;
                //cmd.Parameters.AddWithValue("@ID", ID);
                cmd.Parameters.AddWithValue("@FirstName", FirstName);
                cmd.Parameters.AddWithValue("@LastName", LastName);
                cmd.Parameters.AddWithValue("@City", City);
                cmd.Parameters.AddWithValue("@EmailID", EmailID);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

    }
}
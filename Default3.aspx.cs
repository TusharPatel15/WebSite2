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

public partial class Default3 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();

        dt.Columns.Add("ID");
        dt.Columns.Add("EmpName");
        dt.Columns.Add("DailyAllowance");
        dt.Columns.Add("Salary");


        //dt.Columns.Add("View");   
        dt.Rows.Add();
        grdDatatable.DataSource = dt;
        grdDatatable.DataBind();
    }
    [WebMethod]
    public static string BindDatatable()
    {
        DataTable dt = new DataTable();
        dt.Clear();
        dt.Columns.Add("Id");
        dt.Columns.Add("EmpName");
        dt.Columns.Add("DailyAllowance");
        dt.Columns.Add("Salary");

        //Creating object to to newrow to add to datatable
        DataRow NewRowObj = dt.NewRow();
        NewRowObj["Id"] = "1";
        NewRowObj["EmpName"] = "Kaviyarasan";
        NewRowObj["DailyAllowance"] = "500";
        NewRowObj["Salary"] = "52000";
        dt.Rows.Add(NewRowObj);

        NewRowObj = dt.NewRow();
        NewRowObj["Id"] = "2";
        NewRowObj["EmpName"] = "Ramkumar";
        NewRowObj["DailyAllowance"] = "600";
        NewRowObj["Salary"] = "16000";
        dt.Rows.Add(NewRowObj);

        NewRowObj = dt.NewRow();
        NewRowObj["Id"] = "3";
        NewRowObj["EmpName"] = "Kannadasan";
        NewRowObj["DailyAllowance"] = "700";
        NewRowObj["Salary"] = "37000";
        dt.Rows.Add(NewRowObj);

        NewRowObj = dt.NewRow();
        NewRowObj["Id"] = "4";
        NewRowObj["EmpName"] = "Xavier";
        NewRowObj["DailyAllowance"] = "800";
        NewRowObj["Salary"] = "82000";
        dt.Rows.Add(NewRowObj);

        NewRowObj = dt.NewRow();
        NewRowObj["Id"] = "5";
        NewRowObj["EmpName"] = "Murugan";
        NewRowObj["DailyAllowance"] = "1000";
        NewRowObj["Salary"] = "90000";
        dt.Rows.Add(NewRowObj);

        //To commit changes to datatable
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
}
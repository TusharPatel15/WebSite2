using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Configuration;
using System.Web.Script.Serialization;
using Newtonsoft.Json;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindColumnToGridview();
        }
    }
    /// <summary>
    /// This method is used to bind dummy row to gridview to bind data using JQuery
    /// </summary>
   
    protected void BindColumnToGridview()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("ID");
        dt.Columns.Add("First Name");
        dt.Columns.Add("Last Name");
        dt.Columns.Add("City");
        dt.Columns.Add("Email ID");
        
        //dt.Columns.Add("View");   
        dt.Rows.Add();
        //gvDetails.DataSource = dt;
        //gvDetails.DataBind();
        //gvDetails.Rows[0].Visible = false;

        //return dt;
        
    }

    [WebMethod]
    public static List<UserDetails> BindDatatable()
    {
       
        DataTable dt = new DataTable();

        dt.Columns.Add("ID");
        dt.Columns.Add("FirstName");
        dt.Columns.Add("LastName");
        dt.Columns.Add("City");
        dt.Columns.Add("EmailID");

        //dt.Rows.Add();


        List<UserDetails> details = new List<UserDetails>();

        string connectionstring = ConfigurationManager.ConnectionStrings["conString"].ToString();
        using (SqlConnection con = new SqlConnection(connectionstring))
        {
            using (SqlCommand cmd = new SqlCommand("select * from TblSample", con))
            {
                //con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    UserDetails user = new UserDetails();
                    user.ID = dtrow["ID"].ToString();
                    user.FirstName = dtrow["FirstName"].ToString();
                    user.LastName = dtrow["LastName"].ToString();
                    user.City = dtrow["City"].ToString();
                    user.EmailID = dtrow["EmailID"].ToString();
                    details.Add(user);
                }
            }
        }

        return details;
       
        //JavaScriptSerializer jss = new JavaScriptSerializer();

        //string output = jss.Serialize(details);
       
        //return output;//details.ToArray();
        

        
       

        
    }
    [Serializable]
    public class UserDetails
    {
        public string ID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string City { get; set; }
        public string EmailID { get; set; }
    }
}

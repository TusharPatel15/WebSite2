using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Web.Script.Services;

public partial class CS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            BindColumnToGridview();
            //string constr = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            //using (SqlConnection con = new SqlConnection(constr))
            //{
            //    using (SqlCommand cmd = new SqlCommand("SELECT * FROM TblSample"))
            //    {
            //        using (SqlDataAdapter sda = new SqlDataAdapter())
            //        {
            //            DataTable dt = new DataTable();
            //            cmd.CommandType = CommandType.Text;
            //            cmd.Connection = con;
            //            sda.SelectCommand = cmd;
            //            sda.Fill(dt);
            //            gvUsers.DataSource = dt;
            //            gvUsers.DataBind();
            //        }
            //    }
            //}
        }
    }

    private void BindColumnToGridview()
    {
        DataTable dt = new DataTable();
        //dt.Columns.Add("ID");
        dt.Columns.Add("First Name");
        dt.Columns.Add("Last Name");
        dt.Columns.Add("City");
        dt.Columns.Add("Email ID");
        dt.Rows.Add();
        gvUsers.DataSource = dt;
        gvUsers.DataBind();
        gvUsers.Rows[0].Visible = false;
    }

    [WebMethod]
    [ScriptMethod]
    public static void SaveUser(User user)
    {
        string constr = ConfigurationManager.ConnectionStrings["conString"].ToString();
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("INSERT INTO TblSample VALUES(@FName, @LName, @City, @Email)"))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@FName", user.FirstName);
                cmd.Parameters.AddWithValue("@LName", user.LastName);
                cmd.Parameters.AddWithValue("@City", user.City);
                cmd.Parameters.AddWithValue("@Email", user.EmailID);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
    }

    [WebMethod]
    public static User[] BindDatatable()
    {
        DataTable dt = new DataTable();
        List<User> details = new List<User>();

        string connectionstring = ConfigurationManager.ConnectionStrings["conString"].ToString();
        using (SqlConnection con = new SqlConnection(connectionstring))
        {
            using (SqlCommand cmd = new SqlCommand("select * from TblSample", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    User user = new User();
                    //user.ID = dtrow["ID"].ToString();
                    user.FirstName = dtrow["FirstName"].ToString();
                    user.LastName = dtrow["LastName"].ToString();
                    user.City = dtrow["City"].ToString();
                    user.EmailID = dtrow["EmailID"].ToString();
                    details.Add(user);
                }
            }
        }
        return details.ToArray();
    }
}
public class User
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string City { get; set; }
    public string EmailID { get; set; }
}

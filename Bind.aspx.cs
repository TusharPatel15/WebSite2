using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Bind : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public static UserDetails[] BindDatatable()
    {
        DataTable dt = new DataTable();
        List<UserDetails> details = new List<UserDetails>();

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
        return details.ToArray();
    }
    public class UserDetails
    {
        public string ID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string City { get; set; }
        public string EmailID { get; set; }
    }
}